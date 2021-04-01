import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';
import 'dart:math';

class ProductsProvider with ChangeNotifier {
  Random random = new Random();
  http.Response response;
  String username = "auth@gmail.com";
  String password = "ASD123456zxc#";

  WooCommerce woocommerce = WooCommerce(
    baseUrl: "https://050saa.com",
    consumerKey: "ck_da5c9ea679814a228bcd5cda0c3c1b932c98ff1d",
    consumerSecret: "cs_aa9486fe01e314e72b5b2d50ae109c84a682f749",
  );

  List<Map<String, dynamic>> onSaleProducts = [];
  List<Map<String, dynamic>> homePageSouqProducts = [];
  List<Map<String, dynamic>> homePageMostViewedProducts = [];
  List<Map<String, dynamic>> homePagePopularProducts = [];
  List<Map<String, dynamic>> vendorProducts = [];
  //
  List<Map<String, dynamic>> exampleForProductsList = [
    {
      //"vendorId":  element["store"]["vendor_id"],
      //"vendorName":  element["store"]["vendor_shop_name"],
      "value": "WooProduct()",
    },
  ];

  int categoryPageNumber = 1;
  int vendorPageNumber = 1;
  int pageNumber = 1;

  List<Map<String, dynamic>> productsByCategory = [
    {
      "id": "0",
      "value": <Map>[],
    },
    {
      "id": "154",
      "value": <Map>[],
    },
    {
      "id": "198",
      "value": <Map>[],
    },
    {
      "id": "152",
      "value": <Map>[],
    },
    {
      "id": "151",
      "value": <Map>[],
    },
    {
      "id": "149",
      "value": <Map>[],
    },
  ];
  void resetHomePageProducts() {
    onSaleProducts.clear();
    homePageMostViewedProducts.clear();
    homePageSouqProducts.clear();
    homePagePopularProducts.clear();
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

  Future<void> fetchProductsByPage() async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return;
    }

    try {
      List<WooProduct> fetchedProducts = [];

      fetchedProducts = await woocommerce.getProducts(
        page: pageNumber,
      );

      pageNumber += 1;

      productsByCategory[0]["value"].addAll(fetchedProducts);

      return;
    } on SocketException catch (_) {
      return;
    } catch (e) {
      return;
    }
  }

  Future<bool> fetchVendorProducts({@required String vendroId}) async {
    // Check internet connection
    bool check = await checkInternetConnection();
    if (!check) {
      return false;
    }
    try {
      //var test = await
      final response = await http.get(
        "https://050saa.com/wp-json/wcfmmp/v1/store-vendors/$vendroId/products?page=$vendorPageNumber",
      );

      if (response.statusCode == 200) {
        vendorPageNumber += 1;
        final outputProducts = json.decode(response.body);
        print("outputProducts.length = " + outputProducts.length.toString());

        outputProducts.forEach(
          (element) {
            try {
              WooProduct wooProduct = WooProduct.fromJson(element);
              vendorProducts.add(
                {
                  "vendorId": element["store"]["vendor_id"],
                  "vendorName": element["store"]["vendor_shop_name"],
                  "value": wooProduct,
                },
              );
            } catch (e) {
              print("--------------An error ---------");
              print(e);
            }
          },
        );
      } else {
        return false;
      }
      return true;
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }

  void resetVendorProducts() {
    vendorPageNumber = 1;
    vendorProducts.clear();
  }

  Future<Map<String, dynamic>> getProductById(int productId) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return null;
    }
    try {
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      print(basicAuth);

      //https: //050saa.com/wp-json/wcfmmp/v1/products/?
      String url = "https://050saa.com/wp-json/wcfmmp/v1/products/$productId";

      final Map<String, String> headerCreate = {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth,
      };

      response = await http.get(
        url,
        headers: headerCreate,
      );
      print("Status Code: " + response.statusCode.toString());

      if (response.statusCode == 200) {
        final outputProduct = json.decode(response.body);
        if (outputProduct == null) {
          return null;
        }

        WooProduct wooProduct = WooProduct.fromJson(outputProduct);

        Map<String, dynamic> productMap = {
          "vendorId": outputProduct["store"]["vendor_id"],
          "vendorName": outputProduct["store"]["vendor_shop_name"],
          "value": wooProduct,
        };

        return productMap;
      } else {
        return null;
      }
    } on SocketException catch (_) {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getProductsByName(
      String searchValue) async {
    try {
      List<Map<String, dynamic>> fetchedProductsList = [];

      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));

      String url =
          "https://050saa.com/wp-json/wc/v3/products?per_page=100&search=$searchValue";

      final Map<String, String> headerCreate = {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth,
      };

      response = await http.get(
        url,
        headers: headerCreate,
      );
      print("Status Code: " + response.statusCode.toString());

      if (response.statusCode == 200) {
        final outputProducts = json.decode(response.body);
        print("outputProducts.length = " + outputProducts.length.toString());

        outputProducts.forEach(
          (element) {
            try {
              WooProduct wooProduct = WooProduct.fromJson(element);
              fetchedProductsList.add(
                {
                  "vendorId": element["store"]["vendor_id"],
                  "vendorName": element["store"]["vendor_shop_name"],
                  "value": wooProduct,
                },
              );
            } catch (e) {
              print("--------------An error ---------");
              print(e);
            }
          },
        );
      }
      return fetchedProductsList;
    } on SocketException catch (_) {
      return [];
    } catch (e) {
      return [];
    }
  }

  void removeProductById({int productId}) {
    int index;

    index = vendorProducts
        .indexWhere((element) => element["value"].id == productId);

    if (index != -1) {
      vendorProducts.removeAt(index);
    }

    notifyListeners();
  }

  //
  List<Map<String, dynamic>> tempListForProductsByCategory = [];
  Future<void> fetchProductsByCategory(
      {String categoryId, bool resetCategoryPageNumber}) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return false;
    }

    try {
      String url = "";
      // reset category page number only when switching between categories
      if (resetCategoryPageNumber) {
        categoryPageNumber = 1;
        int index = productsByCategory
            .indexWhere((element) => element["id"] == categoryId);
        tempListForProductsByCategory.clear();
        productsByCategory[index]["value"].clear();
      }

      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));

      if (categoryId == "0") {
        url =
            "https://050saa.com/wp-json/wc/v3/products?page=$categoryPageNumber";
      } else {
        url =
            "https://050saa.com/wp-json/wc/v3/products?page=$categoryPageNumber&category=$categoryId";
      }

      final Map<String, String> headerCreate = {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth,
      };

      response = await http.get(
        url,
        headers: headerCreate,
      );
      print("Status Code: " + response.statusCode.toString());

      if (response.statusCode == 200) {
        final outputProducts = json.decode(response.body);
        print("outputProducts.length = " + outputProducts.length.toString());

        int index = productsByCategory
            .indexWhere((element) => element["id"] == categoryId);

        outputProducts.forEach(
          (element) {
            print("---- let us see ---- ");
            // element.forEach((k, v) {
            //print(k);
            //print(v);
            //});
            //
            try {
              WooProduct wooProduct = WooProduct.fromJson(element);

              tempListForProductsByCategory.add(
                {
                  "vendorId": element["store"]["vendor_id"],
                  "vendorName": element["store"]["vendor_shop_name"],
                  "value": wooProduct,
                },
              );
              productsByCategory[index]["value"] =
                  tempListForProductsByCategory;
            } catch (e) {
              print("--------------An error ---------");
              print(e);
            }
          },
        );

        // increament category page number
        categoryPageNumber += 1;
      }

      return true;
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }

  List<Map<String, dynamic>> getProductsByCategory({String categoryId}) {
    int index =
        productsByCategory.indexWhere((element) => element["id"] == categoryId);

    return [...productsByCategory[index]["value"]];
  }

  Future<String> fetchAndSetProducts({
    @required String pageNumber,
    @required String perPage,
    @required String onSale,
    @required String type,
  }) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return null;
    }

    try {
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));

      String url =
          "https://050saa.com/wp-json/wc/v3/products?page=$pageNumber&per_page=$perPage&on_sale=$onSale";

      final Map<String, String> headerCreate = {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth,
      };

      response = await http.get(
        url,
        headers: headerCreate,
      );
      print("Status Code: " + response.statusCode.toString());

      if (response.statusCode == 200) {
        final outputProducts = json.decode(response.body);
        print("outputProducts.length = " + outputProducts.length.toString());

        outputProducts.forEach(
          (element) {
            try {
              WooProduct wooProduct = WooProduct.fromJson(element);
              // vendor_shop_name
              // vendor_display_name

              if (type == "onSale") {
                onSaleProducts.add(
                  {
                    "vendorId": element["store"]["vendor_id"],
                    "vendorName": element["store"]["vendor_shop_name"],
                    "value": wooProduct,
                  },
                );
              } else if (type == "mostViewd") {
                homePageMostViewedProducts.add(
                  {
                    "vendorId": element["store"]["vendor_id"],
                    "vendorName": element["store"]["vendor_shop_name"],
                    "value": wooProduct,
                  },
                );
              } else if (type == "popular") {
                homePagePopularProducts.add(
                  {
                    "vendorId": element["store"]["vendor_id"],
                    "vendorName": element["store"]["vendor_shop_name"],
                    "value": wooProduct,
                  },
                );
              } else if (type == "souq") {
                homePageSouqProducts.add(
                  {
                    "vendorId": element["store"]["vendor_id"],
                    "vendorName": element["store"]["vendor_shop_name"],
                    "value": wooProduct,
                  },
                );
              }
            } catch (e) {
              print("--------------An error ---------");
              print(e);
            }
          },
        );

        return null;
      } else {
        return null;
      }
    } on SocketException catch (_) {
      return null;
    } catch (e) {
      return null;
    }
  }
}
