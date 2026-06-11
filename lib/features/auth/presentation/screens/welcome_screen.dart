import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/core/constants/app_routes.dart';
import 'package:princess_app/core/widgets/app_button.dart';
import 'package:princess_app/core/widgets/auth_divider.dart';
import 'package:princess_app/core/widgets/auth_scaffold.dart';
import 'package:princess_app/core/widgets/social_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBackButton: false,
      backgroundImage: 'assets/images/splash_face.png',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: Column(
          children: [
            const Spacer(flex: 8),
            Text(
              'Step Inside',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w300,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 2),
            Image.asset(
              'assets/images/Princess-Type-White@2x-8 1.png',
              width: 122,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 28),
            SocialButton(
              label: 'Continue with Google',
              svgPathOrContent: SocialButton.googleSvg,
              onPressed: () {
                context.go(
                  '${AppRoutes.success}?title=Signed In!&subtitle=Welcome back to Princess',
                );
              },
            ),
            const SizedBox(height: 12),
            SocialButton(
              label: 'Continue with Apple',
              svgPathOrContent: SocialButton.appleSvg,
              onPressed: () {
                context.go(
                  '${AppRoutes.success}?title=Signed In!&subtitle=Welcome back to Princess',
                );
              },
            ),
            const SizedBox(height: 20),
            const AuthDivider(text: 'or'),
            const SizedBox(height: 18),
            AppButton(
              text: 'Sign in with password',
              onPressed: () => context.push(AppRoutes.signIn),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
