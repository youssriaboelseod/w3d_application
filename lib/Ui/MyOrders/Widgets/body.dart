import 'package:flutter/material.dart';
import 'package:w3d/Providers/OrdersProvider/order_provider.dart';
import 'package:w3d/Ui/MyOrders/Widgets/order_item_card.dart';
import 'package:woocommerce/models/order_payload.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:provider/provider.dart';

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
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.black,
              ),
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
