import 'package:princess_app/features/auth/domain/entities/app_user.dart';

class AuthFormState {
  final bool isLoading;
  final String? errorMessage;
  final bool isAuthenticated;
  final AppUser? user;

  const AuthFormState({
    this.isLoading = false,
    this.errorMessage,
    this.isAuthenticated = false,
    this.user,
  });

  AuthFormState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isAuthenticated,
    AppUser? user,
  }) {
    return AuthFormState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // When passing custom, it overwrites it
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return 'AuthFormState(isLoading: $isLoading, errorMessage: $errorMessage, isAuthenticated: $isAuthenticated, user: $user)';
  }
}
