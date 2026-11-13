# Car Showroom App

A Flutter application prototype for exploring a car catalog, comparing vehicles, and trying a test-drive booking flow.

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.3%2B-02569B?logo=flutter" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.3%2B-0175C2?logo=dart" alt="Dart">
  <img src="https://img.shields.io/badge/State%20Management-Provider-7B1FA2" alt="Provider">
</p>

## Overview

The app brings common car-showroom browsing tasks into one mobile experience: discovering vehicles, narrowing results, reviewing specifications, comparing options, and exploring a test-drive request flow.

## Features

- Browse vehicle listings and view car details
- Search, filter, and sort the catalog
- Compare up to three vehicles
- Add cars and explore a test-drive booking flow
- Favorites and recently viewed vehicles
- Estimated installment calculator
- Light and dark themes
- Arabic and English localization

## Screenshots

Real app screenshots can be added here after capturing the running application. Suggested gallery:

| Home & car catalog | Car details |
|---|---|
| `screenshots/01-home.png` | `screenshots/02-car-details.png` |

| Compare vehicles | Test-drive flow |
|---|---|
| `screenshots/03-comparison.png` | `screenshots/04-test-drive.png` |

## Built With

- **Flutter & Dart** — cross-platform application
- **Provider** — state management
- **Repository pattern** — separates catalog access from UI
- **Mock data source** — sample vehicle catalog
- **Reusable widgets** — shared interface components

## Getting Started

### Prerequisites

- Flutter SDK with Dart 3.3 or later
- Android Studio or another Flutter-supported IDE
- Android emulator or connected device

### Run locally

```bash
git clone https://github.com/abdallahkali/car_app.git
cd car_app
flutter pub get
flutter devices
flutter run
```

Run on a specific device with `flutter run -d <device-id>`.

## Project Structure

```text
lib/
  core/        # Theme, constants, and formatting
  models/      # Car, booking, and filter models
  data/        # Repository contract and mock repository
  providers/   # Application state
  screens/     # Main application screens
  widgets/     # Reusable UI components
```

## Current Scope & Limitations

- Vehicle catalog and booking flow use mock/in-memory data.
- A production backend and server-side booking service are not included.
- The installment calculator is an estimate, not a bank quotation.

## Author

**Abdallah Khalifa** · [GitHub](https://github.com/abdallahkali)

[⬆ Back to top](#car-showroom-app)
