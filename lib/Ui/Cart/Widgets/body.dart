import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w3d/Ui/AddOrder/Screen/add_order_screen.dart';
import 'package:w3d/Ui/Cart/Functions/order_now.dart';
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
        .fetchCartProducts();
    cartItems =
        Provider.of<CartProvider>(context, listen: false).getCartItems();
    cartItems.forEach((element) {
      String valueModified = element.linePrice.replaceAll("ر.س", "");
      totalPrice += double.parse(valueModified);
    });
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
              child: IconButton(
                icon: Icon(
                  Icons.refresh,
                  size: 40,
                  color: Colors.black,
                ),
                onPressed: () async {
                  setState(() {
                    _isInit = false;
                  });
                },
              ),
            );
          }
          return Column(
            children: [
              Consumer<CartProvider>(
                builder: (context, value, child) {
                  cartItems = value.cartItems;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItemCard(
                          cartItem: cartItems[index],
                        );
                      },
                    ),
                  );
                },
              ),
              PriceCard(
                totalPrice: totalPrice.toString(),
              ),
              Button(
                backgroundColor: Color(0xFF345757),
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
        }
      },
    );
  }
}
