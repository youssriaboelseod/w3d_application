import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/order.dart';
//
import 'price_card.dart';
import '../../../Providers/ProductsProvider/products_provider.dart';
import '../../1MainHelper/Alerts/alerts.dart';
import '../../1MainHelper/Snacks/snackbar.dart';
import '../../Product/Screen/product_screen.dart';

// ignore: must_be_immutable
class OrderForm extends StatelessWidget {
  final WooOrder order;

  OrderForm({Key key, this.order}) : super(key: key);

  List<LineItems> orderItems = [];
  double totalPrice = 0;
  double delivery = 29;

  @override
  Widget build(BuildContext context) {
    orderItems = order.lineItems;
    orderItems.forEach((element) {
      totalPrice = totalPrice + double.parse(element.total);
    });
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ...List.generate(
              orderItems.length,
              (index) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OrderItemDetails(
                    orderItem: orderItems[index],
                    index: index + 1,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
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
                : PriceCard(
                    title: "الشحن",
                    totalPrice: "29",
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
    );
  }
}

// ignore: must_be_immutable
class OrderItemDetails extends StatelessWidget {
  final LineItems orderItem;
  final int index;

  OrderItemDetails({Key key, this.orderItem, this.index}) : super(key: key);
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //String valueModified = value.replaceAll("ر.س", "");
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
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
          GestureDetector(
            onTap: () async {
              if (_isLoading) {
                return;
              }
              _isLoading = true;
              showTopSnackBar(
                context: context,
                title: "انتظر لحظات",
                body: "جاري تحميل صفحة المنتج",
              );
              int productId = orderItem.productId;
              Map<String, dynamic> productMap =
                  await Provider.of<ProductsProvider>(context, listen: false)
                      .getProductById(productId);
              _isLoading = false;

              if (productMap == null) {
                showAlertNoAction(
                  context: context,
                  message: "لايوجد لديك انترنت",
                );
                return;
              } else {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new ProductScreen(
                      productMap: productMap,
                    ),
                  ),
                );
              }
            },
            child: Container(
              width: size.width > 320 ? 160 : 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderItem.name ?? "",
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
                    orderItem.quantity.toString() + "x",
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
          ),
          Spacer(),
          Container(
            width: 90,
            child: Text(
              orderItem.total.replaceAll("ر.س", "") + " ر.س",
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
