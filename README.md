# Princess App

Princess is a Flutter prototype for a beauty and salon app. It focuses on the first-time user flow: onboarding, sign up, sign in, profile setup, forgot password, OTP verification, password reset, and a simple dashboard after authentication.

The project is intentionally small, but it is structured like an app that can grow. The UI is driven by a custom dark, warm gradient design system with glassmorphism buttons and inputs.

## What is inside

- Onboarding flow with branded splash art and service illustrations.
- Authentication screens for welcome, sign in, sign up, and profile setup.
- Forgot/reset password flow with a 60-second OTP resend timer.
- Fake authentication repository so the app can run without Firebase, Supabase, or a backend.
- Riverpod providers for state and dependency wiring.
- GoRouter routes for screen navigation.
- Shared widgets for buttons, fields, dividers, loading state, auth background, and back navigation.

## Tech stack

- Flutter
- Dart
- Riverpod
- GoRouter
- Google Fonts
- Pinput
- Equatable

## Project structure

```text
lib/
  app.dart
  main.dart

  core/
    constants/     shared colors, assets, spacing, and routes
    errors/        app exceptions and failures
    result/        simple Success/Failure result type
    router/        GoRouter setup
    theme/         Material theme and typography
    widgets/       reusable UI components

  features/
    auth/
      data/        fake repository and user model
      domain/      entity, repository contract, and use cases
      presentation/controllers/
      presentation/screens/
      presentation/widgets/

    onboarding/
      domain/
      presentation/controllers/
      presentation/screens/
      presentation/widgets/
```

## Architecture notes

The auth feature follows a simple clean architecture shape:

```text
Screen -> AuthController -> UseCase -> AuthRepository -> FakeAuthRepository
```

The screens do not talk directly to the fake repository. They call the Riverpod controller, and the controller calls use cases. That keeps the UI separate from the data source and makes it easier to replace the fake repository later.

Right now, `FakeAuthRepository` simulates network delays and validation. For example, OTP verification accepts `1234`.

## Running the app

From the project root:

```bash
flutter pub get
flutter run
```

To run checks:

```bash
flutter analyze
flutter test
```

To build for web:

```bash
flutter build web
```

On this Windows machine, Flutter may not be on `PATH`. If that happens, use:

```powershell
C:\flutter\bin\flutter.bat analyze
C:\flutter\bin\flutter.bat test
C:\flutter\bin\flutter.bat run
```

## Useful test data

- Any valid-looking email works for the fake sign in/sign up flow.
- Passwords must be at least 6 characters.
- OTP code is `1234`.
- `error@test.com` triggers an invalid credentials error in the fake repository.

## Replacing fake auth later

Create a real repository in `lib/features/auth/data/repositories/` that implements `AuthRepository`, then update `authRepositoryProvider` in:

```text
lib/features/auth/presentation/controllers/auth_controller.dart
```

Example:

```dart
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return RealAuthRepository();
});
```

The screens and use cases should not need to change if the real repository follows the same contract.

## Current status

This is a polished frontend prototype, not a production auth implementation yet. The main next steps would be:

- Add real persistence for onboarding/auth state.
- Add route guards for authenticated-only screens.
- Replace `FakeAuthRepository` with a backend-backed implementation.
- Add focused widget and controller tests for the auth flows.
