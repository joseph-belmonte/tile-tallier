# Notes on App Architecture

- The code is organized by features. Each feature has the following folders: `application`, `data`, `domain`, and `presentation`.

- `application` contains the use cases and business logic.

  - This layer handles state management and acts as a bridge between the `domain` layer and the `presentation` layer.
  - `providers` folder contains the providers that manage the state of the app.
  - Example: `auth_provider.dart` manages the state of user authentication.

- `data` contains the actual implementations of interacting with external data sources.

  - `sources` contains the data sources like APIs, databases, or shared preferences. Each file here may be a type of "service" that interacts with a specific data source.
  - Implements the actual data fetching logic, whether from remote APIs, local databases, or other data sources.
  - Example: `api_service.dart` handles HTTP requests to the authentication API.

- `domain` defines the core business entities.

  - `models` contains the data models used in the app.
  - `repositories` provides an abstraction for data access, and can combine data from multiple sources if necessary. The repository pattern is used to abstract the data access logic from the business logic. It acts as an intermediary between your application and your data sources (like databases, APIs, etc.).
  - Example: `user_model.dart` defines the user entity, and `user_repository.dart` handles data operations related to the user.

- `presentation` contains the UI components and screens.
  - `screens` contains the different screens of the app.
  - `widgets` contains reusable UI components.
  - Example: `login_screen.dart` defines the login screen UI, and `login_form.dart` is a reusable form widget used within the login screen.
