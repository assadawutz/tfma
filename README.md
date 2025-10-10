# TFMA Mobile Application

This repository contains the Flutter application for TFMA. The project targets both Android and iOS platforms and is configured to produce distributable artifacts (APK and IPA) through automated CI workflows.

## Requirements

To build the application locally you need the following tools:

- [Flutter](https://flutter.dev) (stable channel, 3.22 or newer)
- Dart SDK bundled with Flutter
- Android SDK with build tools r33 or newer and an emulator or device for testing
- Xcode 15+ on macOS with the iOS deployment tooling if you intend to archive an IPA
- CocoaPods for managing iOS dependencies (`gem install cocoapods`)

Install project dependencies with:

```bash
flutter pub get
```

## Building Locally

### Android (APK)

```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### iOS (IPA)

> **Note:** Building an IPA requires macOS and Xcode. Codesigning is disabled in the default configuration to simplify continuous integration builds.

```bash
cd ios
pod install
cd ..
flutter build ipa --release --export-options-plist=ios/ExportOptions.plist --no-codesign
# Output: build/ios/ipa/Runner.ipa
```

## Automated Builds

The repository includes a GitHub Actions workflow in `.github/workflows/build-mobile-artifacts.yml` that produces both the Android APK and iOS IPA whenever code is pushed to the `main` branch or when triggered manually.

Each job performs the following high-level steps:

1. Checks out the repository.
2. Installs Flutter on the requested platform.
3. Resolves Dart and Flutter package dependencies.
4. Builds a release artifact (`app-release.apk` or `Runner.ipa`).
5. Uploads the resulting file as a workflow artifact you can download from the GitHub Actions run summary page.

This approach keeps large binary files out of the Git history while still providing easily accessible release bundles.

To store locally built artifacts in a clean directory, run the helper script after executing the build commands:

```bash
./scripts/collect_artifacts.sh
ls artifacts
```

The script copies any generated APK or IPA into the `artifacts/` directory (which is ignored by Git by default) so you can distribute them without polluting the repository history.

## Versioning

The application version is defined in `pubspec.yaml`. Update the semantic version and build number together (e.g., `x.y.z+build`) whenever you prepare a new release so that the CI workflow generates artifacts with consistent versioning metadata.
