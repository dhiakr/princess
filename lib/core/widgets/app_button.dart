import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isSecondary;
  final Widget? icon;
  final double? width;
  final double height;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isSecondary = false,
    this.icon,
    this.width,
    this.height = 54.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = onPressed != null && !isLoading;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.0),
          boxShadow: isEnabled && !isSecondary
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
          gradient: isEnabled
              ? (isSecondary ? null : AppColors.primaryGradient)
              : null,
          color: isEnabled
              ? (isSecondary ? Colors.transparent : null)
              : AppColors.cardBg,
          border: isSecondary && isEnabled
              ? Border.all(color: AppColors.primary, width: 1.5)
              : (!isEnabled
                    ? Border.all(color: AppColors.cardBorder, width: 1)
                    : null),
        ),
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[icon!, AppSpacing.wS],
                    Text(
                      text,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isEnabled
                            ? (isSecondary ? AppColors.primary : Colors.white)
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
