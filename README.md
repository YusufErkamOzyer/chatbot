# Chatbot Application

This project is a Flutter-based mobile application that interacts with a chatbot API. It allows users to have text-based conversations with the chatbot.

## Features

- User-friendly chat interface.
- Integration with an external chatbot API.
- Firebase initialization and potential additional services (e.g., authentication, database).

## Setup

Follow these steps to set up and run the project locally:

1.  **Flutter SDK Installation:**

    If you don't have the Flutter SDK installed, follow the installation guide on the [official Flutter website](https://flutter.dev/docs/get-started/install) for your operating system.

2.  **Clone the Repository:**

    ```bash
    git clone https://github.com/YusufErkamOzyer/chatbot.git
    cd chatbot
    ```

3.  **Install Dependencies:**

    Run the following command to install project dependencies:

    ```bash
    flutter pub get
    ```

4.  **Firebase Setup:**

    This application uses Firebase. You may need to create your own Firebase project and add the `firebase_options.dart` file to your project. For detailed information, refer to the [Firebase Flutter documentation](https://firebase.google.com/docs/flutter/setup).

5.  **API Connection:**

    To enable the application to connect to the `chatbot_api` service, you may need to configure the API URL. This is typically done in the application's code or a configuration file. Look into the relevant files in the `lib` folder to find where the API URL is defined and update it with the URL of your deployed API.

## Usage

Ensure an emulator or a physical device is connected, then run the following command to launch the application:

```bash
flutter run
```

## File Structure

-   `lib/`: Contains the Dart source code for the application.
    -   `lib/main.dart`: The entry point of the application.
    -   `lib/app/screens/chat_screen.dart`: The main screen containing the chat interface.
-   `android/`: Android platform-specific files.
-   `ios/`: iOS platform-specific files.
-   `assets/`: Application assets (images, fonts, etc.).
-   `pubspec.yaml`: Project dependencies and metadata.
-   `firebase.json`: Firebase configuration file.
-   `firebase_options.dart`: Firebase initialization options.


