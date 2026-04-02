import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:turskyi/model/models/project.dart';
import 'package:turskyi/model/platform_type.dart';
import 'package:turskyi/view/pages/home/widgets/project_tile.dart';
import 'package:turskyi/view/pages/home/widgets/projects_overlay_panel.dart';

void main() {
  testWidgets('projects appear one by one with staggered delay', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const _TestHost());

    expect(_projectTileCount(tester), 0);

    await tester.tap(find.byKey(_TestHost.toggleButtonKey));
    await tester.pump();

    expect(_projectTileCount(tester), 1);

    await tester.pump(const Duration(milliseconds: 149));
    expect(_projectTileCount(tester), 1);

    await tester.pump(const Duration(milliseconds: 1));
    expect(_projectTileCount(tester), 2);

    await tester.pump(const Duration(milliseconds: 150));
    expect(_projectTileCount(tester), 3);

    expect(tester.takeException(), isNull);
  });

  testWidgets('rapid dismiss and reopen does not throw', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const _TestHost());

    await tester.tap(find.byKey(_TestHost.toggleButtonKey));
    await tester.pump(const Duration(milliseconds: 200));

    await tester.tapAt(const Offset(500, 500));
    await tester.pump(const Duration(milliseconds: 1));

    await tester.tap(find.byKey(_TestHost.toggleButtonKey));
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(_projectTileCount(tester), greaterThan(0));
  });
}

int _projectTileCount(WidgetTester tester) {
  return tester.widgetList<ProjectTile>(find.byType(ProjectTile)).length;
}

class _TestHost extends StatefulWidget {
  const _TestHost();

  static const Key toggleButtonKey = ValueKey<String>('toggle-projects');

  @override
  State<_TestHost> createState() => _TestHostState();
}

class _TestHostState extends State<_TestHost> with TickerProviderStateMixin {
  bool _showProjects = false;

  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;

  final List<Project> _projects = const <Project>[
    Project(
      name: 'One',
      imageAssetPath: 'assets/images/feature_graphics/project_1.png',
      primaryWebsiteUrl: 'https://example.com/one',
      supportedPlatforms: <PlatformType>{
        PlatformType.android,
        PlatformType.web,
      },
    ),
    Project(
      name: 'Two',
      imageAssetPath: 'assets/images/feature_graphics/project_2.png',
      primaryWebsiteUrl: 'https://example.com/two',
      supportedPlatforms: <PlatformType>{PlatformType.ios, PlatformType.web},
    ),
    Project(
      name: 'Three',
      imageAssetPath: 'assets/images/feature_graphics/project_3.png',
      primaryWebsiteUrl: 'https://example.com/three',
      supportedPlatforms: <PlatformType>{
        PlatformType.android,
        PlatformType.ios,
        PlatformType.web,
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleProjects() {
    setState(() {
      _showProjects = !_showProjects;
    });

    if (_showProjects) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 16,
              left: 16,
              child: ElevatedButton(
                key: _TestHost.toggleButtonKey,
                onPressed: _toggleProjects,
                child: const Text('Toggle'),
              ),
            ),
            ProjectsOverlayPanel(
              showProjects: _showProjects,
              controller: _controller,
              slideAnimation: _slideAnimation,
              onDismiss: _toggleProjects,
              onProjectsHidden: () {},
              allProjects: _projects,
            ),
          ],
        ),
      ),
    );
  }
}
