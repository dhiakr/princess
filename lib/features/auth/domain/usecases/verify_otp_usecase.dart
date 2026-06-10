import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository _repository;

  const VerifyOtpUseCase(this._repository);

  Future<void> call(String otp) {
    return _repository.verifyOtp(otp);
  }
}
