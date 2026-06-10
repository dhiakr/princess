import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/core/constants/app_spacing.dart';
import 'package:princess_app/core/widgets/app_button.dart';
import 'package:princess_app/core/widgets/auth_scaffold.dart';

class SuccessScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String nextRoute;

  const SuccessScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.nextRoute,
  });

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AuthScaffold(
      showBackButton: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
        child: Column(
          children: [
            const Spacer(),

            // Animated Glowing Checkmark
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 30,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 64,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),

            // Title
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpacing.hM,

            // Subtitle
            Text(
              widget.subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),

            const Spacer(),

            // Action Button
            AppButton(
              text: 'Continue',
              onPressed: () => context.go(widget.nextRoute),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
