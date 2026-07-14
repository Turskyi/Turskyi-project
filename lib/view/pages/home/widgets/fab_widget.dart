import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presenter/home_presenter.dart';

class FabWidget extends StatelessWidget {
  const FabWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return Consumer<HomePresenter>(
      builder:
          (
            final BuildContext context,
            final HomePresenter model,
            final Widget? child,
          ) {
            return FloatingActionButton(
              onPressed: model.onPhoneButtonPressed,
              child: child,
            );
          },
      child: const Icon(Icons.phone),
    );
  }
}
