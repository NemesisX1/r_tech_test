// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_dev.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDN4EABm74DVxgLtH9nnjuRL3wDYjzFPEQ',
    appId: '1:1065840664684:android:7fe8a1b7c1394467507849',
    messagingSenderId: '1065840664684',
    projectId: 'repat-event',
    storageBucket: 'repat-event.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCO2XB013N3bEwwgLzr8YrJgjZV9aSUh9s',
    appId: '1:1065840664684:ios:98adf2f24edc7893507849',
    messagingSenderId: '1065840664684',
    projectId: 'repat-event',
    storageBucket: 'repat-event.firebasestorage.app',
    androidClientId: '1065840664684-95kb8hd6u2sqmdfhe1ff15h9vv39pjbf.apps.googleusercontent.com',
    iosClientId: '1065840664684-6c22065pfohvkut0fnnijj9mge4r0758.apps.googleusercontent.com',
    iosBundleId: 'com.example.verygoodcore.repat-event',
  );
}
