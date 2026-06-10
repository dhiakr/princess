import 'package:princess_app/core/errors/app_exception.dart';
import 'package:princess_app/features/auth/domain/entities/app_user.dart';
import 'package:princess_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:princess_app/features/auth/data/models/user_model.dart';

class FakeAuthRepository implements AuthRepository {
  // Simulates an in-memory database of registered users
  final Map<String, UserModel> _mockDb = {};
  UserModel? _currentUser;

  Future<void> _simulateNetworkDelay([int ms = 800]) async {
    await Future.delayed(Duration(milliseconds: ms));
  }

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    await _simulateNetworkDelay(1000);

    if (email.isEmpty || password.isEmpty) {
      throw const AuthException('Email and password cannot be empty.');
    }

    if (!email.contains('@')) {
      throw const AuthException('Please enter a valid email address.');
    }

    if (password.length < 6) {
      throw const AuthException('Password must be at least 6 characters.');
    }

    // Custom check: for prototyping, if email is 'error@test.com' we throw an exception
    if (email == 'error@test.com') {
      throw const AuthException('Invalid credentials. Please try again.');
    }

    // Default mock user
    final user = UserModel(
      id: 'mock_uid_123',
      email: email,
      fullName: 'Princess Aloufa',
    );
    _currentUser = user;
    return user;
  }

  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
  }) async {
    await _simulateNetworkDelay(1000);

    if (email.isEmpty || password.isEmpty) {
      throw const AuthException('Email and password cannot be empty.');
    }

    if (!email.contains('@')) {
      throw const AuthException('Please enter a valid email address.');
    }

    if (password.length < 6) {
      throw const AuthException('Password must be at least 6 characters.');
    }

    final user = UserModel(
      id: 'mock_uid_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
    );
    _currentUser = user;
    _mockDb[user.id] = user;
    return user;
  }

  @override
  Future<AppUser> completeProfile({
    required String id,
    required String fullName,
    required String phoneNumber,
    required String birthDate,
    String? profilePictureUrl,
  }) async {
    await _simulateNetworkDelay(1200);

    if (fullName.trim().isEmpty) {
      throw const ValidationException('Full name is required.');
    }
    if (phoneNumber.trim().isEmpty) {
      throw const ValidationException('Phone number is required.');
    }
    if (birthDate.trim().isEmpty) {
      throw const ValidationException('Birth date is required.');
    }

    final updated = UserModel(
      id: id,
      email: _currentUser?.email ?? 'anonymous@example.com',
      fullName: fullName,
      phoneNumber: phoneNumber,
      birthDate: birthDate,
      profilePictureUrl: profilePictureUrl,
    );
    _currentUser = updated;
    return updated;
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    await _simulateNetworkDelay(800);

    if (email.isEmpty || !email.contains('@')) {
      throw const AuthException('Please provide a valid email address.');
    }
  }

  @override
  Future<void> verifyOtp(String otp) async {
    await _simulateNetworkDelay(1000);

    if (otp.length < 4 || otp != '1234') {
      throw const AuthException('Invalid OTP. Use the code: 1234.');
    }
  }

  @override
  Future<void> createNewPassword(String password) async {
    await _simulateNetworkDelay(1000);

    if (password.length < 6) {
      throw const AuthException('Password must be at least 6 characters long.');
    }
  }
}
