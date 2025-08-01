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
    apiKey: 'AIzaSyCM4qcu9RCtB8tp5BpLhQqylbm7XBsE7R4',
    appId: '1:990093975974:web:3bdf7a1eabfaed8ba32f67',
    messagingSenderId: '990093975974',
    projectId: 'futur-1d83e',
    authDomain: 'futur-1d83e.firebaseapp.com',
    storageBucket: 'futur-1d83e.firebasestorage.app',
    measurementId: 'G-DSP3LZ2FLZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZliW6jV16ReXLfiRK3HFjwAEAxwcjZr8',
    appId: '1:990093975974:android:1d3fb14ff0b2c937a32f67',
    messagingSenderId: '990093975974',
    projectId: 'futur-1d83e',
    storageBucket: 'futur-1d83e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfNbGFitsLRaoLcZlpXTiaZkxFYT_RAHY',
    appId: '1:990093975974:ios:714dc88d18937479a32f67',
    messagingSenderId: '990093975974',
    projectId: 'futur-1d83e',
    storageBucket: 'futur-1d83e.firebasestorage.app',
    iosBundleId: 'com.example.futurMobileBanking',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDfNbGFitsLRaoLcZlpXTiaZkxFYT_RAHY',
    appId: '1:990093975974:ios:714dc88d18937479a32f67',
    messagingSenderId: '990093975974',
    projectId: 'futur-1d83e',
    storageBucket: 'futur-1d83e.firebasestorage.app',
    iosBundleId: 'com.example.futurMobileBanking',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCM4qcu9RCtB8tp5BpLhQqylbm7XBsE7R4',
    appId: '1:990093975974:web:ee4a9ee8ad1b9d6ba32f67',
    messagingSenderId: '990093975974',
    projectId: 'futur-1d83e',
    authDomain: 'futur-1d83e.firebaseapp.com',
    storageBucket: 'futur-1d83e.firebasestorage.app',
    measurementId: 'G-6W9PERV2C9',
  );
}
