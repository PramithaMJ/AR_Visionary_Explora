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
    apiKey: 'AIzaSyBsuL-BZWJBBzvaRPHzkRBZijg85rsAWQ4',
    appId: '1:408294414641:web:962e51565526339e01b810',
    messagingSenderId: '408294414641',
    projectId: 'ar-visionary-explora-2ca98',
    authDomain: 'ar-visionary-explora-2ca98.firebaseapp.com',
    storageBucket: 'ar-visionary-explora-2ca98.appspot.com',
    measurementId: 'G-DPLN0T9DLQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATkBkFdPL8neye9j0kkBLKlcsKoxWzY_Q',
    appId: '1:408294414641:android:82a6668106c11a7701b810',
    messagingSenderId: '408294414641',
    projectId: 'ar-visionary-explora-2ca98',
    storageBucket: 'ar-visionary-explora-2ca98.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDi1aGYJpCQvoKt674bB6L5vBG_EHvrbo8',
    appId: '1:408294414641:ios:a8d2654374572cc901b810',
    messagingSenderId: '408294414641',
    projectId: 'ar-visionary-explora-2ca98',
    storageBucket: 'ar-visionary-explora-2ca98.appspot.com',
    iosBundleId: 'com.example.arVisionaryExplora',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDi1aGYJpCQvoKt674bB6L5vBG_EHvrbo8',
    appId: '1:408294414641:ios:1c7017daec614c6b01b810',
    messagingSenderId: '408294414641',
    projectId: 'ar-visionary-explora-2ca98',
    storageBucket: 'ar-visionary-explora-2ca98.appspot.com',
    iosBundleId: 'com.example.arVisionaryExplora.RunnerTests',
  );
}
