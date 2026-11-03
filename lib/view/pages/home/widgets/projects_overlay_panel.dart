import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/model/models/project.dart';
import 'package:turskyi/presenter/home_presenter.dart';
import 'package:turskyi/view/pages/home/widgets/project_tile.dart';
import 'package:turskyi/view/pages/home/widgets/visible_project_entry.dart';

class ProjectsOverlayPanel extends StatefulWidget {
  const ProjectsOverlayPanel({
    required this.showProjects,
    required this.controller,
    required this.slideAnimation,
    required this.onDismiss,
    required this.onProjectsHidden,
    required this.allProjects,
    super.key,
  });

  final bool showProjects;
  final AnimationController controller;
  final Animation<Offset> slideAnimation;
  final VoidCallback onDismiss;
  final VoidCallback onProjectsHidden;
  final List<Project> allProjects;

  @override
  State<ProjectsOverlayPanel> createState() => _ProjectsOverlayPanelState();
}

class _ProjectsOverlayPanelState extends State<ProjectsOverlayPanel> {
  static const Duration _itemAnimationDuration = Duration(milliseconds: 450);
  static const Duration _itemInsertDelay = Duration(milliseconds: 150);

  final List<VisibleProjectEntry> _visibleProjects = <VisibleProjectEntry>[];
  bool _isProcessingVisibility = false;

  @override
  void initState() {
    super.initState();
    if (widget.showProjects) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          try {
            context.read<HomePresenter>().loadRankings();
          } catch (e, stackTrace) {
            if (kDebugMode) {
              debugPrint('Error triggering loadRankings in initState: $e');
              debugPrint('StackTrace: $stackTrace');
            }
          }
          _processVisibilityChanges();
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant final ProjectsOverlayPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showProjects != oldWidget.showProjects) {
      if (widget.showProjects) {
        try {
          context.read<HomePresenter>().loadRankings();
        } catch (e, stackTrace) {
          if (kDebugMode) {
            debugPrint('Error triggering loadRankings in didUpdateWidget: $e');
            debugPrint('StackTrace: $stackTrace');
          }
        }
      }
      _processVisibilityChanges();
    } else if (widget.showProjects &&
        widget.allProjects != oldWidget.allProjects) {
      setState(() {
        final Map<String, Project> newProjectMap = <String, Project>{
          for (final Project p in widget.allProjects) p.id: p,
        };
        for (int i = 0; i < _visibleProjects.length; i++) {
          final VisibleProjectEntry entry = _visibleProjects[i];
          final Project? updated = newProjectMap[entry.project.id];
          if (updated != null) {
            _visibleProjects[i] = entry.copyWith(project: updated);
          }
        }
        _visibleProjects.sort((
          final VisibleProjectEntry a,
          final VisibleProjectEntry b,
        ) {
          final int indexA = widget.allProjects.indexWhere(
            (final Project p) => p.id == a.project.id,
          );
          final int indexB = widget.allProjects.indexWhere(
            (final Project p) => p.id == b.project.id,
          );
          return indexA.compareTo(indexB);
        });
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        ignoring: !widget.showProjects,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: widget.onDismiss,
              child: AnimatedContainer(
                duration: const Duration(seconds: 2),
                color: widget.showProjects
                    ? Colors.black.withAlpha(200)
                    : Colors.transparent,
              ),
            ),
            AnimatedBuilder(
              animation: widget.controller,
              builder: (BuildContext _, Widget? _) {
                return Opacity(
                  opacity: widget.controller.value,
                  child: SlideTransition(
                    position: widget.slideAnimation,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 300,
                        color: Colors.transparent,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80.0),
                          itemCount: _visibleProjects.length,
                          itemBuilder: (BuildContext _, final int index) {
                            final VisibleProjectEntry entry =
                                _visibleProjects[index];
                            return TweenAnimationBuilder<double>(
                              key: ValueKey<String>(entry.project.id),
                              tween: Tween<double>(
                                end: entry.isVisible ? 1 : 0,
                              ),
                              duration: _itemAnimationDuration,
                              curve: Curves.easeInOut,
                              builder:
                                  (
                                    BuildContext _,
                                    final double value,
                                    Widget? _,
                                  ) {
                                    return ProjectTile(
                                      key: ValueKey<String>(entry.project.id),
                                      project: entry.project,
                                      animation: AlwaysStoppedAnimation<double>(
                                        value,
                                      ),
                                      removing: entry.isRemoving,
                                    );
                                  },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _processVisibilityChanges() async {
    if (_isProcessingVisibility) {
      return;
    }

    _isProcessingVisibility = true;
    try {
      while (mounted) {
        if (widget.showProjects) {
          await _showProjectsOneByOne();
        } else {
          await _hideProjectsOneByOne();
        }

        final bool reachedTarget = widget.showProjects
            ? _visibleProjects.length == widget.allProjects.length
            : _visibleProjects.isEmpty;
        if (reachedTarget) {
          break;
        }
      }
    } finally {
      _isProcessingVisibility = false;
      final bool needsAnotherPass = widget.showProjects
          ? _visibleProjects.length < widget.allProjects.length
          : _visibleProjects.isNotEmpty;
      if (mounted && needsAnotherPass) {
        _processVisibilityChanges();
      }
    }
  }

  Future<void> _showProjectsOneByOne() async {
    while (mounted &&
        widget.showProjects &&
        _visibleProjects.length < widget.allProjects.length) {
      setState(() {
        _visibleProjects.add(
          VisibleProjectEntry(
            project: widget.allProjects[_visibleProjects.length],
          ),
        );
      });

      if (_visibleProjects.length >= widget.allProjects.length) {
        break;
      }

      await Future<void>.delayed(_itemInsertDelay);
    }
  }

  Future<void> _hideProjectsOneByOne() async {
    while (mounted && _visibleProjects.isNotEmpty) {
      final int lastIndex = _visibleProjects.length - 1;
      final VisibleProjectEntry lastEntry = _visibleProjects[lastIndex];
      if (!lastEntry.isRemoving) {
        setState(() {
          _visibleProjects[lastIndex] = lastEntry.copyWith(
            isRemoving: true,
            isVisible: false,
          );
        });
      }

      await Future<void>.delayed(_itemAnimationDuration);
      if (!mounted) {
        return;
      }

      setState(() {
        _visibleProjects.removeLast();
      });
    }

    if (!widget.showProjects) {
      widget.onProjectsHidden();
    }
  }
}
