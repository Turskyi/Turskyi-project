import 'package:turskyi/model/links.dart';
import 'package:turskyi/res/values/strings.dart' as strings;

enum Link {
  github,
  gists,
  linkedin,
  goodreads,
  facebook,
  myWishBoard,
  politerai,
  laoziAi,
  annaStore;

  String get title {
    switch (this) {
      case Link.github:
        return strings.github;
      case Link.gists:
        return strings.gists;
      case Link.linkedin:
        return strings.linkedin;
      case Link.facebook:
        return Link.facebook.name;
      case Link.myWishBoard:
        return Link.myWishBoard.name;
      case Link.goodreads:
        return Link.goodreads.name;
      case Link.politerai:
        return Link.politerai.name;
      case Link.laoziAi:
        return strings.laoziAiTitle;
      case Link.annaStore:
        return strings.annaStoreTitle;
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
      case Link.myWishBoard:
        return Links.wishBoardAddress;
      case Link.goodreads:
        return Links.goodReadsAddress;
      case Link.laoziAi:
        return Links.laoziAiAddress;
      case Link.politerai:
        return Links.politeraiAddress;
      case Link.annaStore:
        return Links.annaStoreAddress;
    }
  }
}
