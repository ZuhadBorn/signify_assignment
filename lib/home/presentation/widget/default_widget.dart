import 'package:flutter/material.dart';
import 'package:signify_demo_app/core/utilities/strings.dart';

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppStrings.backgroundImagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
