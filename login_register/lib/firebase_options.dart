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
    apiKey: 'AIzaSyA-JIeCA_JEUinJWrTmSlJizHwz-4OPJ2w',
    appId: '1:995812750799:web:f75c37c43d529c69648eba',
    messagingSenderId: '995812750799',
    projectId: 'fir-auth-27792',
    authDomain: 'fir-auth-27792.firebaseapp.com',
    storageBucket: 'fir-auth-27792.appspot.com',
    measurementId: 'G-MCS4T8JFXT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB1ydGB9zOT31dhREcvhXZsYZVeIcx2ueI',
    appId: '1:995812750799:android:6c53b9dee411023b648eba',
    messagingSenderId: '995812750799',
    projectId: 'fir-auth-27792',
    storageBucket: 'fir-auth-27792.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCjlOzETRM1ZP-rXqDqg41ZrCznedsISVw',
    appId: '1:995812750799:ios:e4c410910c8b41e2648eba',
    messagingSenderId: '995812750799',
    projectId: 'fir-auth-27792',
    storageBucket: 'fir-auth-27792.appspot.com',
    iosBundleId: 'com.example.loginRegister',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCjlOzETRM1ZP-rXqDqg41ZrCznedsISVw',
    appId: '1:995812750799:ios:e4c410910c8b41e2648eba',
    messagingSenderId: '995812750799',
    projectId: 'fir-auth-27792',
    storageBucket: 'fir-auth-27792.appspot.com',
    iosBundleId: 'com.example.loginRegister',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA-JIeCA_JEUinJWrTmSlJizHwz-4OPJ2w',
    appId: '1:995812750799:web:b0d4c2f8f2fa45fd648eba',
    messagingSenderId: '995812750799',
    projectId: 'fir-auth-27792',
    authDomain: 'fir-auth-27792.firebaseapp.com',
    storageBucket: 'fir-auth-27792.appspot.com',
    measurementId: 'G-7WN0MJSVTR',
  );
}