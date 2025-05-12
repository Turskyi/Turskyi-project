import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presenter/home_presenter.dart';
import 'package:turskyi/res/configs/configs.dart';
import 'package:turskyi/res/values/dimens.dart';
import 'package:turskyi/res/values/radii.dart' as radii;
import 'package:turskyi/view/routes/link.dart';

class GoodReadsButton extends StatelessWidget {
  const GoodReadsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Consumer<HomePresenter>(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.indent4),
          child: Image.asset(
            '${Configs.of(context).configs.imageAssents}'
            'good_reads_logo.png',
            width: 112.0,
          ),
        ),
        builder: (BuildContext _, HomePresenter model, Widget? image) {
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFE9E9E9),
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.indent16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: radii.borderRadius,
                side: const BorderSide(color: Color(0xFFD8D5C2)),
              ),
            ),
            onPressed: () => model.onLaunchLink(
              Link.goodreads.address,
            ),
            child: image ?? const SizedBox(),
          );
        },
      ),
    );
  }
}
