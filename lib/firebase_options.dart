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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyABRV603QCiukj5wUnRv_4PElqLSBE5sqY',
    appId: '1:35573378129:web:e695702573286b2a4c5c70',
    messagingSenderId: '35573378129',
    projectId: 'note-auth-d87ab',
    authDomain: 'note-auth-d87ab.firebaseapp.com',
    storageBucket: 'note-auth-d87ab.firebasestorage.app',
    measurementId: 'G-ZL4DYGBD4C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1gxQGVPH4nx7s6NnDFcAzTGSyeDX6p3c',
    appId: '1:35573378129:android:c6bbafb3c6d5024a4c5c70',
    messagingSenderId: '35573378129',
    projectId: 'note-auth-d87ab',
    storageBucket: 'note-auth-d87ab.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6BBPIdnZpQCmS3ysDeUMGiwOOPL7gGBk',
    appId: '1:35573378129:ios:d4b79732b7a1aaba4c5c70',
    messagingSenderId: '35573378129',
    projectId: 'note-auth-d87ab',
    storageBucket: 'note-auth-d87ab.firebasestorage.app',
    iosBundleId: 'com.example.noteAuth',
  );
}
