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
    apiKey: 'AIzaSyBvWtDCCqWuM3qWVKc0w_z5VpSRBqZv2ZQ',
    appId: '1:731451279989:web:0eef37e03f6b8ca163063c',
    messagingSenderId: '731451279989',
    projectId: 'linkup-274be',
    authDomain: 'linkup-274be.firebaseapp.com',
    storageBucket: 'linkup-274be.appspot.com',
    measurementId: 'G-HW3KKRT6DY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMNFcr_52ud_Fv31mm7H_xpBMs_faKU9k',
    appId: '1:731451279989:android:54b958188f5ff92d63063c',
    messagingSenderId: '731451279989',
    projectId: 'linkup-274be',
    storageBucket: 'linkup-274be.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLzoeqVJTD44mwnHOS8DijzArZ6BnLtpw',
    appId: '1:731451279989:ios:663beefd9906a60d63063c',
    messagingSenderId: '731451279989',
    projectId: 'linkup-274be',
    storageBucket: 'linkup-274be.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDLzoeqVJTD44mwnHOS8DijzArZ6BnLtpw',
    appId: '1:731451279989:ios:663beefd9906a60d63063c',
    messagingSenderId: '731451279989',
    projectId: 'linkup-274be',
    storageBucket: 'linkup-274be.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBvWtDCCqWuM3qWVKc0w_z5VpSRBqZv2ZQ',
    appId: '1:731451279989:web:8a297a98dbedc5df63063c',
    messagingSenderId: '731451279989',
    projectId: 'linkup-274be',
    authDomain: 'linkup-274be.firebaseapp.com',
    storageBucket: 'linkup-274be.appspot.com',
    measurementId: 'G-WY724FNKCP',
  );

}