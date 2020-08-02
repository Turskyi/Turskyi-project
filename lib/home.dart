import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const _colorBody = Colors.white;
final _borderRadius = BorderRadius.circular(18.0);

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              Text(
                'Dmytro Turskyi',
                style: TextStyle(
                  color: _colorBody,
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.headline4.fontSize,
                ),
              ),
              Text(
                'Android Developer',
                style: TextStyle(
                  color: _colorBody,
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.headline5.fontSize,
                ),
              ),
              buildHyperLink(
                  context, 'Git Hub', 'https://github.com/Turskyi', 20.0),
              buildHyperLink(context, 'LinkedIn',
                  'https://www.linkedin.com/in/dmytroturskyi', 0.0)
            ],
          ),
        ),
      ),
    );
  }

  Container buildHyperLink(BuildContext context, text, link, topPadding) {
    return Container(
      padding: EdgeInsets.only(top: topPadding),
      child: InkWell(
        borderRadius: _borderRadius,
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: new Text(
            text,
            style: TextStyle(
              color: _colorBody,
              decoration: TextDecoration.underline,
              fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
            ),
          ),
        ),
        onTap: () => launch(link),
      ),
    );
  }
}
