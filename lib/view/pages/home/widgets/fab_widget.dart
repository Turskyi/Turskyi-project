import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presenter/home_presenter.dart';

class FabWidget extends StatelessWidget {
  const FabWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePresenter>(
      builder: (BuildContext context, HomePresenter model, Widget? child) {
        return FloatingActionButton(
          onPressed: model.onPhoneButtonPressed,
          child: child,
        );
      },
      child: const Icon(Icons.phone),
    );
  }
}
