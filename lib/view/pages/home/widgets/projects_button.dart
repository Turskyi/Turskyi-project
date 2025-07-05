import 'package:flutter/material.dart';
import 'package:turskyi/res/values/dimens.dart';
import 'package:turskyi/view/util/screen.dart' as screen;

class ProjectsButton extends StatelessWidget {
  const ProjectsButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final bool isLarge = screen.isLarge(context);
    return Positioned(
      top: Dimens.indent24,
      right: Dimens.indent24,
      child: isLarge
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.black.withAlpha(25),
                foregroundColor: Colors.grey.shade300,
                side: BorderSide(color: Colors.grey.shade300),
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.indent16,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Projects',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
            )
          : Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onPressed,
                customBorder: const CircleBorder(),
                splashColor: Colors.white24,
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.folder_open,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
