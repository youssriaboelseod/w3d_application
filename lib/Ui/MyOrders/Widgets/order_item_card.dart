import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/order_payload.dart';
import 'package:woocommerce/woocommerce.dart';

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
        color: Color(0xFF140035),
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
                      index.toString(),
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 4,
                    right: 12,
                  ),
                  child: Container(
                    width: 1,
                    height: 70,
                    color: Colors.blueAccent,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 2,
                      ),
                      child: Container(
                        child: Text(
                          order.number,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textScaleFactor: 1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Container(
                        width: 140,
                        child: Text(
                          "الاجمالي" + order.total,
                          softWrap: true,
                          textScaleFactor: 1,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.amberAccent,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Text(
                        "التاريخ : " + order.dateCreated,
                        textScaleFactor: 1,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());

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
