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
    apiKey: 'AIzaSyAMvKvwTVyQr5Xl6l-zrYzUUwuNn5TP6H8',
    appId: '1:333236741121:web:34f7bad642d11140d6cc00',
    messagingSenderId: '333236741121',
    projectId: 'shopit-fdbc0',
    authDomain: 'shopit-fdbc0.firebaseapp.com',
    storageBucket: 'shopit-fdbc0.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJI-N4Ce89lwxCxr46syliuIttxIGHYC0',
    appId: '1:333236741121:android:4449d76e13081b15d6cc00',
    messagingSenderId: '333236741121',
    projectId: 'shopit-fdbc0',
    storageBucket: 'shopit-fdbc0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCsZsnZVkHv-LR5ondtRXql6COecnf4LEc',
    appId: '1:333236741121:ios:61b5e4abdb81b204d6cc00',
    messagingSenderId: '333236741121',
    projectId: 'shopit-fdbc0',
    storageBucket: 'shopit-fdbc0.appspot.com',
    iosBundleId: 'com.example.shopit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCsZsnZVkHv-LR5ondtRXql6COecnf4LEc',
    appId: '1:333236741121:ios:ac2d9b3b8fba9df7d6cc00',
    messagingSenderId: '333236741121',
    projectId: 'shopit-fdbc0',
    storageBucket: 'shopit-fdbc0.appspot.com',
    iosBundleId: 'com.example.shopit.RunnerTests',
  );
}
