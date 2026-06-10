import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String id;
  final String email;
  final String? fullName;
  final String? phoneNumber;
  final String? birthDate;
  final String? profilePictureUrl;

  const AppUser({
    required this.id,
    required this.email,
    this.fullName,
    this.phoneNumber,
    this.birthDate,
    this.profilePictureUrl,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        fullName,
        phoneNumber,
        birthDate,
        profilePictureUrl,
      ];
}
