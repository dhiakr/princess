import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'app_back_button.dart';

class AuthScaffold extends StatelessWidget {
  final Widget child;
  final bool showBackButton;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final String? backgroundImage;

  const AuthScaffold({
    super.key,
    required this.child,
    this.showBackButton = true,
    this.appBar,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = true,
    this.backgroundImage,
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
            if (backgroundImage != null)
              Positioned.fill(
                child: Image.asset(backgroundImage!, fit: BoxFit.cover),
              ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: backgroundImage == null
                      ? const RadialGradient(
                          center: Alignment(0.16, -0.38),
                          radius: 1.12,
                          colors: [
                            Color(0xFF8B563D),
                            Color(0xFF5E3330),
                            Color(0xFF21100F),
                          ],
                          stops: [0, 0.5, 1],
                        )
                      : LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.18),
                            const Color(0xFF170A08).withValues(alpha: 0.62),
                            const Color(0xFF1A0A14).withValues(alpha: 0.94),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                ),
              ),
            ),
            Positioned(
              right: -80,
              top: 130,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.2),
                      AppColors.primary.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: -90,
              bottom: -40,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF67352F).withValues(alpha: 0.42),
                      const Color(0xFF67352F).withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
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
