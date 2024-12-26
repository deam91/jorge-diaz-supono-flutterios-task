import 'package:apply_at_supono/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double iconSize;
  final Color? borderColor;
  final Color? iconColor;

  const CircularButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 44,
    this.iconSize = 24,
    this.borderColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? AppColors.buttonBorderColor,
            width: 0.5,
          ),
        ),
        child: Icon(
          icon,
          color: iconColor ?? AppColors.buttonBorderColor,
          size: iconSize,
        ),
      ),
    );
  }
}
