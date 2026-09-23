# CardVault

CardVault is a Flutter-based banking application focused on secure card management and control.

## Current Progress

### PR1 - Authentication Foundation

- Added the initial authentication feature structure
- Added `Session` domain model
- Added `AuthState` and `AuthStatus`
- Added session JSON parsing
- Added Riverpod, GoRouter, and Dio dependencies
- Verified the project with `flutter analyze`

## Tech Stack

- Flutter
- Dart
- Riverpod
- GoRouter
- Dio

## Project Structure

```text
lib/
├── app/
├── core/
└── features/
    └── auth/
        ├── data/
        ├── domain/
        ├── state/
        └── presentation/