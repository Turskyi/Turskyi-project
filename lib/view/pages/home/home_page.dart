import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/model/project_data_source.dart';
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
import 'package:url_launcher/url_launcher.dart';

/// [HomePage] class represents a view of a landing page.
/// It extends [StatefulWidget] for the reason of using
/// [TickerProviderStateMixin], which must be mixed onto [StatefulWidget],
/// because [StatefulWidget] implement `State<StatefulWidget>`.
/// And we need to use [TickerProviderStateMixin] to work with
/// [AnimationController].
class HomePage extends StatefulWidget {
  const HomePage({required this.projectDataSource, super.key});

  final ProjectDataSource projectDataSource;

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
    _slideAnimation =
        Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(
          CurvedAnimation(parent: _projectsController, curve: Curves.easeInOut),
        );
  }

  @override
  void displayMessage(String message) {
    final RegExp linkRegex = RegExp(r'(https?://\S+)', caseSensitive: false);

    final Match? match = linkRegex.firstMatch(message);
    final String? link = match?.group(0);
    if (match != null && link != null) {
      final int start = match.start;
      final int end = match.end;

      final TextSpan span = TextSpan(
        style: const TextStyle(color: Colors.white),
        children: <InlineSpan>[
          TextSpan(text: message.substring(0, start)),
          TextSpan(
            text: link,
            style: const TextStyle(
              color: Colors.lightBlueAccent,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrl(Uri.parse(link)),
          ),
          TextSpan(text: message.substring(end)),
        ],
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 10),
          content: SelectableText.rich(span),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 6),
          content: SelectableText(message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLarge = screen.isLarge(context);
    return ChangeNotifierProvider<HomePresenter>(
      create: (BuildContext _) {
        return HomePresenter(
          view: this,
          tickerProvider: this,
          projectDataSource: widget.projectDataSource,
        );
      },
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
                  builder: (BuildContext _, HomePresenter model, Widget? _) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: _showProjectsNotifier,
                      builder: (BuildContext _, bool showProjects, Widget? _) {
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
                builder: (BuildContext _, HomePresenter model, Widget? _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isLarge
                                ? Dimens.indent24
                                : Dimens.indent12,
                            vertical: isLarge
                                ? Dimens.indent24
                                : Dimens.indent12,
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
                            ],
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
                  builder: (BuildContext _, HomePresenter model, Widget? _) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: _showProjectsNotifier,
                      builder: (BuildContext _, bool showProjects, Widget? _) {
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
                child: Positioned.fill(
                  child: AbsorbPointer(
                    child: ColoredBox(
                      color: Colors.black.withAlpha(150),
                      child: const LoadingIndicator(),
                    ),
                  ),
                ),
                builder: (BuildContext _, HomePresenter model, Widget? child) {
                  if (model.isLoading && child != null) {
                    return child;
                  } else {
                    return const SizedBox.shrink();
                  }
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
