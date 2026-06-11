import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/core/constants/app_routes.dart';
import 'package:princess_app/features/onboarding/domain/entities/onboarding_page.dart';
import 'package:princess_app/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:princess_app/features/onboarding/presentation/widgets/onboarding_page_view.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  Timer? _splashTimer;

  final List<OnboardingPage> _pages = const [
    OnboardingPage(
      title: 'Tailored Services\nJust For You.',
      description:
          'Enjoy personalized beauty care recommendations crafted specifically to fit your style.',
      imagePath: 'assets/images/notebook_check.png',
    ),
    OnboardingPage(
      title: 'Book With Ease,\nAnytime',
      description:
          'Schedule appointments instantly with your favorite stylist from the comfort of your home.',
      imagePath: 'assets/images/phone.png',
    ),
    OnboardingPage(
      title: 'Top-Rated Experts,\nPremium Core.',
      description:
          'Experience the ultimate luxury pampering from our carefully verified professional staff.',
      imagePath: 'assets/images/shield.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _splashTimer = Timer(const Duration(milliseconds: 2500), () {
      if (mounted &&
          _pageController.hasClients &&
          ref.read(onboardingIndexProvider) == 0) {
        _pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _splashTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPage(int currentIndex) {
    if (currentIndex < _pages.length) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      context.go(AppRoutes.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeIndex = ref.watch(onboardingIndexProvider);
    final showOverlayElements = activeIndex > 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const Positioned.fill(child: _OnboardingGradientBackground()),
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length + 1,
              onPageChanged: (index) {
                ref.read(onboardingIndexProvider.notifier).setIndex(index);
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const _OnboardingSplashView();
                }
                return OnboardingPageView(page: _pages[index - 1]);
              },
            ),
          ),
          if (showOverlayElements)
            Positioned(
              left: 32,
              right: 32,
              bottom: MediaQuery.of(context).padding.bottom + 35,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _OnboardingIndicator(
                    activeIndex: activeIndex - 1,
                    itemCount: _pages.length,
                  ),
                  const SizedBox(height: 25),
                  _GlassOnboardingButton(
                    label: activeIndex == _pages.length
                        ? 'Get Started'
                        : 'Next',
                    onPressed: () => _onNextPage(activeIndex),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _OnboardingSplashView extends StatelessWidget {
  const _OnboardingSplashView();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background face photo
        Positioned.fill(
          child: Image.asset(
            'assets/images/splash_face.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.08),
                  const Color(0xFF160B08).withValues(alpha: 0.58),
                  const Color(0xFF1A0A14).withValues(alpha: 0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(flex: 9),
                Opacity(
                  opacity: 0.28,
                  child: Image.asset(
                    'assets/images/Princess-Mark-White@2x-8 1.png',
                    width: 76,
                    height: 76,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 4),
                Opacity(
                  opacity: 0.22,
                  child: Image.asset(
                    'assets/images/Princess-Type-White@2x-8 1.png',
                    width: 128,
                    fit: BoxFit.contain,
                  ),
                ),
                const Spacer(flex: 2),
                const SizedBox(
                  width: 31,
                  height: 31,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFEED9D5),
                    ),
                  ),
                ),
                const SizedBox(height: 45),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardingGradientBackground extends StatelessWidget {
  const _OnboardingGradientBackground();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.1, -0.25),
          radius: 1.05,
          colors: [Color(0xFF8B563D), Color(0xFF4A2723), Color(0xFF20110F)],
          stops: [0, 0.54, 1],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -80,
            top: 150,
            child: _SoftGlow(
              color: AppColors.primary.withValues(alpha: 0.24),
              size: 260,
            ),
          ),
          Positioned(
            left: -75,
            bottom: -30,
            child: _SoftGlow(
              color: const Color(0xFF6B3830).withValues(alpha: 0.42),
              size: 280,
            ),
          ),
          Positioned(
            right: -20,
            bottom: -40,
            child: _SoftGlow(
              color: const Color(0xFF4C1842).withValues(alpha: 0.28),
              size: 220,
            ),
          ),
        ],
      ),
    );
  }
}

class _SoftGlow extends StatelessWidget {
  final Color color;
  final double size;

  const _SoftGlow({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
      ),
    );
  }
}

class _OnboardingIndicator extends StatelessWidget {
  final int activeIndex;
  final int itemCount;

  const _OnboardingIndicator({
    required this.activeIndex,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isSelected = activeIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOut,
          width: isSelected ? 17 : 5,
          height: 5,
          margin: const EdgeInsets.symmetric(horizontal: 2.5),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFF49ABB)
                : const Color(0xFFF8EDEB),
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}

class _GlassOnboardingButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _GlassOnboardingButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.2),
                Colors.white.withValues(alpha: 0.08),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(24),
              child: SizedBox(
                width: double.infinity,
                height: 35,
                child: Center(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFFEAD7D2),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
