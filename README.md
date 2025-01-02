# MyGoals App - Flutter Frontend

This is the frontend part of a productivity app that allows users to create and manage their goals using customizable templates. This Flutter application works in conjunction with the [backend Spring application](https://github.com/AchilleGrieco/mygoalsapp).

## Built With
- Flutter
- flutter_bloc for state management
- flutter_secure_storage for secure credential storage
- flutter_dotenv for environment configuration

## Features
- User authentication with JWT tokens
- Create and manage goal templates
- Convert templates into active goals
- Secure credential storage

## Getting Started

### Prerequisites
- Flutter SDK
- An IDE (VS Code, Android Studio, etc.)
- The backend server running ([see backend repository](https://github.com/AchilleGrieco/mygoalsapp))

### Installation

1. Clone the repository
```bash
git clone [https://github.com/AchilleGrieco/mygoalsapp-front-end.git]
```

2. Install dependencies
```bash
flutter pub get
```

3. Create a `.env` file in the root directory with the following content:
```
API_URL=your_backend_url
```

4. Run the app
```bash
flutter run
```

## What I Learned
- Implementation of JWT authentication in Flutter
- Modern state management using flutter_bloc
- Secure storage of sensitive data
- API integration between Flutter frontend and Spring backend
- Building a responsive and user-friendly mobile interface

## Contributing
Feel free to fork the project and submit pull requests.

## Related
- [Backend Repository](https://github.com/AchilleGrieco/mygoalsapp) - The Spring backend for this application
