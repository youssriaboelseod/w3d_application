import '../../../Providers/AuthDataProvider/auth_data_provider.dart';
import 'package:provider/provider.dart';

import '../Widgets/drawer_items.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DrawerApp extends StatelessWidget {
  String name;
  @override
  Widget build(BuildContext context) {
    name = Provider.of<AuthDataProvider>(context, listen: false)
        .currentUser
        .userName;

    return Drawer(
      elevation: 10,
      child: Container(
        color: Colors.grey[800],
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 35,
                bottom: 10,
              ),
              child: Text(
                "$name ",
                textScaleFactor: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: DrawerItems(),
            ),
          ],
        ),
      ),
    );
  }
}
