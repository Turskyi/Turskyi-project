import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presenter/home_presenter.dart';
import 'package:turskyi/res/configs/configs.dart';
import 'package:turskyi/res/values/dimens.dart';
import 'package:turskyi/res/values/radii.dart' as radii;

class WishlistButtonWidget extends StatelessWidget {
  const WishlistButtonWidget({
    required this.wishlistWidth,
    required this.duration,
    required this.onWishListButtonAnimate,
    required this.onLaunchLink,
    required this.animationRotation,
    required this.dayCount,
    super.key,
  });

  final double wishlistWidth;
  final Duration duration;
  final VoidCallback onWishListButtonAnimate;
  final VoidCallback onLaunchLink;
  final Animation<double> animationRotation;
  final String dayCount;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePresenter>(
      builder: (BuildContext context, HomePresenter model, Widget? button) {
        if (kIsWeb) {
          return MouseRegion(
            onEnter: model.onWishListButtonAnimate,
            onExit: model.onWishListButtonAnimate,
            child: button,
          );
        } else {
          return button ?? const SizedBox();
        }
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.all(Dimens.indent8),
        width: wishlistWidth,
        height: Dimens.heightColorButton,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.buttonRadius),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Configs.of(context).colors.colorWishlistWithOpacity,
              blurRadius: Dimens.blurRadius,
            ),
          ],
        ),
        duration: duration,
        child: TextButton(
          onLongPress: onWishListButtonAnimate,
          style: TextButton.styleFrom(
            backgroundColor: Configs.of(context).colors.colorWishlist,
            shape: RoundedRectangleBorder(borderRadius: radii.borderRadius),
          ),
          onPressed: onLaunchLink,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RotationTransition(
                turns: animationRotation,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.buttonRadius),
                  child: Image.asset(
                    '${Configs.of(context).configs.imageAssents}'
                    'mywishboard_logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  dayCount,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
