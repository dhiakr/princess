import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/core/constants/app_routes.dart';
import 'package:princess_app/core/constants/app_spacing.dart';
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
      final success = await ref.read(authControllerProvider.notifier).signIn(
            _emailController.text.trim(),
            _passwordController.text,
          );

      if (success && mounted) {
        context.go('${AppRoutes.success}?title=Signed In!&subtitle=Welcome back to Princess');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    // Show error banner if present
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                const AuthHeader(
                  title: "Login to Your Account",
                  subtitle: "Enter your credentials to access your Princess account.",
                ),
                const SizedBox(height: 36),
                
                // Email field
                AppTextField(
                  controller: _emailController,
                  labelText: 'Email Address',
                  hintText: 'hello@example.com',
                  prefixIcon: const Icon(Icons.email_outlined),
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
                AppSpacing.hM,
                
                // Password field
                AppPasswordField(
                  controller: _passwordController,
                  labelText: 'Password',
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
                
                const SizedBox(height: 12),

                // Remember Me & Forgot Password Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _rememberMe,
                            activeColor: AppColors.primary,
                            checkColor: Colors.white,
                            side: const BorderSide(color: AppColors.primary, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            onChanged: (val) {
                              setState(() {
                                _rememberMe = val ?? false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Remember me',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => context.push(AppRoutes.forgotPassword),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 40),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Submit Button
                AppButton(
                  text: 'Sign In',
                  onPressed: _handleSignIn,
                ),
                
                const SizedBox(height: 32),
                const AuthDivider(),
                const SizedBox(height: 24),
                
                // Social Options
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
                
                const SizedBox(height: 24),
                
                // Sign Up link
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
                      onTap: () => context.pushReplacement(AppRoutes.signUp),
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
        ),
      ),
    );
  }
}
