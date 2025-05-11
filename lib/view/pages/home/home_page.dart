import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presenter/home_presenter.dart';
import 'package:turskyi/res/configs/configs.dart';
import 'package:turskyi/res/values/dimens.dart';
import 'package:turskyi/res/values/strings.dart' as strings;
import 'package:turskyi/view/pages/home/home_view.dart';
import 'package:turskyi/view/pages/home/widgets/experience_widget.dart';
import 'package:turskyi/view/pages/home/widgets/fab_widget.dart';
import 'package:turskyi/view/pages/home/widgets/footer.dart';
import 'package:turskyi/view/pages/home/widgets/full_name_text.dart';
import 'package:turskyi/view/pages/home/widgets/hyperlink_group.dart';
import 'package:turskyi/view/pages/home/widgets/loading_indicator.dart';
import 'package:turskyi/view/pages/home/widgets/occupation_widget.dart';
import 'package:turskyi/view/pages/home/widgets/projects_button.dart';
import 'package:turskyi/view/pages/home/widgets/projects_overlay_panel.dart';
import 'package:turskyi/view/pages/home/widgets/social_buttons_row.dart';
import 'package:turskyi/view/routes/link.dart';
import 'package:turskyi/view/util/screen.dart' as screen;

/// [HomePage] class represents a view of a landing page.
/// It extends [StatefulWidget] for the reason of using
/// [TickerProviderStateMixin], which must be mixed onto [StatefulWidget],
/// because [StatefulWidget] implement `State<StatefulWidget>`.
/// And we need to use [TickerProviderStateMixin] to work with
/// [AnimationController].
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin
    implements HomeView {
  final ValueNotifier<bool> _showProjectsNotifier = ValueNotifier<bool>(false);

  late final AnimationController _projectsController;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _projectsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _projectsController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void displayMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLarge = screen.isLarge(context);
    return ChangeNotifierProvider<HomePresenter>(
      create: (_) => HomePresenter(view: this, tickerProvider: this),
      child: DecoratedBox(
        decoration: BoxDecoration(
          // Builds background image.
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
            image: ExactAssetImage(
              '${Configs.of(context).configs.imageAssents}'
              '${strings.homeBackground}',
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              ProjectsButton(onPressed: _toggleProjects),
              if (isLarge)
                Consumer<HomePresenter>(
                  builder: (__, HomePresenter model, _) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: _showProjectsNotifier,
                      builder: (BuildContext __, bool showProjects, _) {
                        return ProjectsOverlayPanel(
                          allProjects: model.allProjects,
                          showProjects: showProjects,
                          controller: _projectsController,
                          slideAnimation: _slideAnimation,
                          onDismiss: _toggleProjects,
                        );
                      },
                    );
                  },
                ),
              Consumer<HomePresenter>(
                builder: (BuildContext __, HomePresenter model, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  isLarge ? Dimens.indent24 : Dimens.indent12,
                              vertical:
                                  isLarge ? Dimens.indent24 : Dimens.indent12,
                            ),
                            child: Column(
                              children: <Widget>[
                                const FullNameText(),
                                const OccupationWidget(),
                                HyperlinkGroup(
                                  onLaunchLink: model.onLaunchLink,
                                  links: const <Link>[
                                    Link.github,
                                    Link.gists,
                                    Link.linkedin,
                                  ],
                                ),
                                const SocialButtonsRow(),
                                ExperienceWidget(
                                  flutterExperience: model.flutterExperience,
                                  androidExperience: model.androidExperience,
                                  totalExperience: model.totalExperience,
                                ),
                                if (model.isLoading) const LoadingIndicator(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Footer(),
                    ],
                  );
                },
              ),
              if (!isLarge)
                Consumer<HomePresenter>(
                  builder: (__, HomePresenter model, _) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: _showProjectsNotifier,
                      builder: (BuildContext context, bool showProjects, _) {
                        return ProjectsOverlayPanel(
                          allProjects: model.allProjects,
                          showProjects: showProjects,
                          controller: _projectsController,
                          slideAnimation: _slideAnimation,
                          onDismiss: _toggleProjects,
                        );
                      },
                    );
                  },
                ),
            ],
          ),
          floatingActionButton: const FabWidget(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _projectsController.dispose();
    super.dispose();
  }

  void _toggleProjects() {
    _showProjectsNotifier.value = !_showProjectsNotifier.value;

    if (_showProjectsNotifier.value) {
      _projectsController.forward();
    } else {
      _projectsController.reverse();
    }
  }
}
