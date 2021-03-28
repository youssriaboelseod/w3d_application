import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';
import 'dart:math';

class ProductsProvider with ChangeNotifier {
  Random random = new Random();

  WooCommerce woocommerce = WooCommerce(
    baseUrl: "https://050saa.com",
    consumerKey: "ck_da5c9ea679814a228bcd5cda0c3c1b932c98ff1d",
    consumerSecret: "cs_aa9486fe01e314e72b5b2d50ae109c84a682f749",
  );

  List<WooProduct> onSaleProducts = [];
  List<WooProduct> homePageSouqProducts = [];
  List<WooProduct> homePageMostViewedProducts = [];
  List<WooProduct> homePagePopularProducts = [];
  List<WooProduct> vendorProducts = [];
  int categoryPageNumber = 1;
  int vendorPageNumber = 1;
  int pageNumber = 1;

  List<Map<String, dynamic>> productsByCategory = [
    {
      "id": "0",
      "value": <WooProduct>[],
    },
    {
      "id": "154",
      "value": <WooProduct>[],
    },
    {
      "id": "198",
      "value": <WooProduct>[],
    },
    {
      "id": "152",
      "value": <WooProduct>[],
    },
    {
      "id": "151",
      "value": <WooProduct>[],
    },
    {
      "id": "149",
      "value": <WooProduct>[],
    },
  ];

  Future<bool> checkInternetConnection() async {
    try {
      await InternetAddress.lookup('google.com');
      //Nothing to do --> continue in code
    } on SocketException catch (_) {
      return false;
    }
    return true;
  }

  Future<WooCustomer> getSellerName(
      {int productId, BuildContext context}) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return null;
    }
    try {
      String sellerId = await getVendorIdOfProduct(
        context: context,
        productId: productId,
      );
      WooCustomer vendorOfProduct = await woocommerce.getCustomerById(
        id: int.parse(sellerId),
      );

      return vendorOfProduct;
    } on SocketException catch (_) {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String> fetchAndSetProductsForHomePage() async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return "No internet connection!";
    }

    try {
      print("........ fetching products .......");
      List<WooProduct> fetchedProducts = [];
      int randomNumber = 1;
      // reset everything on starting app , to make sure everything is going as i want
      onSaleProducts.clear();
      homePageSouqProducts.clear();
      homePagePopularProducts.clear();
      homePageMostViewedProducts.clear();

      //---------------------------------------------------------
      // Home page --> most viewd
      randomNumber = random.nextInt(5);
      if (randomNumber == 0) {
        randomNumber += 1;
      }
      print("My random number = " + randomNumber.toString());
      fetchedProducts = await woocommerce.getProducts(
        page: randomNumber,
        perPage: 6,
        onSale: false,
        category: "152",
      );
      homePageMostViewedProducts.addAll(
        fetchedProducts.getRange(0, (fetchedProducts.length / 2).round()),
      );

      //---------------------------------------------------------
      // Home page --> Souq
      homePageSouqProducts.addAll(
        fetchedProducts.getRange(
            (fetchedProducts.length / 2).round(), fetchedProducts.length),
      );

      //---------------------------------------------------------
      randomNumber = random.nextInt(5);
      if (randomNumber == 0) {
        randomNumber += 1;
      }
      print("My random number = " + randomNumber.toString());
      fetchedProducts = await woocommerce.getProducts(
        page: randomNumber,
        perPage: 6,
        onSale: false,
        category: "149",
      );
      homePageMostViewedProducts.addAll(
        fetchedProducts.getRange(0, (fetchedProducts.length / 2).round()),
      );
      //---------------------------------------------------------
      // Home page --> Souq
      homePageSouqProducts.addAll(
        fetchedProducts.getRange(
            (fetchedProducts.length / 2).round(), fetchedProducts.length),
      );

      //---------------------------------------------------------
      //---------------------------------------------------------
      // Home page --> popular
      randomNumber = random.nextInt(5);
      if (randomNumber == 0) {
        randomNumber += 1;
      }
      print("My random number = " + randomNumber.toString());
      fetchedProducts = await woocommerce.getProducts(
        page: randomNumber,
        perPage: 4,
        onSale: false,
        category: "151",
      );
      homePagePopularProducts.addAll(
        fetchedProducts.getRange(0, (fetchedProducts.length / 2).round()),
      );
      //---------------------------------------------------------
      // Home page --> Souq
      homePageSouqProducts.addAll(
        fetchedProducts.getRange(
            (fetchedProducts.length / 2).round(), fetchedProducts.length),
      );
      //---------------------------------------------------------
      randomNumber = random.nextInt(5);
      if (randomNumber == 0) {
        randomNumber += 1;
      }
      print("My random number = " + randomNumber.toString());
      fetchedProducts = await woocommerce.getProducts(
        page: randomNumber,
        perPage: 4,
        onSale: false,
        category: "198",
      );
      homePagePopularProducts.addAll(
        fetchedProducts.getRange(0, (fetchedProducts.length / 2).round()),
      );
      //---------------------------------------------------------
      // Home page --> Souq
      homePageSouqProducts.addAll(
        fetchedProducts.getRange(
            (fetchedProducts.length / 2).round(), fetchedProducts.length),
      );
      //---------------------------------------------------------
      randomNumber = random.nextInt(5);
      if (randomNumber == 0) {
        randomNumber += 1;
      }
      print("My random number = " + randomNumber.toString());
      fetchedProducts = await woocommerce.getProducts(
        page: randomNumber,
        perPage: 4,
        onSale: false,
        category: "154",
      );
      homePagePopularProducts.addAll(
        fetchedProducts.getRange(0, (fetchedProducts.length / 2).round()),
      );
      //---------------------------------------------------------
      // Home page --> Souq
      homePageSouqProducts.addAll(
        fetchedProducts.getRange(
            (fetchedProducts.length / 2).round(), fetchedProducts.length),
      );
      //---------------------------------------------------------

      //---------------------------------------------------------
      // Home page --> on sale products
      randomNumber = random.nextInt(5);
      if (randomNumber == 0) {
        randomNumber += 1;
      }
      print("My random number = " + randomNumber.toString());
      fetchedProducts = await woocommerce.getProducts(
        onSale: true,
        perPage: 10,
        page: randomNumber,
      );
      onSaleProducts.addAll(fetchedProducts);

      // removeRepeatedProductsFromOnSaleProducts();
      return null;
    } on SocketException catch (_) {
      return "No internet connection!";
    } catch (e) {
      return "Database problem";
    }
  }

  void removeRepeatedProductsFromOnSaleProducts() {
    homePageSouqProducts.forEach((e) {
      int index = onSaleProducts.indexWhere((element) => element.id == e.id);
      if (index != -1) {
        onSaleProducts.removeAt(index);
      }
    });
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
      List<String> productIds = [];
      productIds.clear();

      //var test = await
      final response = await http.get(
        "https://050saa.com/wp-json/wcfmmp/v1/store-vendors/$vendroId/products?page=$vendorPageNumber",
      );

      if (response.statusCode == 200) {
        vendorPageNumber += 1;
        var ouputData = json.decode(response.body);

        ouputData.forEach((element) {
          productIds.add(element["id"].toString());
        });

        int counter = 0;
        while (counter < productIds.length) {
          WooProduct fetchedProduct = await getProductById(
            int.parse(
              productIds[counter],
            ),
          );
          counter += 1;
          if (fetchedProduct != null) {
            vendorProducts.add(fetchedProduct);
          }
        }
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

  Future<WooProduct> getProductById(int productId) async {
    WooProduct fetchedProduct;
    try {
      fetchedProduct = await woocommerce.getProductById(
        id: productId,
      );
    } on SocketException catch (_) {
      return null;
    } catch (e) {
      return null;
    }
    return fetchedProduct;
  }

  Future<List<WooProduct>> getProductByName(String searchValue) async {
    try {
      List<WooProduct> fetchedProductsList = [];
      fetchedProductsList = await woocommerce.getProducts(
        search: searchValue,
        perPage: 100,
      );
      return fetchedProductsList;
    } on SocketException catch (_) {
      return [];
    } catch (e) {
      return [];
    }
  }

  void resetVendorProducts() {
    vendorPageNumber = 1;
    vendorProducts.clear();
  }

  void removeProductById({int productId}) {
    int index;
    index = vendorProducts.indexWhere((element) => element.id == productId);
    if (index != -1) {
      vendorProducts.removeAt(index);
    }
    productsByCategory.forEach((element) {
      index = element["value"].indexWhere((element) => element.id == productId);
      if (index != -1) {
        element["value"].removeAt(index);
      }
    });
    notifyListeners();
  }

  Future<void> fetchProductsByCategory(
      {String categoryId, bool resetCategoryPageNumber}) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return false;
    }

    try {
      // if category id = 0 --> this mean we want all products
      if (categoryId == "0" && resetCategoryPageNumber) {
        categoryPageNumber = 1;
        return;
      }
      // if category id = 00 == this mean we want all products
      else if (categoryId == "0" && !resetCategoryPageNumber) {
        await fetchProductsByPage();
        return;
      }

      // reset category page number only when switching between categories
      if (resetCategoryPageNumber) {
        categoryPageNumber = 1;
        int index = productsByCategory
            .indexWhere((element) => element["id"] == categoryId);
        productsByCategory[index]["value"].clear();
      }

      List<WooProduct> fetchedProducts = [];
      fetchedProducts = await woocommerce.getProducts(
        category: categoryId,
        page: categoryPageNumber,
      );

      // increament category page number
      categoryPageNumber += 1;

      int index = productsByCategory
          .indexWhere((element) => element["id"] == categoryId);

      productsByCategory[index]["value"].addAll(fetchedProducts);

      return true;
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }

  List<WooProduct> getProductsByCategory({String categoryId}) {
    int index =
        productsByCategory.indexWhere((element) => element["id"] == categoryId);

    return [...productsByCategory[index]["value"]];
  }

  Future<String> getVendorIdOfProduct(
      {int productId, BuildContext context}) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return null;
    }

    try {
      http.Response response;

      String username = "auth@gmail.com";
      String password = "ASD123456zxc#";

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

        return outputProduct["post_author"];
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
