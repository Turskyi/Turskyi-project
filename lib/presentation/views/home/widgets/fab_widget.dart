import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presentation/views/home/home_model.dart';

class FabWidget extends StatelessWidget {
  const FabWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (BuildContext context, HomeModel model, Widget? child) {
        return FloatingActionButton(
          onPressed: model.onPhoneButtonPressed,
          child: child,
        );
      },
      child: const Icon(Icons.phone),
    );
  }
}
