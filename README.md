# Apply At Supono

A Flutter application that provides photo capture and preview functionality with integrated ads.

> You can find this application release build in my [Google Drive here](https://drive.google.com/drive/folders/1h0U8uXWElF_ccm7tGbfbyMWf21ZqKL-G?usp=drive_link)

## Features

- Camera integration for photo capture
- Photo preview with editing capabilities
- Onboarding flow for first-time users
- Settings management
- Google AdMob integration
- Support for both iOS and Android platforms

## Technical Details

### Platform Support
- iOS (12.0+)
- Android (API 28+)

### Key Dependencies
- Flutter SDK (^3.6.0)
- Camera plugins for photo capture
- Google Mobile Ads SDK
- Other Flutter dependencies (check pubspec.yaml for complete list)

## Optimizations

### Memory Usage
- Implemented image compression before storage
- Proper disposal of controllers and streams
- Memory leak prevention in camera handling
- Cached network images for better memory management

### CPU Usage
- Optimized image processing operations
- Reduced unnecessary rebuilds using const constructors
- Implemented efficient state management
- Background operations handled appropriately

### Battery Usage
- Optimized camera usage
- Efficient location services implementation
- Reduced network calls
- Background processes optimization

### Network Usage
- Implemented image caching
- Optimized API calls
- Compressed network payloads
- Efficient ad loading strategies

### App Size
- Implemented app bundle
- Removed unused resources
- Optimized image assets
- ProGuard rules for Android

## App Size Optimization

### Implemented Optimizations
- ProGuard enabled for Android
- R8 full mode enabled
- Resource shrinking
- Image compression
- Dead code elimination
- Tree shaking
- Font optimization

### Build Commands
For minimal release builds:

```bash
# Android
flutter build apk --release --target-platform android-arm64
flutter build appbundle --target-platform android-arm64

# iOS
flutter build ios --release
```

### Asset Optimization
Run the asset optimization script before building:
```bash
dart run scripts/optimize_assets.dart
```

## Recent Improvements

### UI/UX
- Responsive design for various iPhone models (13 mini to 16 Pro Max)
- Improved input validation for date fields
- Enhanced tab indexing in birthday page
- Better error handling and user feedback

### Platform-Specific Optimizations
#### iOS
- Memory management improvements
- Camera permission handling
- Photo library integration
- AdMob implementation

#### Android
- Background processing optimization
- Permission handling
- Camera API implementation
- Resource management

## Development Guidelines

### Input Validation
- Implemented robust date validation
- Added real-time validation feedback
- Enhanced field formatting
- Improved error messages

### Error Handling
- Comprehensive error catching
- User-friendly error messages
- Graceful fallbacks
- Logging for debugging

## Bug-Free Applications: A Perspective

Creating a completely bug-free app is an aspirational goal rather than a practical reality. Here's what would be needed to get as close as possible:

### Requirements for Minimal Bugs
1. Comprehensive testing strategy
   - Unit tests
   - Integration tests
   - UI tests
   - Performance tests
   - Security tests

2. Development practices
   - Code reviews
   - Static code analysis
   - Continuous Integration/Deployment
   - Automated testing

3. Quality Assurance
   - Manual testing
   - Beta testing
   - User feedback loops
   - Performance monitoring

4. Infrastructure
   - Reliable hosting
   - Scalable architecture
   - Monitoring tools
   - Backup systems

### Why "Bug-Free" is Theoretical
1. Complex interactions
   - Multiple device types
   - Various OS versions
   - Different user scenarios
   - Network conditions

2. External dependencies
   - Third-party libraries
   - API changes
   - Platform updates
   - Hardware variations

3. Human factors
   - User behavior variations
   - Edge cases
   - Unexpected usage patterns

4. Resource constraints
   - Development time
   - Testing coverage
   - Budget limitations

## Getting Started

1. **Prerequisites**
   - Flutter SDK installed
   - iOS development tools (for iOS development)
   - Android Studio (for Android development)
   - Valid Google AdMob account and app IDs

2. **Setup**
   ```bash
   # Clone the repository
   git clone [repository-url]

   # Install dependencies
   flutter pub get

   # Run the app
   flutter run
   ```

## Development

### iOS Configuration
- Minimum iOS version: 12.0
- Required permissions:
  - Camera access
  - Photo library access
- AdMob ID configured in Info.plist

### Android Configuration
- Required permissions:
  - Camera
  - Internet
- AdMob ID configured in AndroidManifest.xml

