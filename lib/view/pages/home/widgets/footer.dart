import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/model/links.dart';
import 'package:turskyi/presenter/home_presenter.dart';
import 'package:turskyi/res/configs/configs.dart';
import 'package:turskyi/res/values/dimens.dart';
import 'package:turskyi/res/values/strings.dart' as strings;
import 'package:turskyi/view/routes/app_route.dart';
import 'package:turskyi/view/routes/link.dart';
import 'package:turskyi/view/util/screen.dart' as screen;

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLarge = screen.isLarge(context);
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: SizedBox(
        height: 80.0,
        child: Consumer<HomePresenter>(
          builder: (
            BuildContext context,
            HomePresenter model,
            _,
          ) {
            final String imageAssents = Configs.of(
              context,
            ).configs.imageAssents;
            return ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                // Apple developer button.
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        Dimens.buttonRadius,
                      ),
                      onTap: () => model.onLaunchLink(
                        Links.appleDeveloperAddress,
                      ),
                      child: Image.asset(
                        '$imageAssents${strings.appStoreLogo}',
                        width: Dimens.indent140,
                      ),
                    ),
                  ),
                ),

                // Android developer button.
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(
                      Dimens.buttonRadius,
                    ),
                    onTap: () => model.onLaunchLink(
                      Links.androidDeveloperAddress,
                    ),
                    child: Image.asset(
                      '$imageAssents${strings.googlePlayLogo}',
                      color: Colors.white,
                      width: Dimens.indent140,
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () => model.onLaunchLink(
                    Link.annaStore.address,
                  ),
                  padding: const EdgeInsets.all(Dimens.indent8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      Dimens.buttonRadius,
                    ), // Square shape
                  ),
                  child: Image.asset(
                    '$imageAssents${strings.nextJsIcon}',
                    height: Dimens.indent40,
                    color: Colors.white,
                  ),
                ),
                RawMaterialButton(
                  onPressed: () => model.onLaunchLink(
                    Link.laoziAi.address,
                  ),
                  padding: const EdgeInsets.all(Dimens.indent8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      Dimens.buttonRadius,
                    ), // Square shape
                  ),
                  child: SvgPicture.asset(
                    '$imageAssents${strings.geminiLogo}',
                    height: Dimens.indent64,
                  ),
                ),
                RawMaterialButton(
                  onPressed: () => model.onLaunchLink(
                    Link.politerai.address,
                  ),
                  padding: const EdgeInsets.all(Dimens.indent8),
                  shape: const CircleBorder(),
                  child: Image.asset(
                    '$imageAssents${strings.gpt}',
                    height: Dimens.indent64,
                  ),
                ),

                // Determine if we should show game button.
                if (kIsWeb && isLarge)
                  RawMaterialButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoute.unityGame.path,
                    ),
                    padding: const EdgeInsets.all(Dimens.indent8),
                    shape: const CircleBorder(),
                    child: Image.asset(
                      '$imageAssents${strings.unity2dLogo}',
                      height: Dimens.indent64,
                    ),
                  ),
                if (kIsWeb && isLarge)
                  RawMaterialButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoute.game.path,
                    ),
                    padding: const EdgeInsets.all(Dimens.indent20),
                    shape: const CircleBorder(),
                    child: SvgPicture.asset(
                      '$imageAssents${strings.unityLogo}',
                      height: Dimens.indent40,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                RawMaterialButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRoute.support.path,
                  ),
                  padding: const EdgeInsets.all(Dimens.indent8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      Dimens.buttonRadius,
                    ),
                  ),
                  child: const Icon(
                    Icons.support_agent,
                    size: Dimens.indent40,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
