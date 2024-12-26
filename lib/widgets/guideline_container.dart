import 'package:apply_at_supono/constants/app_colors.dart';
import 'package:flutter/material.dart';

class GuidelineContainer extends StatelessWidget {
  final Widget child;

  const GuidelineContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.blackTransparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.gray,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
