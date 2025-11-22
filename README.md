# BrainBox AI Chat

A modern, intelligent chat application built with Flutter and powered by Google's Gemini AI. BrainBox offers a seamless and secure chat experience with advanced features like real-time AI responses, markdown support, and cloud-synced chat history.

## 🚀 Features

-   **🤖 AI-Powered Chat**: Interact with Google's Gemini Pro model for intelligent and context-aware responses.
-   **🔐 Secure Authentication**:
    -   Email & Password Sign-up/Login.
    -   Google Sign-In integration.
    -   Password Reset functionality.
-   **☁️ Cloud Sync**: All chat history is securely stored in Firebase Firestore.
-   **📝 Rich Text Support**: Full Markdown rendering with syntax highlighting for code blocks.
-   **🎨 Modern UI/UX**:
    -   Sleek, chat-bubble interface.
    -   "Bot is typing..." animations.
    -   Smooth message entry animations.
    -   Dark/Light theme support (system adaptive).
-   **📂 Chat Management**:
    -   Sidebar drawer for chat history.
    -   Auto-generated chat titles based on context.
    -   Rename and delete chat sessions.

## 🛠️ Tech Stack

-   **Framework**: [Flutter](https://flutter.dev/)
-   **Language**: [Dart](https://dart.dev/)
-   **State Management**: [Flutter Riverpod](https://riverpod.dev/)
-   **Architecture**: Clean Architecture (Domain, Data, Presentation layers)
-   **Backend**: [Firebase](https://firebase.google.com/) (Auth, Firestore)
-   **AI Model**: [Google Generative AI SDK](https://pub.dev/packages/google_generative_ai)
-   **Functional Programming**: [fpdart](https://pub.dev/packages/fpdart) for robust error handling (`Either` types).

## 📂 Project Structure

The project follows strict **Clean Architecture** principles:

```
lib/
├── core/               # Core utilities, errors, and shared widgets
├── feature/
│   ├── auth/           # Authentication feature (Domain, Data, Presentation)
│   └── chat/           # Chat feature (Domain, Data, Presentation)
└── main.dart           # Entry point
```

## 🏁 Getting Started

### Prerequisites

-   [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
-   A [Firebase Project](https://console.firebase.google.com/) set up.
-   A [Google Gemini API Key](https://ai.google.dev/).

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/brainbox-ai-chat.git
    cd brainbox-ai-chat
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Firebase Setup**:
    -   Download `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) from your Firebase Console.
    -   Place them in `android/app/` and `ios/Runner/` respectively.

4.  **Environment Configuration**:
    -   Ensure you have your Gemini API Key ready.
    -   Update `lib/core/constants/api_constants.dart` (or your environment config) with your key.

5.  **Run the App**:
    ```bash
    flutter run
    ```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
