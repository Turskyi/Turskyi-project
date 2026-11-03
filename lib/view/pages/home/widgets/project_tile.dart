import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/model/models/project.dart';
import 'package:turskyi/model/models/project_ranking.dart';
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
  Widget build(final BuildContext context) {
    final Animation<double> slideAnimation = removing
        ? ReverseAnimation(animation)
        : animation;
    final Tween<Offset> slideTween = Tween<Offset>(
      begin: removing ? Offset.zero : const Offset(1, 0),
      end: removing ? const Offset(1, 0) : Offset.zero,
    );
    const double verticalPadding = 8.0;
    return SlideTransition(
      position: slideTween.animate(
        CurvedAnimation(parent: slideAnimation, curve: Curves.easeInOut),
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
                          onImageError: (Object _, StackTrace? _) {
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
                        bottom: 8,
                        left: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: project.supportedPlatforms.map((
                              final PlatformType platform,
                            ) {
                              final IconData icon = switch (platform) {
                                PlatformType.android => Icons.android,
                                PlatformType.ios => Icons.apple,
                                PlatformType.web => Icons.language,
                              };
                              final String platformName = switch (platform) {
                                PlatformType.android => 'Android',
                                PlatformType.ios => 'iOS',
                                PlatformType.web => 'Web',
                              };
                              final int count = _getPlatformCount(
                                platform,
                                project.ranking,
                              );

                              final Widget platformWidget = Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.75),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white38,
                                    width: 0.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(icon, size: 14, color: Colors.white),
                                    if (count > 0) ...<Widget>[
                                      const SizedBox(width: 5),
                                      Text(
                                        _formatCompact(count),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              );

                              final String formattedCount =
                                  NumberFormat.decimalPattern().format(count);
                              return Semantics(
                                label: count > 0
                                    ? '$platformName: $formattedCount users'
                                    : platformName,
                                child: platformWidget,
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

  int _getPlatformCount(
    final PlatformType platform,
    final ProjectRanking? ranking,
  ) {
    if (ranking == null) {
      return 0;
    } else {
      return switch (platform) {
        PlatformType.android => ranking.android,
        PlatformType.ios => ranking.ios,
        PlatformType.web => ranking.web,
      };
    }
  }

  String _formatCompact(final int count) {
    return NumberFormat.compact().format(count);
  }
}
