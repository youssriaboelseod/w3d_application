import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:woocommerce_api/woocommerce_api.dart';
//

WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
  url: "https://050saa.com",
  consumerKey: "ck_da5c9ea679814a228bcd5cda0c3c1b932c98ff1d",
  consumerSecret: "cs_aa9486fe01e314e72b5b2d50ae109c84a682f749",
);
Future<String> resetPasswordFn({String email}) async {
  try {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return "No internet connection!";
    }
    http.Response response;
    String username = "auth@gmail.com";
    String password = "ASD123456zxc#";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    return null;
  } catch (_) {
    return "Database problem";
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
