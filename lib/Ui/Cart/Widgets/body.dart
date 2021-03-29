import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w3d/Ui/AddOrder/Screen/add_order_screen.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:woocommerce/woocommerce.dart';
import 'buttons.dart';
import 'cart_item_card.dart';
import '../../../Providers/CartProvider/cart_provider.dart';
import 'price_card.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<WooCartItem> cartItems = [];
  double totalPrice = 0;
  bool _isInit = false;

  bool check = false;

  Future<void> fetchMyCart(BuildContext context) async {
    if (_isInit) {
      return;
    }
    check = await Provider.of<CartProvider>(context, listen: false)
        .fetchCartProducts(
      context: context,
    );
    cartItems =
        Provider.of<CartProvider>(context, listen: false).getCartItems();

    _isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchMyCart(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.black,
              ),
            ),
          );
        } else {
          if (!check) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.refresh_outlined,
                        size: 40,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        setState(() {
                          _isInit = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "السلة فارغة",
                      textScaleFactor: 1,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Consumer<CartProvider>(
            builder: (context, value, child) {
              cartItems = value.cartItems;
              totalPrice = 0;
              cartItems.forEach((element) {
                String valueModified = "0";
                valueModified = element.linePrice.replaceAll("ر.س", "");

                if (valueModified != null) {
                  totalPrice += double.tryParse(valueModified);
                }
              });
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItemCard(
                          cartItem: cartItems[index],
                        );
                      },
                    ),
                  ),
                  PriceCard(
                    totalPrice: totalPrice.toString(),
                  ),
                  Button(
                    backgroundColor: Colors.black,
                    title: "التقدم لاتمام الطلب",
                    textColor: Colors.white,
                    function: () async {
                      Navigator.of(context).pushNamed(
                        AddOrderScreen.routeName,
                      );
                    },
                    iconData: Icons.fact_check_rounded,
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
