import 'package:flutter/material.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/values/app_dimens.dart';

class WishlistButtonWidget extends StatelessWidget {
  const WishlistButtonWidget({
    Key? key,
    required this.wishlistWidth,
    required this.duration,
    required this.onWishListButtonAnimate,
    required this.onLaunchLink,
    required this.animationRotation,
    required this.dayCount,
  }) : super(key: key);

  final double wishlistWidth;
  final Duration duration;
  final VoidCallback onWishListButtonAnimate;
  final VoidCallback onLaunchLink;
  final Animation<double> animationRotation;
  final String dayCount;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.all(8),
      width: wishlistWidth,
      height: AppDimens.heightColorButton,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppConfigs.of(context).colors.colorWishlistWithOpacity,
            blurRadius: AppDimens.blurRadius,
          ),
        ],
      ),
      duration: duration,
      child: TextButton(
        onLongPress: onWishListButtonAnimate,
        style: TextButton.styleFrom(
          backgroundColor: AppConfigs.of(context).colors.colorWishlist,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
          ),
        ),
        onPressed: onLaunchLink,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RotationTransition(
              turns: animationRotation,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
                child: Image.asset(
                  '${AppConfigs.of(context).configs.imageAssents}'
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
    );
  }
}
