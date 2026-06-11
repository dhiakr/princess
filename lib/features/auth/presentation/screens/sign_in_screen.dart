import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/core/constants/app_routes.dart';
import 'package:princess_app/core/widgets/app_button.dart';
import 'package:princess_app/core/widgets/app_password_field.dart';
import 'package:princess_app/core/widgets/app_text_field.dart';
import 'package:princess_app/core/widgets/auth_divider.dart';
import 'package:princess_app/core/widgets/auth_scaffold.dart';
import 'package:princess_app/core/widgets/loading_overlay.dart';
import 'package:princess_app/core/widgets/social_button.dart';
import 'package:princess_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:princess_app/features/auth/presentation/widgets/auth_header.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await ref
          .read(authControllerProvider.notifier)
          .signIn(_emailController.text.trim(), _passwordController.text);

      if (success && mounted) {
        context.go(
          '${AppRoutes.success}?title=Signed In!&subtitle=Welcome back to Princess',
        );
      }
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 54),
                const AuthHeader(title: 'Login to Your\nAccount'),
                const SizedBox(height: 24),
                AppTextField(
                  controller: _emailController,
                  hintText: 'Email Address',
                  prefixIcon: const Icon(Icons.mail_outline_rounded),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                AppPasswordField(
                  controller: _passwordController,
                  hintText: 'Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => _handleSignIn(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: Checkbox(
                        value: _rememberMe,
                        activeColor: const Color(0xFFD9789A),
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.52),
                          width: 0.8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        onChanged: (val) {
                          setState(() => _rememberMe = val ?? false);
                        },
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      'Remember me',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 9,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => context.push(AppRoutes.forgotPassword),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 24),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFFF0A1BA),
                          fontSize: 9,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                AppButton(text: 'Sign in', onPressed: _handleSignIn),
                const SizedBox(height: 76),
                const AuthDivider(),
                const SizedBox(height: 18),
                _SocialIconRow(
                  onGoogle: () => context.go(
                    '${AppRoutes.success}?title=Signed In!&subtitle=Welcome back to Princess',
                  ),
                  onApple: () => context.go(
                    '${AppRoutes.success}?title=Signed In!&subtitle=Welcome back to Princess',
                  ),
                ),
                const SizedBox(height: 20),
                _AuthSwitchText(
                  leading: 'Dont have an account ? ',
                  action: 'Sign up',
                  onTap: () => context.pushReplacement(AppRoutes.signUp),
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIconRow extends StatelessWidget {
  final VoidCallback onGoogle;
  final VoidCallback onApple;

  const _SocialIconRow({required this.onGoogle, required this.onApple});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButton(
          label: 'Facebook',
          svgPathOrContent: SocialButton.facebookSvg,
          compact: true,
          onPressed: () {},
        ),
        const SizedBox(width: 14),
        SocialButton(
          label: 'Google',
          svgPathOrContent: SocialButton.googleSvg,
          compact: true,
          onPressed: onGoogle,
        ),
        const SizedBox(width: 14),
        SocialButton(
          label: 'Apple',
          svgPathOrContent: SocialButton.appleSvg,
          compact: true,
          onPressed: onApple,
        ),
      ],
    );
  }
}

class _AuthSwitchText extends StatelessWidget {
  final String leading;
  final String action;
  final VoidCallback onTap;

  const _AuthSwitchText({
    required this.leading,
    required this.action,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          leading,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textPrimary,
            fontSize: 8,
            fontWeight: FontWeight.w300,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            action,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFFF0A1BA),
              fontSize: 8,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
