import 'package:turskyi/model/links.dart' as links;
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
        return links.kGithubAddress;
      case Link.gists:
        return links.kGistsAddress;
      case Link.linkedin:
        return links.kLinkedinAddress;
      case Link.facebook:
        return links.kFacebookAddress;
      case Link.myWishBoard:
        return links.kWishBoardAddress;
      case Link.goodreads:
        return links.kGoodReadsAddress;
      case Link.laoziAi:
        return links.kLaoziAiAddress;
      case Link.politerai:
        return links.kPoliteraiAddress;
      case Link.annaStore:
        return links.kAnnaStoreAddress;
    }
  }
}
