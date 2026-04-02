import 'package:flutter/material.dart';
import 'package:turskyi/model/models/project.dart';
import 'package:turskyi/view/pages/home/widgets/project_tile.dart';

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

  final List<_VisibleProjectEntry> _visibleProjects = <_VisibleProjectEntry>[];
  bool _isProcessingVisibility = false;

  @override
  void initState() {
    super.initState();
    if (widget.showProjects) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _processVisibilityChanges();
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant ProjectsOverlayPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showProjects != oldWidget.showProjects) {
      _processVisibilityChanges();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          itemBuilder: (BuildContext _, int index) {
                            final _VisibleProjectEntry entry =
                                _visibleProjects[index];
                            return TweenAnimationBuilder<double>(
                              key: ValueKey<String>(entry.project.name),
                              tween: Tween<double>(
                                end: entry.isVisible ? 1 : 0,
                              ),
                              duration: _itemAnimationDuration,
                              curve: Curves.easeInOut,
                              builder:
                                  (BuildContext _, double value, Widget? _) {
                                    return ProjectTile(
                                      key: ValueKey<String>(entry.project.name),
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
          _VisibleProjectEntry(
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
      final _VisibleProjectEntry lastEntry = _visibleProjects.last;
      if (!lastEntry.isRemoving) {
        setState(() {
          lastEntry
            ..isRemoving = true
            ..isVisible = false;
        });
      }

      await Future<void>.delayed(_itemAnimationDuration);
      if (!mounted) {
        return;
      }

      setState(() {
        _visibleProjects.remove(lastEntry);
      });
    }

    if (!widget.showProjects) {
      widget.onProjectsHidden();
    }
  }
}

class _VisibleProjectEntry {
  _VisibleProjectEntry({required this.project});

  final Project project;
  bool isVisible = true;
  bool isRemoving = false;
}
