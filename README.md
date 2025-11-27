# Hantera - HRIS Application

Hantera is a comprehensive SaaS (Software as a Service) Human Resource Information System (HRIS) application built with Flutter. The app provides a modern, intuitive interface for managing human resources, employee records, and organizational workflows.

## 🚀 Features

### Core Functionality
- **Employee Management**: Complete employee profile management
- **Attendance Tracking**: Record and monitor employee attendance
- **Leave Management**: Request and approve leave applications
- **Performance Tracking**: Monitor employee performance metrics
- **Notification System**: Real-time notifications for important updates
- **User Authentication**: Secure login and onboarding flow

### Technical Features
- **Offline Support**: Local database using Hive for offline functionality
- **Dark/Light Theme**: Adaptive UI with theme switching
- **Responsive Design**: Mobile-first responsive layout
- **State Management**: BLoC pattern for predictable state management
- **Dependency Injection**: GetIt for efficient dependency management
- **Internationalization**: Built-in support for multiple languages

## 📱 Architecture

The application follows a clean architecture pattern with three main layers:

### 1. Data Layer
- **Data Sources**: Local (Hive) and remote data sources
- **Repositories**: Abstract data access layer
- **Models**: Data transformation objects

### 2. Domain Layer
- **Entities**: Core business objects
- **Repositories**: Repository interfaces
- **Use Cases**: Business logic implementation

### 3. Presentation Layer
- **Pages**: Main application screens
- **Widgets**: Reusable UI components
- **Services**: Route and theme management

## 🛠️ Tech Stack

### Core Dependencies
- **Flutter**: UI framework
- **Dart**: Programming language
- **Hive**: Local database for offline storage
- **Flutter BLoC**: State management
- **GetIt**: Dependency injection
- **Provider**: State management
- **Shared Preferences**: Local storage for settings

### UI & Design
- **Material Design**: Google's design system
- **Poppins Font**: Modern typography
- **Flutter SVG**: Vector graphics support
- **Staggered Grid**: Advanced layout components

### Additional Features
- **Camera Integration**: Document scanning
- **Location Services**: Geolocation support
- **Image Processing**: Image manipulation capabilities
- **Text-to-Speech**: Voice output support

## 📦 Installation

### Prerequisites
- Flutter SDK (>=3.4.3)
- Dart SDK
- Android Studio / VS Code
- Xcode (for iOS development)

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd hris_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### Android
- Ensure Android SDK is properly configured
- Check `android/local.properties` for correct SDK path

#### iOS
- Install Xcode from App Store
- Run `cd ios && pod install` to install CocoaPods

## 🎨 Project Structure

```
lib/
├── data/                 # Data layer
│   ├── core/            # Core data models
│   ├── datasource/      # Data sources (local/remote)
│   └── repositories/    # Repository implementations
├── domain/              # Domain layer
│   └── repositories/    # Repository interfaces
├── presentation/        # Presentation layer
│   ├── core/           # Core UI components
│   │   ├── constant/    # Constants and configurations
│   │   ├── extension/   # Extensions
│   │   ├── handler/     # Event handlers
│   │   ├── helper/      # Helper functions
│   │   ├── model/       # UI models
│   │   ├── service/     # UI services
│   │   └── widget/      # Reusable widgets
│   └── pages/          # Application screens
│       ├── auth/       # Authentication screens
│       ├── home.dart   # Main home screen
│       ├── home_tab.dart # Home tab
│       ├── notification_tab.dart # Notifications
│       ├── onboarding/  # Onboarding flow
│       ├── profile_tab.dart # Profile
│       ├── record_page.dart # Records
│       ├── setting/     # Settings
│       └── timeline/    # Timeline
├── injector.dart        # Dependency injection setup
└── main.dart           # App entry point
```

## 🚀 Getting Started

### First Run
1. Run `flutter pub get` to install dependencies
2. Run `flutter run` to start the application
3. Complete the onboarding flow
4. Navigate through the different sections to explore features

### Development Workflow
1. Make changes to the code
2. Use `flutter run` to test changes
3. Use `flutter test` to run unit tests
4. Use `flutter analyze` to check for issues

## 📄 Configuration

### Environment Setup
- The app supports both development and production environments
- Configuration is managed through environment variables
- Local storage settings are managed through Hive

### Theme Configuration
- Light and dark themes are supported
- Custom color schemes can be configured in the theme service
- Font customization through Poppins font family

## 🔧 Development

### Building for Production
```bash
flutter build apk --release
flutter build ios --release
```

### Code Generation
```bash
flutter pub run build_runner build
```

### Testing
```bash
flutter test
```

## 📄 License

This project is private and not intended for public distribution.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📞 Support

For support and questions, please contact the development team.

---

This README provides a comprehensive overview of the Hantera HRIS application, its architecture, and development setup. For more detailed information about specific features or components, please refer to the code documentation and comments within the project.
