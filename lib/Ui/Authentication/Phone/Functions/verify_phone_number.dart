import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:io';
import '../../../1MainHelper/Alerts/alerts.dart';
import '../../../../Providers/AuthDataProvider/auth_data_provider.dart';
import '../../../1MainHelper/Snacks/snackbar.dart';
import '../../../Profile/Screen/profile_screen.dart';
import '../Screen/submit_code_screen.dart';

// general variable to use in all functions in this file
User user;
String verificationIdGeneral;
String phoneNumberGeneral;

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

Future<void> sendVerificationCode({
  BuildContext context,
  String phoneNumber,
  Function resetLoading,
}) async {
  bool check = await checkInternetConnection();
  String output;
  phoneNumberGeneral = phoneNumber;
  if (!check) {
    resetLoading();
    showAlertNoAction(
      context: context,
      message: "لايوجد انترنت",
    );
    return;
  }

  try {
    // Intialize firebase
    await startFireBase();

    // Send verification code
    var auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        // Automatic verification
        // Available on android only

        //await verifyCode(
        //context: context,
        //phoneAuthCredential: phoneAuthCredential,
        //smsCode: null,
        //resetLoading: () {
        //print("no need to reset");
        //},
        //);
      },
      timeout: Duration(
        seconds: 120,
      ),
      verificationFailed: (FirebaseAuthException e) {
        print("123");
        output = e.code;
        resetLoading();
        showAlertNoAction(
          context: context,
          message: output,
        );
        return;
      },
      codeSent: (String verificationId, int resendToken) {
        print("456");
        verificationIdGeneral = verificationId;
        output = "Code sent";
        resetLoading();
        Navigator.of(context).pushReplacementNamed(VerifyCodeScreen.routeName);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("789");
        output = "Timeout, try again";
        resetLoading();
        showAlertNoAction(
          context: context,
          message: output,
        );
        return;
      },
    );
  } on FirebaseException catch (_) {
    print("1 FirebaseException ");
    resetLoading();
    showAlertNoAction(
      context: context,
      message: "لقد حدث خطأ",
    );
  } on SocketException catch (_) {
    resetLoading();
    showAlertNoAction(
      context: context,
      message: "لايوجد انترنت",
    );

    return;
  } catch (e) {
    print(e);
    resetLoading();
    showAlertNoAction(
      context: context,
      message: "!لقد حدث خطأ",
    );
    return;
  }
}

Future<void> verifyCode({
  BuildContext context,
  String smsCode,
  PhoneAuthCredential phoneAuthCredential,
}) async {
  String output;
  PhoneAuthCredential newPhoneAuthCredential;
  bool check = await checkInternetConnection();
  if (!check) {
    showAlertNoAction(
      context: context,
      message: "لايوجد انترنت",
    );
    return;
  }
  try {
    // Intialize firebase
    await startFireBase();

    // Send verification code
    var fA = FirebaseAuth.instance;
    print(smsCode);
    newPhoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationIdGeneral, smsCode: smsCode);

    print(23);

    await fA.signInWithCredential(newPhoneAuthCredential);

    print("1");

    // add phone number to auth data in offline database
    await Provider.of<AuthDataProvider>(context, listen: false)
        .updatePhoneNumberInAuthDataTable(
      phoneNumberInp: phoneNumberGeneral,
    );

    // This to update ui after verifing phone number

    showTopSnackBar(
      context: context,
      title: "مبروك",
      body: "تم تأكيد رقم هاتفك بنجاح",
    );

    await Future.delayed(
      Duration(milliseconds: 2000),
    );
    // pop add phone number screen
    Navigator.of(context)
        .popUntil((route) => route.settings.name == ProfileScreen.routeName);

    return null;
  } on FirebaseException catch (e) {
    print("2 FirebaseException ");
    showAlertNoAction(
      context: context,
      message: e.message,
    );
  } on SocketException catch (_) {
    showAlertNoAction(
      context: context,
      message: "No internet connection!",
    );

    return;
  } catch (e) {
    print(e);
    showAlertNoAction(
      context: context,
      message: "Invalid",
    );
    return;
  }
}
