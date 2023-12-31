import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDslX21JB909mQcYnIf55hIPJ3e-m-cJrY',
    appId: '1:977577507743:web:55a064dbe694deb93e9baa',
    messagingSenderId: '977577507743',
    projectId: 'flutter-app-391817',
    authDomain: 'flutter-app-391817.firebaseapp.com',
    databaseURL: 'https://flutter-app-391817-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-app-391817.appspot.com',
    measurementId: 'G-SQQWK7Q2LF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgvarFLuqAYE9By4KeW-No0VKtIQH09J4',
    appId: '1:977577507743:android:f2993b779889d4603e9baa',
    messagingSenderId: '977577507743',
    projectId: 'flutter-app-391817',
    databaseURL: 'https://flutter-app-391817-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-app-391817.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBO8YKNo32mfRa3JV6-U3L-TfDu1KPxan4',
    appId: '1:977577507743:ios:fe899b24879f23aa3e9baa',
    messagingSenderId: '977577507743',
    projectId: 'flutter-app-391817',
    databaseURL: 'https://flutter-app-391817-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-app-391817.appspot.com',
    androidClientId:
        '977577507743-qkpjd37epgl9lfhd1i0vb3i2itaoc11n.apps.googleusercontent.com',
    iosClientId:
        '977577507743-a0vc9lfa9vn42ninjfe2g7sseffd73gb.apps.googleusercontent.com',
    iosBundleId: 'com.google.firebase.presents.flutterFirebaseCli',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBO8YKNo32mfRa3JV6-U3L-TfDu1KPxan4',
    appId: '1:977577507743:ios:d753d22fd7d6bd743e9baa',
    messagingSenderId: '977577507743',
    projectId: 'flutter-app-391817',
    databaseURL: 'https://flutter-app-391817-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-app-391817.appspot.com',
    androidClientId:
        '977577507743-qkpjd37epgl9lfhd1i0vb3i2itaoc11n.apps.googleusercontent.com',
    iosClientId:
        '977577507743-7upvj38iiqb1pojqj7d0qcdc7r5qline.apps.googleusercontent.com',
    iosBundleId: 'com.google.firebase.presents.flutterFirebaseCli.RunnerTests',
  );
}
