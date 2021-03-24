import 'dart:io';
import 'package:provider/provider.dart';
import 'package:woocommerce_api/woocommerce_api.dart';
import '../../../../Providers/AuthDataProvider/auth_data_provider.dart';
import '../../../../Models/UserAuthModel/user_auth_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> signUpWithEmailAndPassword({
  BuildContext context,
  UserAuthModel userAuthModel,
}) async {
  // Check internet connection
  bool check = await checkInternetConnection();
  String output;

  if (!check) {
    return "لايوجد لديك انترنت";
  }

  try {
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
      url: "https://050saa.com",
      consumerKey: "ck_da5c9ea679814a228bcd5cda0c3c1b932c98ff1d",
      consumerSecret: "cs_aa9486fe01e314e72b5b2d50ae109c84a682f749",
    );
    var response = await wooCommerceAPI.postAsync(
      "customers",
      {
        "email": userAuthModel.email,
        "password": userAuthModel.password,
        "username": userAuthModel.storeName,
      },
    );

    print(response);
    try {
      if (response["code"].contains("registration-error-email-exists")) {
        output = "البريد الالكتروني موجود مسبقا";
      } else if (response["code"]
          .contains("registration-error-username-exists")) {
        output = "اسم المستخدم موجود بالفعل";
      } else {
        output = "لقد حدث خطأ";
      }
    } catch (_) {
      output = await updateToVendor(
        context: context,
        userAuthModel: userAuthModel,
        userId: response["id"].toString(),
      );
    }

    return output;
  } on SocketException catch (_) {
    return "لايوجد لديك انترنت";
  } catch (e) {
    print(e);
    return "لقد حدذ خطأ!";
  }
}

Future<String> updateToVendor({
  BuildContext context,
  UserAuthModel userAuthModel,
  String userId,
}) async {
  try {
    String output;
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.post(
      "https://050saa.com/wp-json/app-register/register",
      body: jsonEncode(
        {
          "username": userAuthModel.userName,
          "userid": userId,
        },
      ),
      headers: headers,
    );
    print("--------");
    print(response.statusCode);
    if (response.statusCode == 200) {
      output = await loginWithEmailAndPassword(
        context: context,
        userAuthModel: userAuthModel,
      );
    } else {
      output = "لقد حدث خطأ";
    }
    return output;
  } on SocketException catch (_) {
    return "لايوجد لديك انترنت";
  } catch (e) {
    print(e);
    return "لقد حدذ خطأ!";
  }
}

Future<String> loginWithEmailAndPassword({
  BuildContext context,
  UserAuthModel userAuthModel,
}) async {
  // Check internet connection
  bool check = await checkInternetConnection();
  String output;

  if (!check) {
    return "لايوجد انترنت";
  }

  try {
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.post(
      "https://050saa.com/wp-json/app-login/login",
      body: jsonEncode(
        {
          "username": userAuthModel.email,
          "password": userAuthModel.password,
        },
      ),
      headers: headers,
    );
    if (response.statusCode == 200) {
      Map outMap = json.decode(response.body);

      await Provider.of<AuthDataProvider>(context, listen: false)
          .updateAuthDataTable(
        userAuthModelInp: UserAuthModel.fromWooCommerce(
          map: outMap,
          passwordInp: userAuthModel.password,
        ),
      );
      output = null;
    } else {
      if (response.body.contains("incorrect_password")) {
        output = "الباسورد غير صحيح";
      } else if (response.body.contains("invalid_username")) {
        output = "اسم المستخدم غير صحيح";
      } else if (response.body.contains("invalid_email")) {
        output = "البريد الالكتروني غير صحيح";
      } else {
        output = "لقد حدث خطأ";
      }
    }
    return output;
  } on SocketException catch (_) {
    return "لايوجد انترنت";
  } catch (e) {
    return "لقد حدث خطأ";
  }
}

// https://050saa.com/wp-json/app-login/login
//https://050saa.com/wp-json/app-register/register
//https://050saa.com/wp-json/wc/v1/customers

Future<bool> checkInternetConnection() async {
  try {
    await InternetAddress.lookup('google.com');
    //Nothing to do --> continue in code
  } on SocketException catch (_) {
    return false;
  }
  return true;
}
