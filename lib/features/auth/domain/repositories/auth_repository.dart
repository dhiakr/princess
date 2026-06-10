import '../entities/app_user.dart';

abstract class AuthRepository {
  Future<AppUser> signIn({
    required String email,
    required String password,
  });

  Future<AppUser> signUp({
    required String email,
    required String password,
  });

  Future<AppUser> completeProfile({
    required String id,
    required String fullName,
    required String phoneNumber,
    required String birthDate,
    String? profilePictureUrl,
  });

  Future<void> requestPasswordReset(String email);

  Future<void> verifyOtp(String otp);

  Future<void> createNewPassword(String password);
}
