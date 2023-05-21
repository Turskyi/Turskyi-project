import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/routes/link.dart';
import 'package:turskyi/presentation/values/app_dimens.dart';
import 'package:turskyi/presentation/values/app_radii.dart';
import 'package:turskyi/presentation/views/home/home_model.dart';

class GoodReadsButton extends StatelessWidget {
  const GoodReadsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (BuildContext context, HomeModel model, Widget? image) {
        return TextButton(
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFE9E9E9),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.indent16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadii.borderRadius,
              side: const BorderSide(color: Color(0xFFD8D5C2)),
            ),
          ),
          onPressed: () => model.onLaunchLink(
            Link.goodReads.address,
          ),
          child: image ?? const SizedBox(),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.indent4),
        child: Image.asset(
          '${AppConfigs.of(context).configs.imageAssents}'
          'good_reads_logo.png',
          width: 112.0,
        ),
      ),
    );
  }
}
