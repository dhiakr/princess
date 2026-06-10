import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/fake_auth_repository.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/complete_profile_usecase.dart';
import '../../domain/usecases/request_password_reset_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/create_new_password_usecase.dart';
import 'auth_form_state.dart';
export 'auth_form_state.dart';

// Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FakeAuthRepository();
});

// UseCase Providers
final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
});

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
});

final completeProfileUseCaseProvider = Provider<CompleteProfileUseCase>((ref) {
  return CompleteProfileUseCase(ref.watch(authRepositoryProvider));
});

final requestPasswordResetUseCaseProvider = Provider<RequestPasswordResetUseCase>((ref) {
  return RequestPasswordResetUseCase(ref.watch(authRepositoryProvider));
});

final verifyOtpUseCaseProvider = Provider<VerifyOtpUseCase>((ref) {
  return VerifyOtpUseCase(ref.watch(authRepositoryProvider));
});

final createNewPasswordUseCaseProvider = Provider<CreateNewPasswordUseCase>((ref) {
  return CreateNewPasswordUseCase(ref.watch(authRepositoryProvider));
});

// Controller Provider
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthFormState>((ref) {
  return AuthController(
    signInUseCase: ref.watch(signInUseCaseProvider),
    signUpUseCase: ref.watch(signUpUseCaseProvider),
    completeProfileUseCase: ref.watch(completeProfileUseCaseProvider),
    requestPasswordResetUseCase: ref.watch(requestPasswordResetUseCaseProvider),
    verifyOtpUseCase: ref.watch(verifyOtpUseCaseProvider),
    createNewPasswordUseCase: ref.watch(createNewPasswordUseCaseProvider),
  );
});

class AuthController extends StateNotifier<AuthFormState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final CompleteProfileUseCase completeProfileUseCase;
  final RequestPasswordResetUseCase requestPasswordResetUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final CreateNewPasswordUseCase createNewPasswordUseCase;

  AuthController({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.completeProfileUseCase,
    required this.requestPasswordResetUseCase,
    required this.verifyOtpUseCase,
    required this.createNewPasswordUseCase,
  }) : super(const AuthFormState());

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  Future<bool> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await signInUseCase(email: email, password: password);
      state = state.copyWith(isLoading: false, isAuthenticated: true, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await signUpUseCase(email: email, password: password);
      state = state.copyWith(isLoading: false, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> completeProfile({
    required String fullName,
    required String phoneNumber,
    required String birthDate,
    String? profilePictureUrl,
  }) async {
    final userId = state.user?.id;
    if (userId == null) {
      state = state.copyWith(errorMessage: 'No active registration session found.');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await completeProfileUseCase(
        id: userId,
        fullName: fullName,
        phoneNumber: phoneNumber,
        birthDate: birthDate,
        profilePictureUrl: profilePictureUrl,
      );
      state = state.copyWith(isLoading: false, isAuthenticated: true, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> requestPasswordReset(String email) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await requestPasswordResetUseCase(email);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await verifyOtpUseCase(otp);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> createNewPassword(String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await createNewPasswordUseCase(password);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  void signOut() {
    state = const AuthFormState();
  }
}
