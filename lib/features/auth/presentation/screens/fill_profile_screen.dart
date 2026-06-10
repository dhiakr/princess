import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/core/constants/app_routes.dart';
import 'package:princess_app/core/constants/app_spacing.dart';
import 'package:princess_app/core/widgets/app_button.dart';
import 'package:princess_app/core/widgets/app_text_field.dart';
import 'package:princess_app/core/widgets/auth_scaffold.dart';
import 'package:princess_app/core/widgets/loading_overlay.dart';
import 'package:princess_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:princess_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:princess_app/features/auth/presentation/widgets/profile_avatar.dart';

class FillProfileScreen extends ConsumerStatefulWidget {
  const FillProfileScreen({super.key});

  @override
  ConsumerState<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends ConsumerState<FillProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedGender;
  String? _avatarUrl;

  @override
  void dispose() {
    _fullNameController.dispose();
    _nicknameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleCompleteProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await ref.read(authControllerProvider.notifier).completeProfile(
            fullName: _fullNameController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            birthDate: _birthDateController.text.trim(),
            profilePictureUrl: _avatarUrl,
          );

      if (success && mounted) {
        context.go(
          '${AppRoutes.success}'
          '?title=Profile Setup!&subtitle=Your profile was created successfully'
          '&nextRoute=${AppRoutes.dashboard}',
        );
      }
    }
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              surface: AppColors.cardBg,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && mounted) {
      setState(() {
        _birthDateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
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
                const SizedBox(height: 16),
                const AuthHeader(
                  title: "Fill Your Profile",
                  subtitle: "Enter details to build a personalized experience.",
                ),
                const SizedBox(height: 28),
                
                // Avatar Picker
                ProfileAvatar(
                  onAvatarChanged: (url) {
                    _avatarUrl = url;
                  },
                ),
                const SizedBox(height: 28),
                
                // Full Name
                AppTextField(
                  controller: _fullNameController,
                  labelText: 'Full Name',
                  hintText: 'Full Name',
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Full name is required';
                    }
                    return null;
                  },
                ),
                AppSpacing.hM,

                // Nickname
                AppTextField(
                  controller: _nicknameController,
                  labelText: 'Nickname',
                  hintText: 'Nickname',
                  prefixIcon: const Icon(Icons.face_outlined),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nickname is required';
                    }
                    return null;
                  },
                ),
                AppSpacing.hM,
                
                // Birth Date (Interactive DatePicker trigger)
                AppTextField(
                  controller: _birthDateController,
                  labelText: 'Birth Date',
                  hintText: 'YYYY-MM-DD',
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                  readOnly: true,
                  onTap: () => _selectBirthDate(context),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Birth date is required';
                    }
                    return null;
                  },
                ),
                AppSpacing.hM,

                // Email
                AppTextField(
                  controller: _emailController,
                  labelText: 'Email Address',
                  hintText: 'hello@example.com',
                  prefixIcon: const Icon(Icons.email_outlined),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                AppSpacing.hM,
                
                // Phone Number
                AppTextField(
                  controller: _phoneController,
                  labelText: 'Phone Number',
                  hintText: '+1 123 456 7890',
                  prefixIcon: const Icon(Icons.phone_outlined),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Phone number is required';
                    }
                    return null;
                  },
                ),
                AppSpacing.hM,

                // Gender Selection
                Text(
                  'Gender',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                AppSpacing.hS,
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: const InputDecoration(
                    hintText: 'Select Gender',
                    prefixIcon: Icon(Icons.wc_outlined, color: AppColors.textSecondary),
                  ),
                  dropdownColor: AppColors.cardBg,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textPrimary),
                  items: const ['Female', 'Male', 'Other']
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Gender is required';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 40),
                
                // Continue Button
                AppButton(
                  text: 'Save & Continue',
                  onPressed: _handleCompleteProfile,
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
