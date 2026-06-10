import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/core/constants/app_routes.dart';
import 'package:princess_app/core/constants/app_spacing.dart';
import 'package:princess_app/core/widgets/app_button.dart';
import 'package:princess_app/features/auth/presentation/controllers/auth_controller.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final user = authState.user;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Princess Console',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppColors.error),
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
              context.go(AppRoutes.welcome);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSpacing.hM,

              // Welcome Banner
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.l),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.1,
                        ),
                        child: const Icon(
                          Icons.verified_user_rounded,
                          color: AppColors.success,
                          size: 44,
                        ),
                      ),
                      AppSpacing.hM,
                      Text(
                        'Welcome, ${user?.fullName ?? "Princess Dev"}!',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSpacing.hS,
                      Text(
                        user?.email ?? 'dev@princess.io',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.hL,

              Text(
                'Architecture Checklist',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              AppSpacing.hM,

              // Dynamic listing of clean architecture items
              Expanded(
                child: ListView(
                  children: const [
                    _FeatureTile(
                      icon: Icons.layers_outlined,
                      title: 'Domain & Data Boundary',
                      subtitle:
                          'UI depends on Usecases which talk to Repository abstractions. Fake implementation is completely isolated.',
                    ),
                    _FeatureTile(
                      icon: Icons.code_rounded,
                      title: 'Riverpod 3 States',
                      subtitle:
                          'Uses StateNotifierProvider. Fully unit-testable and decouples screen layouts from business rule steps.',
                    ),
                    _FeatureTile(
                      icon: Icons.alt_route_rounded,
                      title: 'GoRouter Navigation',
                      subtitle:
                          'Dynamic deep-linking and cleaner page mapping with query parameter support.',
                    ),
                    _FeatureTile(
                      icon: Icons.style_outlined,
                      title: 'Premium Design System',
                      subtitle:
                          'Harmonious custom dark palette with glassmorphism borders and glowing gradient components.',
                    ),
                  ],
                ),
              ),

              AppButton(
                text: 'Sign Out',
                isSecondary: true,
                onPressed: () {
                  ref.read(authControllerProvider.notifier).signOut();
                  context.go(AppRoutes.welcome);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.m),
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: AppSpacing.borderRadiusM,
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          AppSpacing.wM,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSpacing.hXs,
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
