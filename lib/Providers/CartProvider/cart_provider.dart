import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:woocommerce/models/cart_item.dart';
import 'package:woocommerce/woocommerce.dart';

class CartProvider with ChangeNotifier {
  WooCommerce woocommerce = WooCommerce(
    baseUrl: "https://050saa.com",
    consumerKey: "ck_da5c9ea679814a228bcd5cda0c3c1b932c98ff1d",
    consumerSecret: "cs_aa9486fe01e314e72b5b2d50ae109c84a682f749",
  );
  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  String uid = "";

  List<WooCartItem> cartItems = [];
  List<WooProduct> cartItemsProducts = [];

  Future<bool> checkInternetConnection() async {
    try {
      await InternetAddress.lookup('google.com');
      //Nothing to do --> continue in code
    } on SocketException catch (_) {
      return false;
    }
    return true;
  }

  WooCartItem wooCartItemFromJson({Map<String, dynamic> jsonMap}) {
    //List<WooCartItemImages> images;

    List<String> variations = [];
    print("----------- cart map ---------- ");
    print(jsonMap);
    var variationsTmep = jsonMap["variation"];
    print("----------- cart variation ---------- ");
    print(variationsTmep);
    print("---------- cart variation id ---------- ");
    print(jsonMap["variation_id"].toString());
    if (variationsTmep.length != 0) {
      variationsTmep.forEach((key, value) {
        variations.add(key);
        variations.add(value);
      });
    }

    return WooCartItem(
      id: jsonMap["product_id"],
      images: <WooCartItemImages>[
        WooCartItemImages(
          src: "",
        ),
      ],
      key: jsonMap["key"],
      linePrice: jsonMap["line_total"].toString(),
      name: jsonMap["product_name"],
      //permalink: jsonMap[""],
      price: jsonMap["product_price"].toString(),
      quantity: jsonMap["quantity"],
      variation: variations,
      sku: jsonMap["variation_id"].toString(),
    );
  }

  Future<bool> fetchCartProducts({int page, String vendroId}) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return false;
    }

    try {
      WooCartItem cartItem;

      final response = await http.get(
        "https://050saa.com/wp-json/cocart/v1/get-cart?cart_key=$uid",
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map outMap = json.decode(response.body);

        cartItems.clear();
        outMap.forEach((key1, value) async {
          cartItem = wooCartItemFromJson(jsonMap: value);

          cartItems.add(cartItem);
        });
      }

      await getCartItemsMissingData();

      return true;
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> getCartItemsMissingData() async {
    int counter = 0;

    while (counter < cartItems.length) {
      WooProduct product = await woocommerce.getProductById(
        id: cartItems[counter].id,
      );
      cartItemsProducts.add(product);
      cartItems[counter].permalink = product.permalink;
      cartItems[counter].images[0].src = product.images[0].src ?? "";

      counter += 1;
    }
  }

  Future<bool> addProductToCart({
    String productId,
    String quantity,
    String attributePaColor,
    String attributePaSex,
    String attributePaSize,
  }) async {
    try {
      print("yyyyyyyyyyyyy");
      print(uid);
      final response = await http.post(
        "https://050saa.com/wp-json/cocart/v1/add-item?cart_key=$uid",
        headers: headers,
        body: json.encode({
          "product_id": productId,
          "quantity": quantity,
          "variation": {
            "attribute_pa_size": attributePaSize,
            "attribute_pa_sex": attributePaSex,
            "attribute_pa_color": attributePaColor,
          },
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      print(e);
      return false;
    }
    //notifyListeners();
  }

  Future<bool> removeProductFromCart({WooCartItem cartItem}) async {
    try {
      String cartItemKey = cartItem.key;

      final response = await http.delete(
          "https://050saa.com/wp-json/cocart/v1/item?cart_key=$uid&cart_item_key=$cartItemKey",
          headers: headers);
      print(response.statusCode);

      if (response.statusCode == 200) {
        cartItems.removeWhere((element) => element.key == cartItemKey);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  List<WooCartItem> getCartItems() {
    return [...cartItems];
  }

  WooProduct getProductById({@required int id}) {
    return cartItemsProducts.firstWhere((element) => element.id == id);
  }

  Future<void> clearCart() async {
    cartItems.clear();
  }

  void setUid({@required String uidInp}) {
    uid = uidInp;
  }
}
