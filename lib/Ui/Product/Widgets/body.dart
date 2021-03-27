import 'package:flutter/material.dart';
import 'package:w3d/Ui/Product/Widgets/options_button.dart';
import 'package:woocommerce/models/products.dart';
import 'description_card.dart';
import 'package:provider/provider.dart';
import '../../../Providers/CartProvider/cart_provider.dart';
import '../../../Models/Cart/cart_model.dart';
import '../../1MainHelper/Snacks/snackbar.dart';
import '../Functions/add_to_cart.dart';
import '../../../Models/Product/product_model.dart';
import 'order_button.dart';
import 'options_card.dart';
import '../../1MainHelper/Helpers/helper.dart';
import 'image_switcher_card.dart';

import 'add_to_cart_button.dart';
import '../Widgets/quantity_card.dart';
import '../../../Providers/AuthDataProvider/auth_data_provider.dart';

import '../Widgets/title_card.dart';

import '../../1MainHelper/Helpers/helper.dart';
import 'contact_button.dart';
import '../Functions/order_now.dart';

class Body extends StatefulWidget {
  final WooProduct productModel;

  const Body({Key key, this.productModel}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedQuantityValue = 1;
  String selectedPaperSize = "S";

  String attributePaColor = ""; // id = 7
  String attributePaSex = ""; // id = 6
  String attributePaSize = ""; // id = 5
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> addToCartFunction() async {
    if (_isLoading) {
      return;
    }
    bool checkIfSignedIn =
        Provider.of<AuthDataProvider>(context, listen: false).checkIfSignedIn();
    if (!checkIfSignedIn) {
      showTopSnackBar(
        context: context,
        body: "من فضلك قم بالتسجيل اولا",
        title: "تنبيه",
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    bool check = await Provider.of<CartProvider>(context, listen: false)
        .addProductToCart(
      productId: widget.productModel.id.toString(),
      quantity: selectedQuantityValue.toString(),
      attributePaColor:
          attributePaColor.isNotEmpty ? getColorKey(attributePaColor) : "",
      attributePaSex: attributePaSex == "نسائي" ? "female" : "male",
      attributePaSize: attributePaSize.toLowerCase(),
    );
    setState(() {
      _isLoading = false;
    });
    if (check) {
      showTopSnackBar(
        context: context,
        body: "تم اضافة المنتج الى سلة المشتريات",
        title: "رائع",
      );
    } else {
      showTopSnackBar(
        context: context,
        body: "لقد حدث خطأ من فضلك حاول مرة اخرة",
        title: "تنبيه",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print("--------- My product Data -----------");
    print(widget.productModel.id);
    print("--------- That is it -----------");
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  ImageSwitcherCard(
                    product: widget.productModel,
                  ),
                  Positioned(
                    top: 15,
                    left: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TitleCard(
                    productModel: widget.productModel,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ...widget.productModel.attributes.map((e) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OptionsButton(
                          options: e.options,
                          productModel: widget.productModel,
                          onChangeValue: (value) {
                            if (e.name == "اللون") {
                              attributePaColor = value;
                            } else if (e.name == "الفئة") {
                              attributePaSex = value;
                            } else {
                              attributePaSize = value;
                            }
                          },
                          title: e.name,
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                      ],
                    );
                  }),
                  DescriptionCard(
                    title: "الوصف",
                    productModel: widget.productModel,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  QuantityCard(
                    onChangeValue: (value) {
                      selectedQuantityValue = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          _isLoading
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.black,
                    ),
                  ),
                )
              : widget.productModel.type == "external"
                  ? ContactButton(
                      product: widget.productModel,
                    )
                  : AddToCartButton(
                      function: addToCartFunction,
                    ),
        ],
      ),
    );
  }
}
