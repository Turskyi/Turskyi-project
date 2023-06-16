import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/main/res/configs/configs.dart';
import 'package:turskyi/main/res/values/dimens.dart';
import 'package:turskyi/main/res/values/radii.dart';
import 'package:turskyi/presenter/home_presenter.dart';
import 'package:turskyi/view/routes/link.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.heightColorButton,
      margin: const EdgeInsets.all(Dimens.indent8),
      decoration: BoxDecoration(
        borderRadius: Radii.borderRadius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Configs.of(context).colors.colorFacebookWithOpacity,
            blurRadius: Dimens.blurRadius,
          ),
        ],
      ),
      child: Consumer<HomePresenter>(
        builder: (BuildContext context, HomePresenter model, Widget? child) {
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Configs.of(context).colors.colorFacebook,
              minimumSize: const Size(88, 36),
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.indent16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: Radii.borderRadius,
                side: BorderSide(
                  color: Configs.of(context).colors.colorFacebook,
                ),
              ),
            ),
            onPressed: () => model.onLaunchLink(Link.facebook.address),
            child: kIsWeb
                ? Image.asset(
              '${Configs.of(context).configs.imageAssents}'
                    'pic_facebook.png',
                    width: Dimens.widthFacebook,
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
              '${Configs.of(context).configs.imageAssents}'
                    'pic_facebook.svg',
                    width: Dimens.widthFacebook,
                    fit: BoxFit.cover,
                  ),
          );
        },
      ),
    );
  }
}
