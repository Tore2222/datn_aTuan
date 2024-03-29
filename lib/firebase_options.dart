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
    apiKey: 'AIzaSyDb9V8Y35Q8KEq4zlEaUTBOFeC9P_WIvwc',
    appId: '1:88296079020:web:72cc2e13a0c250c7f52909',
    messagingSenderId: '88296079020',
    projectId: 'classroom-management-55753',
    authDomain: 'classroom-management-55753.firebaseapp.com',
    databaseURL: 'https://classroom-management-55753-default-rtdb.firebaseio.com',
    storageBucket: 'classroom-management-55753.appspot.com',
    measurementId: 'G-7C1PD6L1B2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBHrfKSzOEiQrsHf7bR0yK7VI-X-3zAstQ',
    appId: '1:88296079020:android:cb362d020f7ca54af52909',
    messagingSenderId: '88296079020',
    projectId: 'classroom-management-55753',
    databaseURL: 'https://classroom-management-55753-default-rtdb.firebaseio.com',
    storageBucket: 'classroom-management-55753.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANLbMOUXvzNT0ISOEMPzm3azNNEN9pUl0',
    appId: '1:88296079020:ios:fd36f177a9abbaf6f52909',
    messagingSenderId: '88296079020',
    projectId: 'classroom-management-55753',
    databaseURL: 'https://classroom-management-55753-default-rtdb.firebaseio.com',
    storageBucket: 'classroom-management-55753.appspot.com',
    iosBundleId: 'com.example.classManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyANLbMOUXvzNT0ISOEMPzm3azNNEN9pUl0',
    appId: '1:88296079020:ios:8964f306c73f31a6f52909',
    messagingSenderId: '88296079020',
    projectId: 'classroom-management-55753',
    databaseURL: 'https://classroom-management-55753-default-rtdb.firebaseio.com',
    storageBucket: 'classroom-management-55753.appspot.com',
    iosBundleId: 'com.example.classManagement.RunnerTests',
  );
}
