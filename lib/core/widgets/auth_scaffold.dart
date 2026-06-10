import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'app_back_button.dart';

class AuthScaffold extends StatelessWidget {
  final Widget child;
  final bool showBackButton;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;

  const AuthScaffold({
    super.key,
    required this.child,
    this.showBackButton = true,
    this.appBar,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: true,
      appBar:
          appBar ??
          (showBackButton
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: const Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 8.0),
                    child: AppBackButton(),
                  ),
                  leadingWidth: 56,
                )
              : null),
      bottomNavigationBar: bottomNavigationBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            // Background base gradient
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.darkBackgroundGradient,
                ),
              ),
            ),

            // Top-Center Accent Glow (Warm Gold)
            Positioned(
              top: -50,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Center(
                child: Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent.withValues(alpha: 0.14),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ),
            ),

            // Bottom-Right Primary Glow (Rose Pink)
            Positioned(
              bottom: -100,
              right: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryGlow.withValues(alpha: 0.15),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),

            // Content
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(child: child),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
