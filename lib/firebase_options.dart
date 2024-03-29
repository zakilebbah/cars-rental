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
    apiKey: 'AIzaSyBcnPFdZ8c54AqGFDHhCePfRTvvkw4i45g',
    appId: '1:961911417473:web:aaf7c9d7525d7c6bf5bb80',
    messagingSenderId: '961911417473',
    projectId: 'beyondi-ecadb',
    authDomain: 'beyondi-ecadb.firebaseapp.com',
    storageBucket: 'beyondi-ecadb.appspot.com',
    measurementId: 'G-XVNFS856P2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvPTWboYbJbz8DMySumu5G0GY5pYFDTQI',
    appId: '1:961911417473:android:573fbb296cbebda3f5bb80',
    messagingSenderId: '961911417473',
    projectId: 'beyondi-ecadb',
    storageBucket: 'beyondi-ecadb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3VMf2ujQBC6VXpSUNcjIEIke5n-FoRVQ',
    appId: '1:961911417473:ios:d237d8ebce66f9e6f5bb80',
    messagingSenderId: '961911417473',
    projectId: 'beyondi-ecadb',
    storageBucket: 'beyondi-ecadb.appspot.com',
    iosBundleId: 'com.example.carRenting',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD3VMf2ujQBC6VXpSUNcjIEIke5n-FoRVQ',
    appId: '1:961911417473:ios:1c4ce0165ed9a786f5bb80',
    messagingSenderId: '961911417473',
    projectId: 'beyondi-ecadb',
    storageBucket: 'beyondi-ecadb.appspot.com',
    iosBundleId: 'com.example.carRenting.RunnerTests',
  );
}
