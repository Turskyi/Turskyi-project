import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/constants.dart';
import 'package:turskyi/presentation/home/home_model.dart';
import 'package:turskyi/presentation/values/app_dimens.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _imageButtonRadius = AppDimens.radiusButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          _buildBackground(context),
          ChangeNotifierProvider(
            create: (context) => HomeModel(),
            child: Consumer<HomeModel>(
              builder: (context, model, widget) {
                return model.isLoading
                    ? _buildLoadingWidget()
                    : _buildHomePage(model);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Image.asset(
          "${Constants.ASSETS_IMAGES}bg_home.png",
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _buildHomePage(HomeModel model) {
    return Center(
      /**
       *  Init view
       */
      child: Padding(
        padding: AppDimens.insetsAll24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildName(),
            _buildTitle(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHyperLink(
                  context: context,
                  title: 'GitHub',
                  link: Constants.GITHUB_PAGE,
                  topPadding: AppDimens.paddingTopGitHub,
                ),
                _buildHyperLink(
                  context: context,
                  title: 'Gists',
                  link: Constants.GISTS_PAGE,
                  topPadding: AppDimens.paddingTopGitHub,
                ),
              ],
            ),
            _buildHyperLink(
              context: context,
              title: 'LinkedIn',
              link: Constants.LINKEDIN_PAGE,
              topPadding: 0.0,
            ),
            _buildFacebookButton(),
            _buildGooglePlayButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      translate("home.title"),
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: Theme.of(context).textTheme.headline5?.fontSize,
      ),
    );
  }

  Widget _buildName() {
    return Text(
      translate("home.name"),
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
            onTap: () => launch(Constants.GOOGLE_PLAY_APPS),
            child: Image.asset(
              "${Constants.ASSETS_IMAGES}pic_google_play_grey.png",
              color: Colors.white,
              width: AppDimens.widthGooglePlayButton,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Padding(
      padding: AppDimens.insetsAll64,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  Widget _buildHyperLink({
    required BuildContext context,
    @required title,
    @required link,
    @required topPadding,
  }) {
    return Container(
      padding: EdgeInsets.only(top: topPadding),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: _imageButtonRadius,
          child: Container(
            padding: AppDimens.insetsAll12,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
                fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
              ),
            ),
          ),
          onTap: () => launch(link),
        ),
      ),
    );
  }

  Widget _buildFacebookButton() {
    return Container(
      padding: AppDimens.insetsAll4,
      height: AppDimens.heightImageButton,
      decoration: BoxDecoration(
        borderRadius: AppDimens.radiusButton,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppConfigs.of(context).colors.colorFacebookWithOpacity,
            blurRadius: AppDimens.radiusBlur,
            offset: AppDimens.offsetShadow,
          ),
        ],
      ),
      child: FlatButton(
        disabledColor: AppConfigs.of(context).colors.colorFacebook,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimens.radiusButton,
          side: BorderSide(color: AppConfigs.of(context).colors.colorFacebook),
        ),
        color: AppConfigs.of(context).colors.colorFacebook,
        onPressed: () => launch(Constants.FACEBOOK_PAGE),
        child: kIsWeb
            ? Image.asset(
                "${Constants.ASSETS_IMAGES}pic_facebook.png",
                width: AppDimens.widthFacebook,
                fit: BoxFit.cover,
              )
            : SvgPicture.asset(
                "${Constants.ASSETS_IMAGES}pic_facebook.svg",
                width: AppDimens.widthFacebook,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
