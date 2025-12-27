import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presenter/home_presenter.dart';
import 'package:turskyi/view/pages/home/widgets/facebook_button.dart';
import 'package:turskyi/view/pages/home/widgets/good_reads_button.dart';
import 'package:turskyi/view/pages/home/widgets/wishlist_button_widget.dart';
import 'package:turskyi/view/routes/link.dart';

/// Build GoodReads, facebook and wishlist button.
class SocialButtonsRow extends StatelessWidget {
  const SocialButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const GoodReadsButton(),
        const FacebookButton(),
        Flexible(
          child: Consumer<HomePresenter>(
            builder: (BuildContext _, HomePresenter model, Widget? _) {
              return WishlistButtonWidget(
                dayCount: model.daysToBirthday,
                wishlistWidth: model.wishlistWidth,
                duration: model.expandDuration,
                onWishListButtonAnimate: model.onWishListButtonAnimate,
                onLaunchLink: () {
                  model.onLaunchLink(Link.myWishBoard.address);
                },
                animationRotation: model.rotationAnimation,
              );
            },
          ),
        ),
      ],
    );
  }
}
