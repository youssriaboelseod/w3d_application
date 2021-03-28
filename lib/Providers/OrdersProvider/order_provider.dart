import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w3d/Providers/CartProvider/cart_provider.dart';
import 'package:w3d/Ui/1MainHelper/Helpers/helper.dart';
import 'package:woocommerce/models/cart_item.dart';
import 'package:woocommerce/models/order_payload.dart';
import 'package:woocommerce/woocommerce.dart';

class OrdersProvider with ChangeNotifier {
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

  Future<List<WooOrder>> fetchOrders({int page, String vendroId}) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return [];
    }

    try {
      List<WooOrder> outList = [];
      print(uid);
      outList = await woocommerce.getOrders(
        customer: int.parse(uid),
      );

      return outList;
    } on SocketException catch (_) {
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<String> createOrder({
    BuildContext context,
    String firstName,
    String city,
    String address,
    String location,
    String email,
    String note,
    String phoneNumber,
    PaymentMethods paymentMethod,
  }) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return "لايوجد لديك انترنت";
    }

    try {
      WooOrderPayloadShipping shipping = WooOrderPayloadShipping(
        firstName: firstName,
        lastName: "",
        city: city,
        address1: address,
        state: location,
        address2: phoneNumber,
        country: "المملكة العربية السعودية",
        postcode: note,
      );
      WooOrderPayloadBilling billing = WooOrderPayloadBilling(
        firstName: firstName,
        lastName: "",
        city: city,
        address1: address,
        address2: phoneNumber,
        state: location,
        email: email,
        phone: phoneNumber,
        country: "المملكة العربية السعودية",
        postcode: note,
      );
      double totalPrice = 0;
      List<LineItems> lineItems = [];
      cartItems =
          Provider.of<CartProvider>(context, listen: false).getCartItems();

      cartItems.forEach((element) {
        String valueModified = "0";
        valueModified = element.linePrice.replaceAll("ر.س", "");
        if (valueModified != null) {
          totalPrice += double.tryParse(valueModified);
        }

        lineItems.add(
          LineItems(
            name: element.name,
            productId: element.id,
            quantity: element.quantity,
            total: element.linePrice,
            variationId: element.sku.isNotEmpty ? int.parse(element.sku) : null,
          ),
        );
      });
      ShippingLines shippingLines = ShippingLines(
        methodId: "flat_rate",
        methodTitle: "Flat Rate",
        total: "29.00",
      );

      WooOrderPayload orderPayload = WooOrderPayload(
        customerId: int.parse(uid),
        customerNote: note,
        shippingLines: totalPrice > 150
            ? []
            : [
                shippingLines,
              ],
        shipping: shipping,
        lineItems: lineItems,
        billing: billing,
        paymentMethod: paymentMethodsList.elementAt(paymentMethod.index),
        paymentMethodTitle:
            paymentMethodTitlesList.elementAt(paymentMethod.index),
      );

      WooOrder orderOutput = await woocommerce.createOrder(orderPayload);
      await Provider.of<CartProvider>(context, listen: false)
          .removeAllProductsFromCart(
        cartItems: cartItems,
      );

      return null;
    } on SocketException catch (_) {
      return "لايوجد لديك انترنت";
    } catch (e) {
      print(e);
      return "لقد حدث خطأ من فضلك حاول مرة اخرى";
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
