# Car Showroom App

A cross-platform car showroom application built with **Flutter and Dart**, focused on browsing vehicles and comparing options through a clean mobile interface.

## Features
- Browse a car catalog with list and grid layouts
- Search, filter, and sort available cars
- View detailed vehicle information
- Compare up to three cars
- Save favorite cars and view recently viewed vehicles
- Add new car listings
- Book test drives
- Calculate estimated vehicle installments
- Light and dark themes
- Arabic and English localization

## Tech Stack
- Flutter / Dart
- Provider for state management
- Repository pattern to separate data access from UI
- Mock repository and local in-memory data

## Architecture
```text
lib/
  core/        # Theme, constants, formatting
  models/      # Car, booking, and filter models
  data/        # Repository contract, mock repository, catalog
  providers/   # Application state
  screens/     # Main application screens
  widgets/     # Reusable UI components
```

## Getting Started
Requires Flutter 3.27 or later.

```bash
flutter pub get
flutter run
```

If the platform folders are not present in your local copy, generate them with Flutter's project-generation command before running the app.

## Data & Backend
The current version uses mock/local data. The repository abstraction is intended to make a future API-backed implementation easier; a production backend and persistent booking service are not included yet.

## Repository
https://github.com/abdallahkali/car_app
