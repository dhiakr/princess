import '../repositories/auth_repository.dart';

class CreateNewPasswordUseCase {
  final AuthRepository _repository;

  const CreateNewPasswordUseCase(this._repository);

  Future<void> call(String password) {
    return _repository.createNewPassword(password);
  }
}
