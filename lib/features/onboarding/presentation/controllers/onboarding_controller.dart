import 'package:flutter_riverpod/legacy.dart';

class OnboardingController extends StateNotifier<int> {
  OnboardingController() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

final onboardingIndexProvider = StateNotifierProvider.autoDispose<OnboardingController, int>((ref) {
  return OnboardingController();
});
