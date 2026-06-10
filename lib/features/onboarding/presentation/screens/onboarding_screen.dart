import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:princess_app/core/constants/app_colors.dart';
import 'package:princess_app/core/constants/app_routes.dart';
import 'package:princess_app/core/constants/app_spacing.dart';
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
      title: 'Tailored Services Just For You.',
      description:
          'Enjoy personalized beauty care recommendations crafted specifically to fit your style.',
      imagePath: 'assets/images/onboarding_services.png',
    ),
    OnboardingPage(
      title: 'Book With Ease, Anytime.',
      description:
          'Schedule appointments instantly with your favorite stylist from the comfort of your home.',
      imagePath: 'assets/images/onboarding_booking.png',
    ),
    OnboardingPage(
      title: 'Top-Rated Experts, Premium Care.',
      description:
          'Experience the ultimate luxury pampering from our carefully verified professional staff.',
      imagePath: 'assets/images/onboarding_experts.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _splashTimer = Timer(const Duration(milliseconds: 2500), () {
      if (mounted && _pageController.hasClients && ref.read(onboardingIndexProvider) == 0) {
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
          // Pages Scroll Area
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

          // Conditional Top Skip Button
          if (showOverlayElements)
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              right: 16,
              child: TextButton(
                onPressed: () => context.go(AppRoutes.welcome),
                child: Text(
                  'Skip',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),

          // Conditional Bottom Indicator and Button Actions
          if (showOverlayElements)
            Positioned(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).padding.bottom + 24,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Center Custom Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (index) {
                      final isSelected = (activeIndex - 1) == index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: isSelected ? 24 : 8,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : AppColors.cardBorder,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 28),

                  // Center Wide Next Button
                  SizedBox(
                    width: 220,
                    height: 52,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        gradient: AppColors.primaryGradient,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => _onNextPage(activeIndex),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          activeIndex == _pages.length ? 'Get Started' : 'Next',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                        ),
                      ),
                    ),
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
        // Gradient vignette overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.15),
                  const Color(0xFF130907).withValues(alpha: 0.92),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        // Branding text & progress indicator
        Positioned.fill(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(flex: 6),
                Text(
                  'Princess',
                  style: GoogleFonts.outfit(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFBF8F7),
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'BEAUTY & SALON',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accent,
                    letterSpacing: 6,
                  ),
                ),
                const Spacer(flex: 3),
                const SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
