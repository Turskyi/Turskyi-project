import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/home/home_model.dart';
import 'package:turskyi/home/home_view.dart';
import 'package:turskyi/utils/app_dimens.dart';
import 'package:url_launcher/url_launcher.dart';

const _colorBody = Colors.white;
final _imageButtonRadius = AppDimens.radiusButton;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomeView {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          _buildBackground(context),
          ChangeNotifierProvider(
            create: (context) => HomeModel(this),
            child: Consumer<HomeModel>(
              builder: (context, model, widget) {
                if (model.isLoading) return _buildLoadingWidget();
                return _buildHomePage(model);
              },
            ),
          ),
        ],
      ),
    );
  }

  Image _buildBackground(BuildContext context) {
    return Image.asset(
      "assets/images/bg_home.png",
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }

  Center _buildHomePage(HomeModel model) {
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
            _buildHyperLink(
                context: context,
                title: 'Git Hub',
                link: 'https://github.com/Turskyi',
                topPadding: 20.0),
            _buildHyperLink(
                context: context,
                title: 'LinkedIn',
                link: 'https://www.linkedin.com/in/dmytroturskyi',
                topPadding: 0.0),
            _buildGooglePlayButton(),
          ],
        ),
      ),
    );
  }

  Text _buildTitle() {
    return Text(
      translate("home.title"),
      style: TextStyle(
        color: _colorBody,
        fontWeight: FontWeight.bold,
        fontSize: Theme.of(context).textTheme.headline5.fontSize,
      ),
    );
  }

  Text _buildName() {
    return Text(
      translate("home.name"),
      style: TextStyle(
        color: _colorBody,
        fontWeight: FontWeight.bold,
        fontSize: Theme.of(context).textTheme.headline4.fontSize,
      ),
    );
  }

  Expanded _buildGooglePlayButton() {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: _imageButtonRadius,
            onTap: () => launch(
                'https://play.google.com/store/apps/dev?id=6867856033872987263'),
            child: Image.asset(
              "assets/images/pic_google_play_grey.png",
              color: Colors.white,
              width: 140,
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildLoadingWidget() {
    return Padding(
      padding: AppDimens.insetsAll64,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  Container _buildHyperLink(
      {BuildContext context,
      @required title,
      @required link,
      @required topPadding}) {
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
                color: _colorBody,
                decoration: TextDecoration.underline,
                fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
              ),
            ),
          ),
          onTap: () => launch(link),
        ),
      ),
    );
  }

  @override
  void displayMessage(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}