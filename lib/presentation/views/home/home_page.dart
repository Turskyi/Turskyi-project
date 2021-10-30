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
import 'package:url_launcher/url_launcher.dart';
import 'home_view.dart';

/// [HomePage] class represents a presenter of a landing page
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin
    implements HomeView {
  final double _buttonTopIndent = 10.0;

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
        create: (BuildContext context) => HomeModel(this, tickerProvider: this),
        child: Consumer<HomeModel>(
          builder: (BuildContext context, HomeModel model, Widget? widget) {
            return model.isLoading
                ? _buildLoadingWidget()
                : _buildHomePage(model);
          },
        ),
      ),
    );
  }

  Widget _buildHomePage(HomeModel model) {
    // The equivalent of the "smallestWidth" qualifier on Android.
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildName(),
            _buildTitle(curve: model.curvedAnimation),
            Wrap(
              children: <Widget>[
                _buildHyperlink(
                  title: 'GitHub',
                  link: 'https://github.com/Turskyi',
                  topPadding: _buttonTopIndent,
                  model: model,
                ),
                _buildHyperlink(
                  title: 'Gists',
                  link: 'https://gist.github.com/Turskyi',
                  topPadding: _buttonTopIndent,
                  model: model,
                ),
                _buildHyperlink(
                  title: 'LinkedIn',
                  link: 'https://www.linkedin.com/in/dmytroturskyi',
                  topPadding: _buttonTopIndent,
                  model: model,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildFacebookButton(),
                _buildWishlistButton(model: model),
              ],
            ),
            _buildSkills(isLarge, model),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildGooglePlayButton(),
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
        onLongPress: model.onWishListLongPressed,
        style: TextButton.styleFrom(
          backgroundColor: model.wishListColor,
          shape: RoundedRectangleBorder(
            borderRadius: AppStyles.radiusButton,
          ),
        ),
        onPressed: () {
          launch('https://mywishboard.com/@turskyi');
        },
        child: Row(
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
              Text(
                translate('home.experience'),
                style: isLarge
                    ? Theme.of(context).textTheme.headline3
                    : Theme.of(context).textTheme.headline5,
              ),
              Text(
                '${translate('home.flutter_sdk')}'
                ' ${model.flutterExperience}',
                style: isLarge
                    ? Theme.of(context).textTheme.headline4
                    : Theme.of(context).textTheme.headline6,
              ),
              Row(
                children: <Widget>[
                  const Expanded(
                    flex: 10,
                    child: Divider(color: Colors.white, indent: 12),
                  ),
                  Spacer(flex: isLarge ? 18 : 15)
                ],
              ),
              Text(
                '${translate('home.android_sdk')}'
                ' ${model.androidExperience}',
                style: isLarge
                    ? Theme.of(context).textTheme.headline4
                    : Theme.of(context).textTheme.headline6,
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

  Widget _buildTitle({required CurvedAnimation curve}) {
    return FadeTransition(
      opacity: curve,
      child: Text(
        translate('home.title'),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: Theme.of(context).textTheme.headline5?.fontSize,
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

  Widget _buildGooglePlayButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppStyles.radiusButton,
        onTap: () {
          launch(
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
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  Widget _buildHyperlink({
    required String title,
    required String link,
    double topPadding = 0.0,
    required HomeModel model,
  }) {
    return Container(
      padding: EdgeInsets.only(top: topPadding),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppStyles.radiusButton,
          onTap: () => model.onHyperlinkTapped(link),
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

  Widget _buildFacebookButton() {
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
        onPressed: () => launch('https://www.facebook.com/Dmytro.Turskyi'),
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
