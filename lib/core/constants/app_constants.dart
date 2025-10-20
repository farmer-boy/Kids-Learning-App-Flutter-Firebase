class AppConstants {
  // App Info
  static const String appName = "Kids Learning App";
  static const String appVersion = "1.0.0";

  // Storage Keys
  static const String userKey = "user_data";
  static const String settingsKey = "app_settings";
  static const String childProfileKey = "child_profile";

  // Firebase Collections
  static const String usersCollection = "users";
  static const String childrenCollection = "children";
  static const String progressCollection = "progress";
  static const String contentCollection = "learning_content";

  // Asset Paths
  static const String lottiePath = "assets/animations/lottie";
  static const String rivePath = "assets/animations/rive";
  static const String imagesPath = "assets/images";
  static const String iconsPath = "assets/icons";
  static const String soundsPath = "assets/sounds";

  // Routes
  static const String initialRoute = "/";
  static const String loginRoute = "/login";
  static const String signupRoute = "/signup";
  static const String homeRoute = "/home";
  static const String profileRoute = "/profile";
  static const String settingsRoute = "/settings";

  // Timeouts
  static const int apiTimeout = 30; // seconds
  static const int cacheDuration = 7; // days

  // Limits
  static const int maxChildProfiles = 4;
  static const int maxDailyPlayTime = 120; // minutes
  static const int minChildAge = 3;
  static const int maxChildAge = 10;

  // Animation Durations
  static const int shortAnimationDuration = 200; // milliseconds
  static const int mediumAnimationDuration = 350; // milliseconds
  static const int longAnimationDuration = 500; // milliseconds
}
