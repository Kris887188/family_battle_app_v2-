import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyBpT1HHMMj-jJzSV-cZXBFOoW6icWMWZaM',
        authDomain: 'family-quiz-61247.firebaseapp.com',
        databaseURL: 'https://family-quiz-61247-default-rtdb.firebaseio.com',
        projectId: 'family-quiz-61247',
        storageBucket: 'family-quiz-61247.appspot.com',
        messagingSenderId: '256450955659',
        appId: '1:256450955659:web:edd8fa689fa4bae05b078e',
        measurementId: 'G-EEQGSV4MTW',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const FirebaseOptions(
          apiKey: 'AIzaSyBpT1HHMMj-jJzSV-cZXBFOoW6icWMWZaM',
          appId: '1:256450955659:android:dbd18e4f72388ceb5b078e',
          messagingSenderId: '256450955659',
          projectId: 'family-quiz-61247',
          storageBucket: 'family-quiz-61247.appspot.com',
        );
      case TargetPlatform.iOS:
        return const FirebaseOptions(
          apiKey: 'AIzaSyBpT1HHMMj-jJzSV-cZXBFOoW6icWMWZaM',
          appId: '1:256450955659:ios:2579b6542fd4102c5b078e',
          messagingSenderId: '256450955659',
          projectId: 'family-quiz-61247',
          storageBucket: 'family-quiz-61247.appspot.com',
          iosClientId: 'YOUR_IOS_CLIENT_ID.apps.googleusercontent.com',
          iosBundleId: 'com.yourname.familybattle',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }
}