import '../repositories/auth_repository.dart';

class RequestPasswordResetUseCase {
  final AuthRepository _repository;

  const RequestPasswordResetUseCase(this._repository);

  Future<void> call(String email) {
    return _repository.requestPasswordReset(email);
  }
}
