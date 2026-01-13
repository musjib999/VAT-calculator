# VAT Calculator

A modern, feature-rich VAT (Value Added Tax) calculator Flutter application built with Clean Architecture principles. This app allows users to add multiple items with their prices, calculate VAT on the total amount, and view detailed breakdowns of the calculation.

## 📱 Features

### Core Functionality
- **Multi-Item Support**: Add multiple items with custom names and prices
- **Real-time Calculations**: Automatic subtotal calculation as items are added or modified
- **Flexible VAT Rate**: Set custom VAT rates (0% - 30%) using slider or quick-select buttons
- **Quick Select Rates**: Predefined VAT rates (5%, 7.5%, 10%, 15%, 20%) for quick selection
- **Detailed Breakdown**: View comprehensive calculation results including:
  - Items breakdown with individual prices
  - Original amount (subtotal)
  - VAT amount with percentage
  - Total amount including VAT

### User Experience
- **Modern UI**: Clean, intuitive interface with purple-themed design
- **Smooth Animations**: Fade and slide animations for better user experience
- **Currency Formatting**: Automatic formatting with Nigerian Naira (₦) symbol and thousand separators
- **Input Validation**: Real-time validation and formatting for numeric inputs
- **Responsive Design**: Optimized for various screen sizes

## 🏗️ Architecture

This project follows **Clean Architecture** principles with a clear separation of concerns:

### Architecture Layers

```
lib/
├── core/                    # Core utilities and shared infrastructure
│   ├── gen/                 # Generated files
│   └── utils/               # Utility classes (formatters, locator, etc.)
│
├── features/                # Feature modules
│   └── calculator/          # VAT Calculator feature
│       ├── data/            # Data layer
│       │   ├── models/      # Data models
│       │   └── repositories/ # Repository implementations
│       ├── domain/          # Domain layer (business logic)
│       │   ├── entities/   # Business entities
│       │   ├── repositories/ # Repository interfaces
│       │   └── usecases/    # Use cases
│       └── presentation/    # Presentation layer
│           ├── bloc/        # BLoC state management
│           └── view/        # UI components
│               ├── screens/ # Screen widgets
│               └── widgets/ # Reusable widgets
│
└── shared/                  # Shared components across features
    ├── components/          # Reusable UI components
    └── themes/              # App themes and styling
```

### State Management

The app uses **BLoC (Business Logic Component)** pattern for state management:
- **Events**: User actions (AddItem, RemoveItem, CalculateVat, etc.)
- **States**: UI states (CalculatorLoaded, CalculatorInitial, etc.)
- **BLoC**: Business logic handler that processes events and emits states

### Dependency Injection

Uses **GetIt** for dependency injection, ensuring loose coupling and testability.

## 📦 Project Structure

### Domain Layer
- **Entities**: `VatItem`, `VatCalculation` - Core business objects
- **Repositories**: `CalculatorRepository` - Abstract repository interface
- **Use Cases**: `CalculateVatUseCase` - Business logic operations

### Data Layer
- **Models**: `VatCalculationModel` - Data transfer objects extending entities
- **Repositories**: `CalculatorRepositoryImpl` - Concrete repository implementation

### Presentation Layer
- **BLoC**: `CalculatorBloc` - State management
- **Screens**: 
  - `CalculatorScreen` - Main input screen
  - `ResultScreen` - Results display screen
- **Widgets**: Reusable UI components (VatHeader, VatSlider, VatItemRow, etc.)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.10.4 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- iOS Simulator / Android Emulator (for testing)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd vat_calculator
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## 💻 Usage

### Adding Items

1. Tap the **"Add Item"** button
2. Enter the item name in the text field
3. Enter the price (with automatic thousand separator formatting)
4. The subtotal updates automatically

### Calculating VAT

1. Add one or more items with prices
2. Set the VAT rate using:
   - The slider (0% - 30%)
   - Quick-select buttons (5%, 7.5%, 10%, 15%, 20%)
   - Manual input in the VAT rate field
3. Tap **"Calculate VAT"** button
4. View the detailed breakdown on the results screen

### Viewing Results

The results screen displays:
- **Circular Progress**: Visual representation of VAT percentage
- **Items Breakdown**: List of all items with their prices
- **Original Amount**: Subtotal of all items
- **VAT Amount**: Calculated VAT with percentage
- **Total Amount**: Final amount including VAT

## 🛠️ Dependencies

### Core Dependencies
- `flutter_bloc: ^9.1.1` - State management
- `equatable: ^2.0.8` - Value equality for states and events
- `get_it: ^9.2.0` - Dependency injection
- `intl: ^0.20.2` - Internationalization and formatting

### UI Dependencies
- `google_fonts: ^7.0.0` - Custom fonts
- `flutter_svg: ^2.2.3` - SVG support

### Development Dependencies
- `flutter_lints: ^6.0.0` - Linting rules
- `build_runner: ^2.10.4` - Code generation

## 🎨 Design

### Color Scheme
- **Primary Color**: `#9333EA` (Purple)
- **Background**: `#FAF5FF` (Light Purple)
- **Card Background**: `#FFFFFF` (White)
- **Accent**: `#F3E8FF` (Light Purple)

### Typography
- Uses Google Fonts for consistent typography
- Responsive font sizes for different screen sizes

## 📝 Code Style

- Follows Flutter/Dart style guidelines
- Uses `flutter_lints` for code quality
- Clean Architecture principles
- SOLID principles
- Separation of concerns

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📄 License

This project is private and not intended for public distribution.

## 👨‍💻 Development

### Key Components

#### CalculatorBloc
Manages all calculator state and business logic:
- Item management (add, remove, update)
- VAT rate handling
- Calculation logic
- Text controller synchronization

#### VatItemRow Widget
Reusable widget for displaying and editing items:
- Item name input
- Price input with formatting
- Remove button

#### Formatters
Utility class for currency formatting:
- `formatCurrency()`: Formats numbers with ₦ symbol and commas
- `parseFormattedNumber()`: Parses formatted strings back to numbers

## 🔄 Future Enhancements

Potential features for future versions:
- Save calculation history
- Export results to PDF
- Multiple currency support
- Dark mode
- Calculation templates
- Share functionality

## 📞 Support

For issues, questions, or contributions, please contact the development team.

---

**Built with ❤️ using Flutter**
