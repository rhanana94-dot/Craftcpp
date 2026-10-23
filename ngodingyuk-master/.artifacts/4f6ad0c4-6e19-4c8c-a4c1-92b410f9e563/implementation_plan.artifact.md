# Implementation Plan - NgodingYuk++ C++ Learning App

Building a Flutter-based learning application for C++ with Firebase integration, structured lessons, and a coding environment.

## User Review Required

> [!IMPORTANT]
> **Firebase Setup**: I will prepare the code for Firebase integration, but you will need to provide the `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files by following the Firebase Console setup.
> **Coding Space Backend**: For executing C++ code, we need a backend or an API (e.g., Judge0). I will implement the UI for the Coding Space, but we should decide on the execution method.
> **Assets**: You will need to provide the logo animation (Lottie or GIF) and video links (YouTube or hosted MP4).

## Proposed Changes

### 1. Project Infrastructure & Dependencies
- Update `pubspec.yaml` with necessary packages (`firebase_core`, `firebase_auth`, `cloud_firestore`, `provider`, `google_fonts`, `flutter_svg`, `lottie`, `youtube_player_flutter`).
- Set up folder structure: `core`, `features`, `models`, `providers`, `widgets`.

---

### 2. Authentication Feature
- **Splash Screen**: Logo animation with a transition to Login.
- **Login Screen**: Options for Login, Sign Up, and "Akun Demo".
- **Firebase Auth Implementation**: Wiring up the authentication logic.

---

### 3. Main Navigation & Home
- **Bottom Navigation Bar**: Implementing Home, Materi, Coding Space, and Dashboard tabs.
- **Home Screen**: Overview of learning progress and quick actions.

---

### 4. Materi (Curriculum) System
- **Materi List**: 8 chapters of C++ basics.
- **Chapter Details**:
    - Material viewer (Text/Markdown).
    - Video player (YouTube integration).
    - **Tasks**: 5 Multiple Choice Questions and 1 Practice Problem per chapter.
- **Task Evaluation**: Logic to check MCQ answers and practice output matching.

---

### 5. Coding Space & AI Tutor
- **Code Editor**: A text field with syntax highlighting for C++.
- **Execution**: Logic to send code to an execution engine and display results.
- **AI Tutor Interface**: A chat-like interface for students to ask questions about their code.

---

### 6. Dashboard & Progress Tracking
- **Stats**: Total material completed, quiz scores, and overall progress.
- **Pre-Test & Sumatif**: Initial assessment and final project-based evaluation.

## Verification Plan

### Automated Tests
- Unit tests for Auth logic and Task evaluation.
- Widget tests for Navigation and Mater list.

### Manual Verification
- Verify Firebase login/registration.
- Test video playback in Chapter Details.
- Verify that MCQ results are correctly calculated and stored.
- Test the Coding Space UI layout and basic code entry.
