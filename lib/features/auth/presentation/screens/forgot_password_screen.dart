import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/core/constants/app_routes.dart';
import 'package:princess_app/core/constants/app_spacing.dart';
import 'package:princess_app/core/widgets/app_button.dart';
import 'package:princess_app/core/widgets/auth_scaffold.dart';
import 'package:princess_app/core/widgets/loading_overlay.dart';
import 'package:princess_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:princess_app/features/auth/presentation/widgets/auth_header.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  String _selectedChannel = 'email'; // 'email' or 'sms'

  void _handleContinue() async {
    final contactDetail = _selectedChannel == 'email' 
        ? 'ex***@domain.com' 
        : '+1 111******99';
    
    // Call repository to generate reset event session
    final success = await ref
        .read(authControllerProvider.notifier)
        .requestPasswordReset(_selectedChannel == 'email' ? 'ex***@domain.com' : 'sms_user@domain.com');

    if (success && mounted) {
      context.push('${AppRoutes.otp}?email=${Uri.encodeComponent(contactDetail)}');
    }
  }

  Widget _buildChannelCard({
    required String channelId,
    required String title,
    required String detail,
    required IconData icon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedChannel = channelId;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.cardBorder,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Icon Circle
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected 
                    ? AppColors.primary.withValues(alpha: 0.15)
                    : AppColors.cardBorder.withValues(alpha: 0.5),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Text Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    detail,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    // Listen for error feedback
    ref.listen<AuthFormState>(authControllerProvider, (previous, next) {
      if (next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
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
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const AuthHeader(
                title: "Forgot Password",
                subtitle: "Select which contact details we should use to reset your password.",
              ),
              const SizedBox(height: 36),
              
              // Option 1: via SMS
              _buildChannelCard(
                channelId: 'sms',
                title: 'via SMS:',
                detail: '+1 111******99',
                icon: Icons.chat_bubble_outline_rounded,
                isSelected: _selectedChannel == 'sms',
              ),
              
              AppSpacing.hM,
              
              // Option 2: via Email
              _buildChannelCard(
                channelId: 'email',
                title: 'via Email:',
                detail: 'ex***@domain.com',
                icon: Icons.mail_outline_rounded,
                isSelected: _selectedChannel == 'email',
              ),
              
              const SizedBox(height: 48),
              
              // Submit Button
              AppButton(
                text: 'Continue',
                onPressed: _handleContinue,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
