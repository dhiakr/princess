import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AppBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap:
            onPressed ??
            () {
              if (context.canPop()) {
                context.pop();
              }
            },
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.cardBg.withValues(alpha: 0.5),
            border: Border.all(color: AppColors.cardBorder, width: 1),
          ),
          child: const Icon(
            Icons.chevron_left_rounded,
            color: AppColors.textPrimary,
            size: 24,
          ),
        ),
      ),
    );
  }
}
