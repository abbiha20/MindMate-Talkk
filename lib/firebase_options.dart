// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDhZP62Y20JyN3JxF0G4FfRF0u6VpSzlY4',
    appId: '1:94766163166:web:d04e38e920657863d04e4f',
    messagingSenderId: '94766163166',
    projectId: 'mindmate-talk',
    authDomain: 'mindmate-talk.firebaseapp.com',
    storageBucket: 'mindmate-talk.appspot.com',
    measurementId: 'G-VFGRMSNF8R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAznxgrEuhmceoc4oXkoWZ1NXUxLixh2kg',
    appId: '1:94766163166:android:93fe55e9dd93925bd04e4f',
    messagingSenderId: '94766163166',
    projectId: 'mindmate-talk',
    storageBucket: 'mindmate-talk.appspot.com',
  );
}
