import 'package:flutter/material.dart';
import 'package:princess_app/core/constants/app_colors.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({super.key, required this.title, this.subtitle = ''});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.displayMedium?.copyWith(
            color: AppColors.textPrimary,
            fontSize: 22,
            height: 1.28,
            fontWeight: FontWeight.w300,
            letterSpacing: 0,
          ),
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.45,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ],
    );
  }
}
