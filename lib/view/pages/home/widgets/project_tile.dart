import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/model/models/project.dart';
import 'package:turskyi/model/platform_type.dart';
import 'package:turskyi/presenter/home_presenter.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({
    required this.project,
    required this.animation,
    required this.removing,
    super.key,
  });

  final Project project;
  final Animation<double> animation;
  final bool removing;

  @override
  Widget build(BuildContext context) {
    final Tween<Offset> slideTween = Tween<Offset>(
      begin: removing ? Offset.zero : const Offset(1, 0),
      end: removing ? const Offset(1, 0) : Offset.zero,
    );
    const double verticalPadding = 8.0;
    return SlideTransition(
      position: slideTween.animate(
        CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      ),
      child: FadeTransition(
        opacity: animation,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20.0,
            verticalPadding,
            16.0,
            verticalPadding,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: project.isUniversal
                  ? const <BoxShadow>[
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ]
                  : <BoxShadow>[],
            ),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withValues(alpha: 0.001),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  context.read<HomePresenter>().checkAndLaunchProjectWebsite(
                        project,
                      );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1024 / 500,
                        child: Ink.image(
                          image: AssetImage(project.imageAssetPath),
                          fit: BoxFit.cover,
                          child: const SizedBox.expand(),
                          onImageError: (Object _, StackTrace? __) {
                            ColoredBox(
                              color: Colors.grey.shade300,
                              child: const Center(
                                child: Icon(Icons.broken_image),
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 6,
                        left: 6,
                        right: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Wrap(
                            spacing: 4,
                            children: project.supportedPlatforms
                                .map((PlatformType platform) {
                              final IconData icon = switch (platform) {
                                PlatformType.android => Icons.android,
                                PlatformType.ios => Icons.apple,
                                PlatformType.web => Icons.language,
                              };
                              return Icon(
                                icon,
                                size: 16,
                                color: Colors.white,
                                shadows: const <Shadow>[
                                  Shadow(
                                    color: Colors.black54,
                                    blurRadius: 4,
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
