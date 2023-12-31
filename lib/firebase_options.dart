// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCGbX6b1nY5qOKm_hVZ4yyxPVE2025t_Ik',
    appId: '1:124907914845:web:647452decaabee63312fb4',
    messagingSenderId: '124907914845',
    projectId: 'flutter-news-app-47c3e',
    authDomain: 'flutter-news-app-47c3e.firebaseapp.com',
    storageBucket: 'flutter-news-app-47c3e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCz7g-70gdG0vhtU2teTPTA2cEuqrlcxUc',
    appId: '1:124907914845:android:e26e9c9b284ccaac312fb4',
    messagingSenderId: '124907914845',
    projectId: 'flutter-news-app-47c3e',
    storageBucket: 'flutter-news-app-47c3e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBa72iLRuz7SLuT5zTlIznVmtBBYyxxfd4',
    appId: '1:124907914845:ios:b55128b5decb0be8312fb4',
    messagingSenderId: '124907914845',
    projectId: 'flutter-news-app-47c3e',
    storageBucket: 'flutter-news-app-47c3e.appspot.com',
    iosBundleId: 'com.yigittilki.flutternewsapp.flutterNewsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBa72iLRuz7SLuT5zTlIznVmtBBYyxxfd4',
    appId: '1:124907914845:ios:893ae49682426a35312fb4',
    messagingSenderId: '124907914845',
    projectId: 'flutter-news-app-47c3e',
    storageBucket: 'flutter-news-app-47c3e.appspot.com',
    iosBundleId: 'com.yigittilki.flutternewsapp.flutterNewsApp.RunnerTests',
  );
}
