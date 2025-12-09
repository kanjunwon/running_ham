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
    apiKey: 'AIzaSyDqRnGDU0h6vFdumXSH3Z9OIQwsyQGh-NI',
    appId: '1:533174593179:web:8f51262a5e638e80f2083e',
    messagingSenderId: '533174593179',
    projectId: 'running-ham-59c20',
    authDomain: 'running-ham-59c20.firebaseapp.com',
    storageBucket: 'running-ham-59c20.firebasestorage.app',
    measurementId: 'G-5SPEVXEQ94',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDnqmDIldSAS1TxoPtkI7xsZhhSyuahJk',
    appId: '1:533174593179:android:3094273aaeb4eb62f2083e',
    messagingSenderId: '533174593179',
    projectId: 'running-ham-59c20',
    storageBucket: 'running-ham-59c20.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiMFLERoPVJruOzIMEKvbAy7KOQv7TySQ',
    appId: '1:533174593179:ios:ae814e3835ecdfe6f2083e',
    messagingSenderId: '533174593179',
    projectId: 'running-ham-59c20',
    storageBucket: 'running-ham-59c20.firebasestorage.app',
    iosBundleId: 'com.example.runningHam',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDiMFLERoPVJruOzIMEKvbAy7KOQv7TySQ',
    appId: '1:533174593179:ios:ae814e3835ecdfe6f2083e',
    messagingSenderId: '533174593179',
    projectId: 'running-ham-59c20',
    storageBucket: 'running-ham-59c20.firebasestorage.app',
    iosBundleId: 'com.example.runningHam',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDqRnGDU0h6vFdumXSH3Z9OIQwsyQGh-NI',
    appId: '1:533174593179:web:64556f98124c2127f2083e',
    messagingSenderId: '533174593179',
    projectId: 'running-ham-59c20',
    authDomain: 'running-ham-59c20.firebaseapp.com',
    storageBucket: 'running-ham-59c20.firebasestorage.app',
    measurementId: 'G-D8BZ0G51HV',
  );
}
