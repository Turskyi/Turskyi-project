import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/routes/app_route.dart';
import 'package:turskyi/presentation/routes/link.dart';
import 'package:turskyi/presentation/util/screen.dart';
import 'package:turskyi/presentation/values/app_decorations.dart';
import 'package:turskyi/presentation/values/app_dimens.dart';
import 'package:turskyi/presentation/views/home/home_model.dart';
import 'package:turskyi/presentation/views/home/home_view.dart';
import 'package:turskyi/presentation/views/home/widgets/fab_widget.dart';
import 'package:turskyi/presentation/views/home/widgets/facebook_button.dart';
import 'package:turskyi/presentation/views/home/widgets/full_name_text.dart';
import 'package:turskyi/presentation/views/home/widgets/good_reads_button.dart';
import 'package:turskyi/presentation/views/home/widgets/hyperlink_widget.dart';
import 'package:turskyi/presentation/views/home/widgets/occupation_widget.dart';
import 'package:turskyi/presentation/views/home/widgets/wishlist_button_widget.dart';

/// [HomePage] class represents a presenter of a landing page.
/// It extends [StatefulWidget] for the reason of using
/// [TickerProviderStateMixin], which must be mixed onto 'StatefulWidget',
/// because 'StatefulWidget' implement 'State<StatefulWidget>.
/// And we need to use [TickerProviderStateMixin] to work with
/// [AnimationController].
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin
    implements HomeView {
  @override
  Widget build(BuildContext context) {
    final bool isLarge = Screen.isWide(context);
    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel(this, tickerProvider: this),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: const FabWidget(),
        body: DecoratedBox(
          decoration: BoxDecoration(
            // build background picture
            image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              image: ExactAssetImage(
                '${AppConfigs.of(context).configs.imageAssents}bg_home.png',
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isLarge ? AppDimens.indent24 : AppDimens.indent12,
              vertical: AppDimens.indent24,
            ),
            child: Consumer<HomeModel>(
              builder: (BuildContext context, HomeModel model, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const FullNameText(),
                    const OccupationWidget(),
                    // build github, gists and linkedin hyperlinks
                    Wrap(
                      children: <Widget>[
                        HyperlinkWidget(
                          title: Link.github.title,
                          onTap: () => model.onLaunchLink(Link.github.address),
                        ),
                        HyperlinkWidget(
                          title: Link.gists.title,
                          onTap: () => model.onLaunchLink(Link.gists.address),
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
                            Link.wishBoard.address,
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
                                  left: AppDimens.indent12,
                                  right: AppDimens.indent12,
                                  bottom: AppDimens.indent4,
                                ),
                                margin: const EdgeInsets.only(
                                  top: 40,
                                  bottom: 4,
                                ),
                                decoration: AppDecorations.textDecoration,
                                child: Text(
                                  translate('home.experience'),
                                  style: isLarge
                                      ? Theme.of(context).textTheme.headline4
                                      : Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: AppDimens.indent12,
                                  right: AppDimens.indent12,
                                  bottom: AppDimens.indent4,
                                ),
                                decoration: AppDecorations.textDecoration,
                                margin: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  '${translate('home.flutter_sdk')}'
                                  ' ${model.flutterExperience}',
                                  style: isLarge
                                      ? Theme.of(context).textTheme.headline4
                                      : Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: AppDimens.indent12,
                                  right: AppDimens.indent12,
                                  bottom: AppDimens.indent4,
                                ),
                                decoration: AppDecorations.textDecoration,
                                child: Text(
                                  '${translate('home.android_sdk')}'
                                  ' ${model.androidExperience}',
                                  style: isLarge
                                      ? Theme.of(context).textTheme.headline4
                                      : Theme.of(context).textTheme.headline6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (model.isLoading)
                      const Padding(
                        padding: EdgeInsets.all(64.0),
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
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  AppDimens.buttonRadius,
                                ),
                                onTap: () {
                                  model.onLaunchLink(
                                    'https://play.google.com/store/apps/dev?id=6867856033872987263',
                                  );
                                },
                                child: Image.asset(
                                  // ignore: lines_longer_than_80_chars
                                  '${AppConfigs.of(context).configs.imageAssents}'
                                      'pic_google_play_grey.png',
                                  color: Colors.white, width: 140.0,
                                ),
                              ),
                            ),
                            // Determine if we should show game button.
                            if (isLarge)
                              RawMaterialButton(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  AppRoute.game.path,
                                ),
                                padding: const EdgeInsets.all(20.0),
                                shape: const CircleBorder(),
                                child: SvgPicture.asset(
                                  // ignore: lines_longer_than_80_chars
                                  '${AppConfigs.of(context).configs.imageAssents}'
                                  'unity_logo.svg',
                                  height: 40,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void displayMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
