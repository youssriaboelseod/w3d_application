import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:provider/provider.dart';
//
import '../../../Providers/OrdersProvider/order_provider.dart';
import 'order_item_card.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  List<WooOrder> ordersList = [];
  Future<void> fetchOrders(BuildContext context) async {
    ordersList =
        await Provider.of<OrdersProvider>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchOrders(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SpinKitChasingDots(
              color: Colors.black,
            ),
          );
        } else {
          return ListView.builder(
            itemCount: ordersList.length,
            itemBuilder: (context, index) {
              return OrderItemCard(
                order: ordersList[index],
                index: index,
              );
            },
          );
        }
      },
    );
  }
}
