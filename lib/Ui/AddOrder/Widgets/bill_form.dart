import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/cart_item.dart';
//
import '../../../Providers/CartProvider/cart_provider.dart';
import 'price_card.dart';

class BillForm extends StatelessWidget {
  List<WooCartItem> cartItems = [];
  double totalPrice = 0;
  double delivery = 29;

  @override
  Widget build(BuildContext context) {
    cartItems =
        Provider.of<CartProvider>(context, listen: false).getCartItems();
    cartItems.forEach((element) {
      String valueModified = element.linePrice.replaceAll("ر.س", "");
      totalPrice += double.parse(valueModified);
    });
    return Container(
      child: Card(
        elevation: 2,
        color: Colors.grey[200],
        margin: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 4,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CartItemDetails(
                        cartItem: cartItems[index],
                        index: index + 1,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ],
                  );
                },
              ),
              PriceCard(
                title: "المجموع",
                totalPrice: totalPrice.toString(),
              ),
              totalPrice >= 150
                  ? Container()
                  : Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
              totalPrice >= 150
                  ? Container()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PriceCard(
                          title: "الشحن",
                          totalPrice: "29",
                        ),
                        const Text(
                          "تنويه : تضاف قيمة الشحن للمنتجات اقل من 150 ريال سعودي",
                          overflow: TextOverflow.fade,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize: 17,
                            color: Colors.red,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              PriceCard(
                title: "الاجمالي",
                totalPrice: totalPrice >= 150
                    ? totalPrice.toString()
                    : (totalPrice + delivery).toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItemDetails extends StatelessWidget {
  final WooCartItem cartItem;
  final int index;

  const CartItemDetails({Key key, this.cartItem, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //String valueModified = value.replaceAll("ر.س", "");
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.end,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                index.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            width: size.width > 320 ? 160 : 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.name ?? "",
                  textScaleFactor: 1,
                  overflow: TextOverflow.fade,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
                Text(
                  cartItem.quantity.toString() + "x",
                  textScaleFactor: 1,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontSize: 17,
                    color: Colors.black,
                  ),
                  softWrap: true,
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: 90,
            child: Text(
              cartItem.linePrice.replaceAll("ر.س", "") + " ر.س",
              textScaleFactor: 1,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
