import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/home/home_model.dart';
import 'package:turskyi/presentation/values/app_dimens.dart';
import 'package:turskyi/presentation/values/app_styles.dart';
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
  final BorderRadius _imageButtonRadius = AppStyles.radiusButton;

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
            return Stack(
              children: <Widget>[
                _buildBackground(context),
                _buildHomePage(model: model),
                if (model.isLoading) _buildLoadingWidget(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Image.asset(
          '${AppConfigs.of(context).configs.imageAssents}bg_home.png',
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _buildHomePage({required HomeModel model}) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildName(),
          _buildTitle(curve: model.curvedAnimation),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildHyperlink(
                title: 'GitHub',
                link: 'https://github.com/Turskyi',
                topPadding: 10.0,
                model: model,
              ),
              _buildHyperlink(
                title: 'Gists',
                link: 'https://gist.github.com/Turskyi',
                topPadding: 10.0,
                model: model,
              ),
            ],
          ),
          _buildHyperlink(
            title: 'LinkedIn',
            link: 'https://www.linkedin.com/in/dmytroturskyi',
            model: model,
          ),
          _buildFacebookButton(),
          _buildGooglePlayButton(),
        ],
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
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: _imageButtonRadius,
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
          borderRadius: _imageButtonRadius,
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
      padding: const EdgeInsets.all(4),
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: AppStyles.radiusButton,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppConfigs.of(context).colors.colorFacebookWithOpacity,
            blurRadius: 12.0,
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
