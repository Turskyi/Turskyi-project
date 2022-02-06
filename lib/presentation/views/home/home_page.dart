import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/routes.dart';
import 'package:turskyi/presentation/values/app_dimens.dart';
import 'package:turskyi/presentation/values/app_styles.dart';
import 'package:turskyi/presentation/views/home/home_model.dart';

import 'home_view.dart';

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
  void displayMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ChangeNotifierProvider<HomeModel>(
        create: (_) => HomeModel(this, tickerProvider: this),
        child: Consumer<HomeModel>(
          builder: (BuildContext context, HomeModel model, _) {
            // The equivalent of the "smallestWidth" qualifier on Android.
            final double shortestSide = MediaQuery.of(
              context,
            ).size.shortestSide;
            final bool isLarge = shortestSide > 600.0;
            return DecoratedBox(
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
                    _buildName(),
                    // build name of the occupation
                    _buildTitle(model: model),
                    // build github, gists and linkedin hyperlinks
                    Wrap(
                      children: <Widget>[
                        _buildHyperlink(
                          title: 'GitHub',
                          link: 'https://github.com/Turskyi',
                          model: model,
                        ),
                        _buildHyperlink(
                          title: 'Gists',
                          link: 'https://gist.github.com/Turskyi',
                          model: model,
                        ),
                        _buildHyperlink(
                          title: 'LinkedIn',
                          link: 'https://www.linkedin.com/in/dmytroturskyi',
                          model: model,
                        ),
                      ],
                    ),
                    // build facebook and wishlist button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildFacebookButton(model: model),
                        if (kIsWeb)
                          MouseRegion(
                            onEnter: model.onWishListButtonAnimate,
                            onExit: model.onWishListButtonAnimate,
                            child: _buildWishlistButton(model: model),
                          )
                        else
                          _buildWishlistButton(model: model),
                      ],
                    ),
                    _buildSkills(isLarge, model),
                    if (model.isLoading) _buildLoadingWidget(),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildGooglePlayButton(model: model),
                            // Determine if we should show game button.
                            if (isLarge) _buildUnityButton(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWishlistButton({required HomeModel model}) {
    return AnimatedContainer(
      margin: const EdgeInsets.all(8),
      width: model.wishlistWidth,
      height: AppDimens.heightColorButton,
      decoration: BoxDecoration(
        borderRadius: AppStyles.radiusButton,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppConfigs.of(context).colors.colorWishlistWithOpacity,
            blurRadius: AppDimens.blurRadius,
          ),
        ],
      ),
      duration: model.expandDuration,
      child: TextButton(
        onLongPress: () {
          model.onWishListButtonAnimate(const PointerMoveEvent());
        },
        style: TextButton.styleFrom(
          backgroundColor: AppConfigs.of(context).colors.colorWishlist,
          shape: RoundedRectangleBorder(borderRadius: AppStyles.radiusButton),
        ),
        onPressed: () => model.onLaunchLink('https://mywishboard.com/@turskyi'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RotationTransition(
              turns: model.rotationAnimation,
              child: ClipRRect(
                borderRadius: AppStyles.radiusButton,
                child: Image.asset(
                  '${AppConfigs.of(context).configs.imageAssents}'
                  'mywishboard_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              child: Text(
                model.daysToBirthday,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkills(bool isLarge, HomeModel model) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: AppStyles.textPadding,
                margin: const EdgeInsets.only(top: 40, bottom: 4),
                decoration: AppStyles.textDecoration,
                child: Text(
                  translate('home.experience'),
                  style: isLarge
                      ? Theme.of(context).textTheme.headline4
                      : Theme.of(context).textTheme.headline6,
                ),
              ),
              Container(
                padding: AppStyles.textPadding,
                decoration: AppStyles.textDecoration,
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
                padding: AppStyles.textPadding,
                decoration: AppStyles.textDecoration,
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
    );
  }

  Widget _buildUnityButton() {
    return RawMaterialButton(
      // Navigate to the second screen using a named route.
      onPressed: () => Navigator.pushNamed(context, Routes.game),
      padding: const EdgeInsets.all(20.0),
      shape: const CircleBorder(),
      child: SvgPicture.asset(
        '${AppConfigs.of(context).configs.imageAssents}'
        'unity_logo.svg',
        height: 40,
      ),
    );
  }

  Widget _buildTitle({required HomeModel model}) {
    return Padding(
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
                    fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                  ),
                ),
              ),
              Text(
                translate('home.title'),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildName() {
    return Text(
      translate('home.name'),
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: Theme.of(context).textTheme.headline4?.fontSize,
      ),
    );
  }

  Widget _buildGooglePlayButton({required HomeModel model}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppStyles.radiusButton,
        onTap: () {
          model.onLaunchLink(
            'https://play.google.com/store/apps/dev?id=6867856033872987263',
          );
        },
        child: Image.asset(
          '${AppConfigs.of(context).configs.imageAssents}'
          'pic_google_play_grey.png',
          color: Colors.white,
          width: 140.0,
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const Padding(
      padding: EdgeInsets.all(64.0),
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.black87,
          color: Colors.grey,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  Widget _buildHyperlink({
    required String title,
    required String link,
    required HomeModel model,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppStyles.radiusButton,
          onTap: () => model.onLaunchLink(link),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
                fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFacebookButton({required HomeModel model}) {
    return Container(
      height: AppDimens.heightColorButton,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: AppStyles.radiusButton,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppConfigs.of(context).colors.colorFacebookWithOpacity,
            blurRadius: AppDimens.blurRadius,
          ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppConfigs.of(context).colors.colorFacebook,
          minimumSize: const Size(88, 36),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: AppStyles.radiusButton,
            side: BorderSide(
              color: AppConfigs.of(context).colors.colorFacebook,
            ),
          ),
        ),
        onPressed: () {
          model.onLaunchLink('https://www.facebook.com/Dmytro.Turskyi');
        },
        child: kIsWeb
            ? Image.asset(
                '${AppConfigs.of(context).configs.imageAssents}'
                'pic_facebook.png',
                width: AppDimens.widthFacebook,
                fit: BoxFit.cover,
              )
            : SvgPicture.asset(
                '${AppConfigs.of(context).configs.imageAssents}'
                'pic_facebook.svg',
                width: AppDimens.widthFacebook,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
