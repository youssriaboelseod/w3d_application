import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

Future<String> resetPasswordFn({String email}) async {
  try {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return "No internet connection!";
    }

    // Intialize firebase
    await startFireBase();

    FirebaseAuth fA;
    fA = FirebaseAuth.instance;
    //
    await fA.sendPasswordResetEmail(email: email);
    //
    return null;
  } catch (_) {
    return "Database problem";
  }
}

Future<void> startFireBase() async {
  print("Starting firebase .......");
  await Firebase.initializeApp();
}

Future<bool> checkInternetConnection() async {
  try {
    await InternetAddress.lookup('google.com');
    //Nothing to do --> continue in code
  } on SocketException catch (_) {
    return false;
  }
  return true;
}
