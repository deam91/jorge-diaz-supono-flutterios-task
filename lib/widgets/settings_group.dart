import 'package:apply_at_supono/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  final Widget child;

  const SettingsGroup({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.settingsGroupBg.withValues(alpha: .45),
            borderRadius: BorderRadius.circular(15),
          ),
          child: child,
        ),
      ),
    );
  }
}
