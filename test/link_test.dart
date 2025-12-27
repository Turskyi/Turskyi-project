import 'package:flutter_test/flutter_test.dart';
import 'package:turskyi/model/links.dart' as links;
import 'package:turskyi/res/values/strings.dart' as strings;
import 'package:turskyi/view/routes/link.dart';

void main() {
  group('Link enum', () {
    test('title returns correct value', () {
      expect(Link.github.title, strings.github);
      expect(Link.gists.title, strings.gists);
      expect(Link.linkedin.title, strings.linkedin);
      expect(Link.facebook.title, Link.facebook.name);
      expect(Link.myWishBoard.title, Link.myWishBoard.name);
      expect(Link.goodreads.title, Link.goodreads.name);
      expect(Link.politerai.title, Link.politerai.name);
      expect(Link.laoziAi.title, strings.laoziAiTitle);
      expect(Link.annaStore.title, strings.annaStoreTitle);
    });

    test('address returns correct value', () {
      expect(Link.github.address, links.kGithubAddress);
      expect(Link.gists.address, links.kGistsAddress);
      expect(Link.linkedin.address, links.kLinkedinAddress);
      expect(Link.facebook.address, links.kFacebookAddress);
      expect(Link.myWishBoard.address, links.kWishBoardAddress);
      expect(Link.goodreads.address, links.kGoodReadsAddress);
      expect(Link.laoziAi.address, links.kLaoziAiAddress);
      expect(Link.politerai.address, links.kPoliteraiAddress);
      expect(Link.annaStore.address, links.kAnnaStoreAddress);
    });
  });
}
