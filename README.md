# Scrabble Scoring App Development Milestones

## Frontend Development

- [x] Implement navigation between screens (scorekeeping, settings, main menu).
- [ ] Ensure responsive and consistent design across devices and orientations.

## Backend Development -

- [ ] User registration and authentication
- [ ] Track user purchase history/subscription status

## Game Logic Integration

- [x] Implement core Scrabble rules for word formation, scoring, and tile placement.
- [x] Ensure accurate scoring based on tile values and special tile multipliers.

## Local Gameplay Feature

- [ ] Enable users to save and load game sessions.

## Testing and Quality Assurance

- [ ] Conduct thorough testing of app's functionality, including gameplay and Firebase integration.
- [ ] Address and fix bugs or usability issues identified during testing.
- [ ] Optimize app performance and user experience.

## Deployment on App Stores

- [ ] Prepare the app for deployment on Apple App Store and Google Play Store.
- [ ] Create app store listings with descriptions, screenshots, and graphics.
- [ ] Submit the app for review and approval on both platforms.

## Post-launch Support and Updates

- [ ] Monitor user feedback and app reviews for issues and suggestions.
- [ ] Maintain compatibility with latest iOS and Android versions.

## Monetization Strategy

- [ ] Determine app monetization strategy (e.g., one-time purchase, in-app purchases, ads).
- [ ] Implement chosen monetization method within the app.
- [ ] Monitor revenue generation and adjust strategies as needed.

## Marketing and Promotion

- [ ] Develop a marketing plan to increase app visibility and downloads.
- [ ] Use social media, ASO, and advertising to promote the app.
- [ ] Engage with the Scrabble community to gain initial traction.

## User Support and Community Engagement

- [ ] Provide user support for inquiries and issues.
- [ ] Foster an engaged user community through forums, social media, or in-app chat.
- [ ] Gather feedback for future improvements and updates.

## Analytics and Performance Evaluation

- [ ] Implement analytics tools to track user engagement, retention, and in-app behavior.
- [ ] Analyze data to make data-driven decisions for app improvements.

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
  - `repositories` provides an abstraction for data access, and can combine data from multiple sources if necessary.
  - Example: `user_model.dart` defines the user entity, and `user_repository.dart` handles data operations related to the user.

- `presentation` contains the UI components and screens.
  - `screens` contains the different screens of the app.
  - `widgets` contains reusable UI components.
  - Example: `login_screen.dart` defines the login screen UI, and `login_form.dart` is a reusable form widget used within the login screen.
