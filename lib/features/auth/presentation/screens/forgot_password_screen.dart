import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/core/constants/app_routes.dart';
import 'package:princess_app/core/widgets/app_button.dart';
import 'package:princess_app/core/widgets/auth_scaffold.dart';
import 'package:princess_app/core/widgets/loading_overlay.dart';
import 'package:princess_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:princess_app/features/auth/presentation/widgets/auth_header.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  String _selectedChannel = 'sms';

  void _handleContinue() async {
    final contactDetail = _selectedChannel == 'email'
        ? 'roy***metoui@domain.com'
        : '+1 111 ******99';

    final success = await ref
        .read(authControllerProvider.notifier)
        .requestPasswordReset(
          _selectedChannel == 'email'
              ? 'example@domain.com'
              : 'sms_user@domain.com',
        );

    if (success && mounted) {
      context.push(
        '${AppRoutes.otp}?email=${Uri.encodeComponent(contactDetail)}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen<AuthFormState>(authControllerProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
        ref.read(authControllerProvider.notifier).clearError();
      }
    });

    return LoadingOverlay(
      isLoading: authState.isLoading,
      child: AuthScaffold(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 54),
              const AuthHeader(title: 'Forget Password'),
              const SizedBox(height: 76),
              Text(
                'Select which contact details should we use to\nreset your password',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 8,
                  height: 1.35,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 24),
              _ContactCard(
                title: 'Via SMS:',
                detail: '+1 111 ******99',
                icon: Icons.chat_bubble_rounded,
                isSelected: _selectedChannel == 'sms',
                onTap: () => setState(() => _selectedChannel = 'sms'),
              ),
              const SizedBox(height: 16),
              _ContactCard(
                title: 'Via Email:',
                detail: 'roy***metoui@domain.com',
                icon: Icons.mail_rounded,
                isSelected: _selectedChannel == 'email',
                onTap: () => setState(() => _selectedChannel = 'email'),
              ),
              const Spacer(),
              AppButton(text: 'Continue', onPressed: _handleContinue),
              const SizedBox(height: 38),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final String title;
  final String detail;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ContactCard({
    required this.title,
    required this.detail,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: isSelected ? 0.19 : 0.11),
                  Colors.white.withValues(alpha: isSelected ? 0.08 : 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.78)
                    : Colors.white.withValues(alpha: 0.12),
                width: isSelected ? 1.2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFC96A8A).withValues(alpha: 0.82),
                  ),
                  child: Icon(icon, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 18),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 8,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      detail,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
