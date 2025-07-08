# Klontong App

A modern Flutter e-commerce demo app with clean architecture, SOLID principles, and modular codebase.

## Features

- **Splash Screen**
  - Custom splash screen with Tokopedia green background and logo.

- **Product List**
  - Grid view of products with pagination (loads 10 products per page).
  - Pull-to-refresh support.
  - Search bar to filter products by name.
  - Product images use `cached_network_image` with local placeholder.

- **Product Detail**
  - Large product image, name, description, price, weight, and category chip.
  - "Add to Cart" and "Buy" buttons in a custom bottom navigation bar.

- **Add Product**
  - Form to add new product with fields: name, price, image URL, description, weight, SKU, and category (dropdown: Cemilan, Minuman, Sembako).
  - Category dropdown is mapped to categoryId.

- **Cart**
  - List of products added to cart (stored in local database using sqflite).
  - Select all/individual products with checkbox.
  - "Buy" button to proceed to payment for selected products.
  - Pull-to-refresh support.

- **Payment**
  - Payment page shows selected products and total price.
  - "Pay Now" button shows loading dialog, then payment image, then returns to home and clears purchased items from cart.

- **Theming**
  - Tokopedia green as primary color, Google Fonts Poppins for all text.
  - Custom launcher icon and splash logo.

- **Routing**
  - Uses `go_router` for navigation.

- **Dependency Injection**
  - Uses `get_it` for modular and testable DI.

- **State Management**
  - Uses `flutter_bloc` for all business logic and UI state.

- **API & Env Management**
  - Uses `dio` for HTTP requests.
  - Base API endpoint managed via `.env` file using `flutter_dotenv`.
  - Only the endpoint ID is in `.env`, path `/product` is hardcoded.

- **Local Database**
  - Uses `sqflite` for cart persistence.

- **Testing**
  - Unit tests for usecase and bloc (TDD).
  - Mocks generated with `mockito` and `build_runner`.
  - Bloc tests cover fetch, add, delete, and pagination.

- **SOLID Principles**
  - All code is modular, testable, and follows Single Responsibility, Open/Closed, Liskov, Interface Segregation, and Dependency Inversion principles.

## Getting Started

1. **Clone the repository**

2. **Install dependencies**
   ```
   flutter pub get
   ```

3. **Set up environment**
   - Edit `.env` file in project root:
     ```
     BASE_ID=your_crudcrud_id
     ```
   - The app will use `https://crudcrud.com/api/$BASE_ID/product` as the product endpoint.

4. **Generate launcher icons**
   ```
   flutter pub run flutter_launcher_icons:main
   ```

5. **Run the app**
   ```
   flutter run
   ```

6. **Run tests**
   ```
   flutter test
   ```

## Main Dependencies

- flutter_bloc
- get_it
- go_router
- dio
- sqflite
- cached_network_image
- google_fonts
- flutter_dotenv
- mockito, bloc_test, build_runner (for testing)
- flutter_launcher_icons

## Folder Structure

- `lib/domain/` - Entities, repositories, usecases (abstractions)
- `lib/data/` - Data sources, models, repository implementations
- `lib/presentation/` - Blocs, pages, widgets
- `lib/core/` - Theme, router
- `lib/injection/` - Dependency injection setup
- `assets/img/` - Images, icons, splash, placeholders
- `test/` - Unit and bloc tests

## Notes

- The app is modular and easy to maintain/extend.
- All business logic is separated from UI.
- All API endpoints and keys are managed via `.env`.
- App icon and splash screen are fully custom.

---

**Enjoy using Klontong App!**
