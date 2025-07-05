import 'package:flutter_test/flutter_test.dart';
import 'package:turskyi/model/links.dart';
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
      expect(Link.github.address, Links.githubAddress);
      expect(Link.gists.address, Links.gistsAddress);
      expect(
        Link.linkedin.address,
        Links.linkedinAddress,
      );
      expect(Link.facebook.address, Links.facebookAddress);
      expect(Link.myWishBoard.address, Links.wishBoardAddress);
      expect(Link.goodreads.address, Links.goodReadsAddress);
      expect(Link.laoziAi.address, Links.laoziAiAddress);
      expect(Link.politerai.address, Links.politeraiAddress);
      expect(Link.annaStore.address, Links.annaStoreAddress);
    });
  });
}
