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
    apiKey: 'AIzaSyD3yarOazJpOUlzToIE6EnJIAx8M6V6SVA',
    appId: '1:619333109852:web:543f51325159040169fe99',
    messagingSenderId: '619333109852',
    projectId: 'my-chat-app-3f8f6',
    authDomain: 'my-chat-app-3f8f6.firebaseapp.com',
    storageBucket: 'my-chat-app-3f8f6.appspot.com',
    measurementId: 'G-W5Q8VRKP2N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCU5CdA-i01e2qVm3mKh7-sQK91XGxm3H0',
    appId: '1:619333109852:android:1c7dda8eef60d3de69fe99',
    messagingSenderId: '619333109852',
    projectId: 'my-chat-app-3f8f6',
    storageBucket: 'my-chat-app-3f8f6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXNL7IBn75Hg23ir-c7XDLhEj6J35YAZg',
    appId: '1:619333109852:ios:aeaccb0a65c3b99869fe99',
    messagingSenderId: '619333109852',
    projectId: 'my-chat-app-3f8f6',
    storageBucket: 'my-chat-app-3f8f6.appspot.com',
    iosClientId: '619333109852-9vulg22stsp95iv7k15nh109gnunvpbr.apps.googleusercontent.com',
    iosBundleId: 'com.example.myChatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAXNL7IBn75Hg23ir-c7XDLhEj6J35YAZg',
    appId: '1:619333109852:ios:aeaccb0a65c3b99869fe99',
    messagingSenderId: '619333109852',
    projectId: 'my-chat-app-3f8f6',
    storageBucket: 'my-chat-app-3f8f6.appspot.com',
    iosClientId: '619333109852-9vulg22stsp95iv7k15nh109gnunvpbr.apps.googleusercontent.com',
    iosBundleId: 'com.example.myChatApp',
  );
}
