# Car Showroom App

A cross-platform Flutter application for browsing a car catalog, comparing vehicles, and exploring a simple test-drive booking flow.

## Features

- Browse cars in catalog layouts
- Search, filter, and sort vehicle listings
- View vehicle details
- Compare up to three cars
- Add cars and explore a test-drive booking flow
- Favorites and recently viewed vehicles
- Estimated installment calculator
- Light and dark themes
- Arabic and English localization

## Tech Stack

- Flutter and Dart
- Provider for state management
- Repository pattern with a mock data source
- Reusable widgets and separated models, providers, and screens

## Screenshots

Real in-app screenshots have not been added to this repository yet. Capture the running application and add the images under `screenshots/`. Suggested filenames:

- `screenshots/01-home.png`
- `screenshots/02-car-details.png`
- `screenshots/03-car-comparison.png`
- `screenshots/04-test-drive.png`

## Project Structure

```text
lib/
  core/        # Theme, constants, and formatting
  models/      # Car, booking, and filter models
  data/        # Repository contract, mock repository, and catalog
  providers/   # Application state
  screens/     # Main application screens
  widgets/     # Reusable UI components
```

## Getting Started

### Requirements

- Flutter SDK with Dart **3.3 or later**
- Android Studio or another Flutter-supported IDE
- An Android emulator or a connected device

### Run locally

1. Clone the repository:
   ```bash
   git clone https://github.com/abdallahkali/car_app.git
   ```
2. Open the project directory:
   ```bash
   cd car_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Check available devices:
   ```bash
   flutter devices
   ```
5. Run the app:
   ```bash
   flutter run
   ```

To target a particular device, use `flutter run -d <device-id>`.

## Data and Limitations

- The current catalog and booking flow use mock/in-memory data.
- A production backend, server-side booking service, and persistent cloud storage are not included.
- The installment calculator is an estimate and should not be treated as a bank quotation.

## Repository

https://github.com/abdallahkali/car_app
