import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:w3d/Providers/AuthDataProvider/auth_data_provider.dart';

Future<dynamic> getVariationPrice(
    {String productId, BuildContext context}) async {
  String url =
      "https://050saa.com/wp-json/wc/v3/products/$productId/variations/";
// Check internet connection
  bool check = await checkInternetConnection();

  if (!check) {
    return "لايوجد لديك انترنت";
  }

  try {
    http.Response response;

    String username = Provider.of<AuthDataProvider>(context, listen: false)
        .currentUser
        .userName;
    String password = Provider.of<AuthDataProvider>(context, listen: false)
        .currentUser
        .password;

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    final Map<String, String> headerCreate = {
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': basicAuth,
    };

    response = await http.get(
      url,
      headers: headerCreate,
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      final outputProdcut = json.decode(response.body);
      //print(outputProdcut);

      return outputProdcut;
    } else {
      return null;
    }
  } on SocketException catch (_) {
    return null;
  } catch (e) {
    print(e);
    return null;
  }
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
