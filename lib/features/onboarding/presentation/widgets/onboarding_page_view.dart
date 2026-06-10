import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/core/constants/app_spacing.dart';
import 'package:princess_app/features/onboarding/domain/entities/onboarding_page.dart';

class OnboardingPageView extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingPageView({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration directly floating
          SizedBox(
            width: double.infinity,
            height: 280,
            child: Image.asset(
              page.imagePath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 48),

          // Title
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.displayMedium?.copyWith(
              height: 1.2,
              letterSpacing: -0.5,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          AppSpacing.hM,

          // Description
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
