import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          // Prevent interaction
          ModalBarrier(
            dismissible: false,
            color: Colors.black.withValues(alpha: 0.4),
          ),
          // Blur effect and indicator
          Center(
            child: ClipRRect(
              borderRadius: AppSpacing.borderRadiusM,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.cardBg.withValues(alpha: 0.8),
                    borderRadius: AppSpacing.borderRadiusM,
                    border: Border.all(color: AppColors.cardBorder, width: 1.5),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                      strokeWidth: 3.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
