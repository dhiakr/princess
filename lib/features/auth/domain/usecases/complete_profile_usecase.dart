import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class CompleteProfileUseCase {
  final AuthRepository _repository;

  const CompleteProfileUseCase(this._repository);

  Future<AppUser> call({
    required String id,
    required String fullName,
    required String phoneNumber,
    required String birthDate,
    String? profilePictureUrl,
  }) {
    return _repository.completeProfile(
      id: id,
      fullName: fullName,
      phoneNumber: phoneNumber,
      birthDate: birthDate,
      profilePictureUrl: profilePictureUrl,
    );
  }
}
