// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return windows;
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
    apiKey: 'AIzaSyAG8-aE_NwR32kMjogotfKNWmQ2KdsGSgM',
    appId: '1:38061200910:web:8328dd0ce48cc707aa0e5f',
    messagingSenderId: '38061200910',
    projectId: 'football-system-0',
    authDomain: 'football-system-0.firebaseapp.com',
    storageBucket: 'football-system-0.firebasestorage.app',
    measurementId: 'G-48KFY7CCY7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQExP0kJOUJmZygErivABp1HYIO_yzD44',
    appId: '1:38061200910:android:040a1c11e7eafd2baa0e5f',
    messagingSenderId: '38061200910',
    projectId: 'football-system-0',
    storageBucket: 'football-system-0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3RxYxR1spqSrGYbNo7CPJQS_FtOEB0Ws',
    appId: '1:38061200910:ios:f4b11aee70e568d3aa0e5f',
    messagingSenderId: '38061200910',
    projectId: 'football-system-0',
    storageBucket: 'football-system-0.firebasestorage.app',
    iosBundleId: 'com.example.footballSystem',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD3RxYxR1spqSrGYbNo7CPJQS_FtOEB0Ws',
    appId: '1:38061200910:ios:f4b11aee70e568d3aa0e5f',
    messagingSenderId: '38061200910',
    projectId: 'football-system-0',
    storageBucket: 'football-system-0.firebasestorage.app',
    iosBundleId: 'com.example.footballSystem',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAG8-aE_NwR32kMjogotfKNWmQ2KdsGSgM',
    appId: '1:38061200910:web:39728106055adddaaa0e5f',
    messagingSenderId: '38061200910',
    projectId: 'football-system-0',
    authDomain: 'football-system-0.firebaseapp.com',
    storageBucket: 'football-system-0.firebasestorage.app',
    measurementId: 'G-BQ0L39SLC0',
  );
}
