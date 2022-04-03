import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/routes.dart';
import 'package:turskyi/presentation/values/app_dimens.dart';
import 'package:turskyi/presentation/views/home/home_model.dart';
import 'package:turskyi/presentation/views/home/home_view.dart';
import 'package:turskyi/presentation/views/home/widgets/hyperlink_widget.dart';
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
  /// decoration attribute which used in [Container] around [Text] to
  /// set dark background
  static final BoxDecoration _textDecoration = BoxDecoration(
    color: Colors.black,
    border: Border.all(color: Colors.white),
    boxShadow: const <BoxShadow>[
      BoxShadow(
        // topRight
        offset: Offset(AppDimens.offset1, AppDimens.offset1),
        color: Colors.white,
        blurRadius: AppDimens.shadowRadius,
      ),
      BoxShadow(
        // bottomLeft
        offset: Offset(AppDimens.offsetMinus1, AppDimens.offsetMinus1),
        color: Colors.white,
        blurRadius: AppDimens.shadowRadius,
      )
    ],
    borderRadius: BorderRadius.circular(AppDimens.borderRadius),
  );

  @override
  void displayMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel(this, tickerProvider: this),
      child: Consumer<HomeModel>(
        builder: (BuildContext context, HomeModel model, _) {
          // The equivalent of the "smallestWidth" qualifier on Android.
          final double shortestSide = MediaQuery.of(
            context,
          ).size.shortestSide;
          final bool isLarge = shortestSide > AppDimens.maxPortraitWidth;
          return Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButton: FloatingActionButton(
              onPressed: model.onPhoneButtonPressed,
              child: const Icon(Icons.phone),
            ),
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
                  horizontal: isLarge ? 24.0 : 12.0,
                  vertical: 24.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      translate('home.name'),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.headline4?.fontSize,
                      ),
                    ),
                    // build name of the occupation
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: FadeTransition(
                        opacity: model.curvedAnimation,
                        child: MouseRegion(
                          onEnter: model.onTitleHover,
                          onExit: model.onTitleHover,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              AnimatedContainer(
                                width: model.suffixWidth,
                                duration: model.expandDuration,
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  translate('home.suffix_title'),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.fontSize,
                                  ),
                                ),
                              ),
                              Text(
                                translate('home.title'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.fontSize,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // build github, gists and linkedin hyperlinks
                    Wrap(
                      children: <Widget>[
                        HyperlinkWidget(
                          title: 'GitHub',
                          onTap: () {
                            model.onLaunchLink('https://github.com/Turskyi');
                          },
                        ),
                        HyperlinkWidget(
                          title: 'Gists',
                          onTap: () {
                            model.onLaunchLink(
                              'https://gist.github.com/Turskyi',
                            );
                          },
                        ),
                        HyperlinkWidget(
                          title: 'LinkedIn',
                          onTap: () {
                            model.onLaunchLink(
                              'https://www.linkedin.com/in/dmytroturskyi',
                            );
                          },
                        ),
                      ],
                    ),
                    // build facebook and wishlist button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: AppDimens.heightColorButton,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppDimens.buttonRadius,
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: AppConfigs.of(context)
                                    .colors
                                    .colorFacebookWithOpacity,
                                blurRadius: AppDimens.blurRadius,
                              ),
                            ],
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  AppConfigs.of(context).colors.colorFacebook,
                              minimumSize: const Size(88, 36),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppDimens.buttonRadius,
                                ),
                                side: BorderSide(
                                  color: AppConfigs.of(context)
                                      .colors
                                      .colorFacebook,
                                ),
                              ),
                            ),
                            onPressed: () {
                              model.onLaunchLink(
                                'https://www.facebook.com/Dmytro.Turskyi',
                              );
                            },
                            child: kIsWeb
                                ? Image.asset(
                                    // ignore: lines_longer_than_80_chars
                                    '${AppConfigs.of(context).configs.imageAssents}'
                                    'pic_facebook.png',
                                    width: AppDimens.widthFacebook,
                                    fit: BoxFit.cover,
                                  )
                                : SvgPicture.asset(
                                    // ignore: lines_longer_than_80_chars
                                    '${AppConfigs.of(context).configs.imageAssents}'
                                    'pic_facebook.svg',
                                    width: AppDimens.widthFacebook,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        if (kIsWeb)
                          MouseRegion(
                            onEnter: model.onWishListButtonAnimate,
                            onExit: model.onWishListButtonAnimate,
                            child: WishlistButtonWidget(
                              dayCount: model.daysToBirthday,
                              wishlistWidth: model.wishlistWidth,
                              duration: model.expandDuration,
                              onWishListButtonAnimate: () =>
                                  model.onWishListButtonAnimate(
                                const PointerMoveEvent(),
                              ),
                              onLaunchLink: () => model.onLaunchLink(
                                'https://mywishboard.com/@turskyi',
                              ),
                              animationRotation: model.rotationAnimation,
                            ),
                          )
                        else
                          WishlistButtonWidget(
                            dayCount: model.daysToBirthday,
                            wishlistWidth: model.wishlistWidth,
                            duration: model.expandDuration,
                            onWishListButtonAnimate: () {
                              model.onWishListButtonAnimate(
                                const PointerMoveEvent(),
                              );
                            },
                            onLaunchLink: () => model.onLaunchLink(
                              'https://mywishboard.com/@turskyi',
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
                                margin:
                                    const EdgeInsets.only(top: 40, bottom: 4),
                                decoration: _textDecoration,
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
                                decoration: _textDecoration,
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
                                decoration: _textDecoration,
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
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
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
                                  Routes.game,
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
