import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:princess_app/core/constants/app_assets.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/core/constants/app_spacing.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pulsing / Styled Vector Logo Container
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: AppSpacing.borderRadiusM,
            border: Border.all(
              color: AppColors.cardBorder,
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.all(AppSpacing.s),
          child: SvgPicture.string(
            AppAssets.logoSvg,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 32),
        
        // Title
        Text(
          title,
          style: theme.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        AppSpacing.hS,
        
        // Subtitle
        Text(
          subtitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
