import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presenter/home_presenter.dart';
import 'package:turskyi/res/configs/configs.dart';
import 'package:turskyi/res/values/decorations.dart' as decorations;
import 'package:turskyi/res/values/dimens.dart';
import 'package:turskyi/res/values/strings.dart' as strings;
import 'package:turskyi/view/pages/home/home_view.dart';
import 'package:turskyi/view/pages/home/widgets/fab_widget.dart';
import 'package:turskyi/view/pages/home/widgets/facebook_button.dart';
import 'package:turskyi/view/pages/home/widgets/footer.dart';
import 'package:turskyi/view/pages/home/widgets/full_name_text.dart';
import 'package:turskyi/view/pages/home/widgets/good_reads_button.dart';
import 'package:turskyi/view/pages/home/widgets/hyperlink_widget.dart';
import 'package:turskyi/view/pages/home/widgets/occupation_widget.dart';
import 'package:turskyi/view/pages/home/widgets/wishlist_button_widget.dart';
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
  @override
  void displayMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLarge = screen.isWide(context);
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
          floatingActionButton: const FabWidget(),
          body: Consumer<HomePresenter>(
            builder: (
              BuildContext context,
              HomePresenter model,
              _,
            ) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isLarge ? Dimens.indent24 : Dimens.indent12,
                      vertical: Dimens.indent24,
                    ),
                    child: Column(
                      children: <Widget>[
                        const FullNameText(),
                        const OccupationWidget(),
                        // build github, gists and linkedin hyperlinks
                        Wrap(
                          children: <Widget>[
                            HyperlinkWidget(
                              title: Link.github.title,
                              onTap: () => model.onLaunchLink(
                                Link.github.address,
                              ),
                            ),
                            HyperlinkWidget(
                              title: Link.gists.title,
                              onTap: () {
                                model.onLaunchLink(Link.gists.address);
                              },
                            ),
                            HyperlinkWidget(
                              title: Link.linkedin.title,
                              onTap: () => model.onLaunchLink(
                                Link.linkedin.address,
                              ),
                            ),
                          ],
                        ),
                        // build facebook and wishlist button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const GoodReadsButton(),
                            const FacebookButton(),
                            WishlistButtonWidget(
                              dayCount: model.daysToBirthday,
                              wishlistWidth: model.wishlistWidth,
                              duration: model.expandDuration,
                              onWishListButtonAnimate:
                                  model.onWishListButtonAnimate,
                              onLaunchLink: () => model.onLaunchLink(
                                Link.myWishBoard.address,
                              ),
                              animationRotation: model.rotationAnimation,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: Dimens.indent12,
                                      right: Dimens.indent12,
                                      bottom: Dimens.indent4,
                                    ),
                                    margin: const EdgeInsets.only(
                                      top: Dimens.indent40,
                                      bottom: Dimens.indent4,
                                    ),
                                    decoration: decorations.textDecoration,
                                    child: Text(
                                      translate('home.experience'),
                                      style: isLarge
                                          ? Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                          : Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: Dimens.indent12,
                                      right: Dimens.indent12,
                                      bottom: Dimens.indent4,
                                    ),
                                    decoration: decorations.textDecoration,
                                    margin: const EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      '${translate('home.flutter')}'
                                      ' ${model.flutterExperience}',
                                      style: isLarge
                                          ? Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                          : Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: Dimens.indent12,
                                      right: Dimens.indent12,
                                      bottom: Dimens.indent4,
                                    ),
                                    decoration: decorations.textDecoration,
                                    margin: const EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      '${translate('home.android')}'
                                      ' ${model.androidExperience}',
                                      style: isLarge
                                          ? Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                          : Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: Dimens.indent12,
                                      right: Dimens.indent12,
                                      bottom: Dimens.indent4,
                                    ),
                                    decoration: decorations.textDecoration,
                                    child: Text(
                                      '${translate('home.total')}'
                                      ' ${model.totalExperience}',
                                      style: isLarge
                                          ? Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                          : Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (model.isLoading)
                          const Padding(
                            padding: EdgeInsets.all(Dimens.indent64),
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.black87,
                                color: Colors.grey,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const Expanded(child: Footer()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
