import 'package:flutter/material.dart';
import 'package:repat_event/core/themes/app_colors.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    required this.title,
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      overlayColor: WidgetStatePropertyAll(
        AppColors.primary.withValues(alpha: 0.1),
      ),
      borderRadius: BorderRadius.circular(5),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'SFProDisplay',
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
