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
    apiKey: 'AIzaSyA38rZeMeWkAfbBlohKkAQcA175yJH_wHo',
    appId: '1:650488213329:web:807c412a79d6e4bc92ed70',
    messagingSenderId: '650488213329',
    projectId: 'estacionamiento-f',
    authDomain: 'estacionamiento-f.firebaseapp.com',
    storageBucket: 'estacionamiento-f.appspot.com',
    measurementId: 'G-SCBHB1GHQ3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfkioKl5yWwdji-ZgHJNPZdxJtgwT3kjY',
    appId: '1:650488213329:android:095602d420c625ce92ed70',
    messagingSenderId: '650488213329',
    projectId: 'estacionamiento-f',
    storageBucket: 'estacionamiento-f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfxySRxZ-TMWd95tR7IzGK-ZQjUO1l5a4',
    appId: '1:650488213329:ios:5540b42419bb88b692ed70',
    messagingSenderId: '650488213329',
    projectId: 'estacionamiento-f',
    storageBucket: 'estacionamiento-f.appspot.com',
    iosBundleId: 'com.estacionamiento.estacionamiento',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBfxySRxZ-TMWd95tR7IzGK-ZQjUO1l5a4',
    appId: '1:650488213329:ios:1abe55c10b42bfcc92ed70',
    messagingSenderId: '650488213329',
    projectId: 'estacionamiento-f',
    storageBucket: 'estacionamiento-f.appspot.com',
    iosBundleId: 'com.hm.estacionamiento',
  );
}