import 'package:flutter/material.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/features/onboarding/domain/entities/onboarding_page.dart';

class OnboardingPageView extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingPageView({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const SizedBox(height: 36),
            Opacity(
              opacity: 0.22,
              child: Image.asset(
                'assets/images/Princess-Mark-White@2x-8 1.png',
                width: 42,
                height: 42,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: size.height * 0.09),
            SizedBox(
              width: double.infinity,
              height: size.height * 0.23,
              child: Image.asset(page.imagePath, fit: BoxFit.contain),
            ),
            const SizedBox(height: 42),
            Text(
              page.title,
              textAlign: TextAlign.center,
              style: theme.textTheme.displayMedium?.copyWith(
                height: 1.45,
                letterSpacing: 0,
                fontSize: 19,
                fontWeight: FontWeight.w300,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
