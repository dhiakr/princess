import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/core/widgets/app_button.dart';
import 'package:princess_app/core/widgets/auth_scaffold.dart';

class SuccessScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String nextRoute;

  const SuccessScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.nextRoute,
  });

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
    _opacityAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBackButton: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 3),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: const _SuccessMark(),
            ),
            const SizedBox(height: 48),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.textPrimary,
                fontSize: 22,
                height: 1.25,
                fontWeight: FontWeight.w300,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                  height: 1.35,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const Spacer(flex: 4),
            AppButton(
              text: 'Continue',
              onPressed: () => context.go(widget.nextRoute),
            ),
            const SizedBox(height: 38),
          ],
        ),
      ),
    );
  }
}

class _SuccessMark extends StatelessWidget {
  const _SuccessMark();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(top: 12, left: 28, child: _Dot(size: 13)),
          const Positioned(top: 5, right: 55, child: _Dot(size: 4)),
          const Positioned(top: 19, right: 21, child: _Dot(size: 10)),
          const Positioned(left: 21, bottom: 48, child: _Dot(size: 7)),
          const Positioned(right: 20, bottom: 65, child: _Dot(size: 3)),
          const Positioned(right: 28, bottom: 34, child: _Dot(size: 4)),
          const Positioned(bottom: 24, left: 62, child: _Dot(size: 5)),
          Container(
            width: 94,
            height: 94,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFC86F8F).withValues(alpha: 0.76),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFC86F8F).withValues(alpha: 0.18),
                  blurRadius: 28,
                  spreadRadius: 6,
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: Colors.white, width: 2.2),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 23,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final double size;

  const _Dot({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFD9789A),
      ),
    );
  }
}
