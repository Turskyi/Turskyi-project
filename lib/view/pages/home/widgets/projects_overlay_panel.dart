import 'package:flutter/material.dart';
import 'package:turskyi/model/project.dart';
import 'package:turskyi/view/pages/home/widgets/project_tile.dart';

class ProjectsOverlayPanel extends StatefulWidget {
  const ProjectsOverlayPanel({
    required this.showProjects,
    required this.controller,
    required this.slideAnimation,
    required this.onDismiss,
    required this.allProjects,
    super.key,
  });

  final bool showProjects;
  final AnimationController controller;
  final Animation<Offset> slideAnimation;
  final VoidCallback onDismiss;
  final List<Project> allProjects;

  @override
  State<ProjectsOverlayPanel> createState() => _ProjectsOverlayPanelState();
}

class _ProjectsOverlayPanelState extends State<ProjectsOverlayPanel> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final Map<int, Project> _visibleProjects = <int, Project>{};

  @override
  void didUpdateWidget(covariant ProjectsOverlayPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showProjects && _visibleProjects.isEmpty) {
      _insertProjectsOneByOne();
    } else if (!widget.showProjects && _visibleProjects.isNotEmpty) {
      _removeProjectsOneByOne();
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
              builder: (_, __) {
                return Opacity(
                  opacity: widget.controller.value,
                  child: SlideTransition(
                    position: widget.slideAnimation,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 300,
                        padding: const EdgeInsets.all(12),
                        color: Colors.transparent,
                        child: AnimatedList(
                          key: _listKey,
                          initialItemCount: _visibleProjects.length,
                          itemBuilder: (
                            _,
                            int index,
                            Animation<double> animation,
                          ) {
                            final Project? project = _visibleProjects[index];
                            if (project != null) {
                              return ProjectTile(
                                key: ValueKey<String>(project.name),
                                project: project,
                                animation: animation,
                                removing: false,
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
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

  Future<void> _insertProjectsOneByOne() async {
    for (int i = 0; i < widget.allProjects.length; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 150));
      _visibleProjects.putIfAbsent(i, () => widget.allProjects[i]);
      _listKey.currentState?.insertItem(i);
    }
  }

  Future<void> _removeProjectsOneByOne() async {
    for (int i = _visibleProjects.length - 1; i >= 0; i--) {
      final Project? removedItem = _visibleProjects.remove(i);
      if (removedItem != null) {
        _listKey.currentState?.removeItem(
          i,
          (_, Animation<double> animation) => ProjectTile(
            key: ValueKey<String>(removedItem.name),
            project: removedItem,
            animation: animation,
            removing: true,
          ),
          duration: const Duration(milliseconds: 1000),
        );
      }
      await Future<void>.delayed(const Duration(milliseconds: 300));
    }
  }
}
