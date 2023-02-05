import 'package:turskyi/presentation/values/app_strings.dart';

enum Link { github, gists, linkedin, goodReads, facebook, wishBoard }

extension LinkExtension on Link {
  String get title {
    switch (this) {
      case Link.github:
        return AppStrings.github;
      case Link.gists:
        return AppStrings.gists;
      case Link.linkedin:
        return AppStrings.linkedin;
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
        return AppStrings.githubAddress;
      case Link.gists:
        return AppStrings.gistsAddress;
      case Link.linkedin:
        return AppStrings.gistsAddress;
      case Link.facebook:
        return AppStrings.facebookAddress;
      case Link.wishBoard:
        return AppStrings.wishBoardAddress;
      case Link.goodReads:
        return AppStrings.goodReadsAddress;
    }
  }
}
