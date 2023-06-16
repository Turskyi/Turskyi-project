import 'package:turskyi/main/res/values/strings.dart';
import 'package:turskyi/model/links.dart';

enum Link { github, gists, linkedin, goodReads, facebook, wishBoard }

extension LinkExtension on Link {
  String get title {
    switch (this) {
      case Link.github:
        return Strings.github;
      case Link.gists:
        return Strings.gists;
      case Link.linkedin:
        return Strings.linkedin;
      case Link.facebook:
        return Link.facebook.name;
      case Link.wishBoard:
        return Link.wishBoard.name;
      case Link.goodReads:
        return Link.goodReads.name;
    }
  }

  String get address {
    switch (this) {
      case Link.github:
        return Links.githubAddress;
      case Link.gists:
        return Links.gistsAddress;
      case Link.linkedin:
        return Links.gistsAddress;
      case Link.facebook:
        return Links.facebookAddress;
      case Link.wishBoard:
        return Links.wishBoardAddress;
      case Link.goodReads:
        return Links.goodReadsAddress;
    }
  }
}
