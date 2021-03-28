import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:woocommerce/woocommerce.dart';
//
import '../../Order/Screen/order_screen.dart';

class OrderItemCard extends StatelessWidget {
  final WooOrder order;
  final int index;

  const OrderItemCard({
    Key key,
    this.order,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 8,
      ),
      child: Card(
        key: ValueKey(order.id),
        elevation: 5,
        color: Colors.black,
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
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                Container(
                  width: 50,
                  child: FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      (index + 1).toString(),
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 4,
                  ),
                  child: Container(
                    width: 1,
                    height: 75,
                    color: Colors.cyanAccent,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Text(
                        "رقم الطلب  :  " + order.number,
                        softWrap: true,
                        textScaleFactor: 1,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Text(
                        "الاجمالي  :  " + order.total + " ر.س",
                        softWrap: true,
                        textScaleFactor: 1,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Text(
                        "التاريخ  :  " +
                            formatDate(
                              DateTime.parse(order.dateCreated),
                              [yyyy, '-', mm, '-', dd],
                            ),
                        textScaleFactor: 1,
                        softWrap: true,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          fontSize: 18,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => OrderScreen(
                          order: order,
                        ),
                      ),
                    );
                    //
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
