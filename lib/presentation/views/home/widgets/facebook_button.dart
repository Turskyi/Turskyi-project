import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/routes/link.dart';
import 'package:turskyi/presentation/values/app_dimens.dart';
import 'package:turskyi/presentation/values/app_radii.dart';
import 'package:turskyi/presentation/views/home/home_model.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.heightColorButton,
      margin: const EdgeInsets.all(AppDimens.indent8),
      decoration: BoxDecoration(
        borderRadius: AppRadii.borderRadius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppConfigs.of(context).colors.colorFacebookWithOpacity,
            blurRadius: AppDimens.blurRadius,
          ),
        ],
      ),
      child: Consumer<HomeModel>(
        builder: (BuildContext context, HomeModel model, Widget? child) {
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppConfigs.of(context).colors.colorFacebook,
              minimumSize: const Size(88, 36),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.indent16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: AppRadii.borderRadius,
                side: BorderSide(
                  color: AppConfigs.of(context).colors.colorFacebook,
                ),
              ),
            ),
            onPressed: () => model.onLaunchLink(Link.facebook.address),
            child: kIsWeb
                ? Image.asset(
                    '${AppConfigs.of(context).configs.imageAssents}'
                    'pic_facebook.png',
                    width: AppDimens.widthFacebook,
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
                    '${AppConfigs.of(context).configs.imageAssents}'
                    'pic_facebook.svg',
                    width: AppDimens.widthFacebook,
                    fit: BoxFit.cover,
                  ),
          );
        },
      ),
    );
  }
}
