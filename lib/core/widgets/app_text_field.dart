import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool autofocus;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool obscureText;

  const AppTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.autofocus = false,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.onTap,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          AppSpacing.hS,
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: TextFormField(
              controller: controller,
              validator: validator,
              keyboardType: keyboardType,
              autofocus: autofocus,
              textInputAction: textInputAction,
              onFieldSubmitted: onFieldSubmitted,
              readOnly: readOnly,
              onTap: onTap,
              obscureText: obscureText,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                isDense: true,
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.09),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 14,
                ),
                border: _border(Colors.white.withValues(alpha: 0.13)),
                enabledBorder: _border(Colors.white.withValues(alpha: 0.13)),
                focusedBorder: _border(Colors.white.withValues(alpha: 0.27)),
                errorBorder: _border(AppColors.error.withValues(alpha: 0.75)),
                focusedErrorBorder: _border(AppColors.error),
                hintStyle: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary.withValues(alpha: 0.72),
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                ),
                prefixIcon: prefixIcon != null
                    ? IconTheme(
                        data: IconThemeData(
                          color: AppColors.textPrimary.withValues(alpha: 0.82),
                          size: 16,
                        ),
                        child: prefixIcon!,
                      )
                    : null,
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 42,
                  minHeight: 40,
                ),
                suffixIcon: suffixIcon != null
                    ? IconTheme(
                        data: IconThemeData(
                          color: AppColors.textPrimary.withValues(alpha: 0.82),
                          size: 16,
                        ),
                        child: suffixIcon!,
                      )
                    : null,
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 42,
                  minHeight: 40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}
