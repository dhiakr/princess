import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/core/constants/app_routes.dart';
import 'package:princess_app/core/constants/app_spacing.dart';
import 'package:princess_app/core/widgets/app_button.dart';
import 'package:princess_app/core/widgets/auth_divider.dart';
import 'package:princess_app/core/widgets/auth_scaffold.dart';
import 'package:princess_app/core/widgets/social_button.dart';
import 'package:princess_app/features/auth/presentation/widgets/auth_header.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBackButton: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
        child: Column(
          children: [
            const Spacer(),
            
            // Header Content
            const AuthHeader(
              title: "Step Inside Princess",
              subtitle: "Welcome back. Log in or create an account to start your premium experience.",
            ),
            
            const Spacer(),
            
            // Social Credentials (Google and Apple first)
            SocialButton(
              label: 'Continue with Google',
              svgPathOrContent: SocialButton.googleSvg,
              onPressed: () {
                context.go('${AppRoutes.success}?title=Signed In!&subtitle=Welcome back to Princess');
              },
            ),
            AppSpacing.hM,
            
            SocialButton(
              label: 'Continue with Apple',
              svgPathOrContent: SocialButton.appleSvg,
              onPressed: () {
                context.go('${AppRoutes.success}?title=Signed In!&subtitle=Welcome back to Princess');
              },
            ),
            
            AppSpacing.hL,
            const AuthDivider(text: 'or'),
            AppSpacing.hL,

            // Password Login Button (Primary Button)
            AppButton(
              text: 'Sign In with Password',
              onPressed: () => context.push(AppRoutes.signIn),
            ),
            
            const Spacer(),
            
            // Sign Up redirect at bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                InkWell(
                  onTap: () => context.push(AppRoutes.signUp),
                  child: Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
