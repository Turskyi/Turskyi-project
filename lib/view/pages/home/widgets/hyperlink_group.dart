import 'package:flutter/material.dart';
import 'package:turskyi/view/pages/home/widgets/hyperlink_widget.dart';
import 'package:turskyi/view/routes/link.dart';

class HyperlinkGroup extends StatelessWidget {
  const HyperlinkGroup({
    required this.onLaunchLink,
    required this.links,
    super.key,
  });

  final ValueSetter<String> onLaunchLink;
  final List<Link> links;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        for (final Link link in links)
          HyperlinkWidget(
            title: link.title,
            onTap: () => onLaunchLink(link.address),
          ),
      ],
    );
  }
}
