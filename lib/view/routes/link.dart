import 'package:turskyi/main/res/values/strings.dart';

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
        return Strings.githubAddress;
      case Link.gists:
        return Strings.gistsAddress;
      case Link.linkedin:
        return Strings.gistsAddress;
      case Link.facebook:
        return Strings.facebookAddress;
      case Link.wishBoard:
        return Strings.wishBoardAddress;
      case Link.goodReads:
        return Strings.goodReadsAddress;
    }
  }
}
