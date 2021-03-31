import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
//
import '../../../Providers/AuthDataProvider/auth_data_provider.dart';
import '../Widgets/drawer_items.dart';

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
              width: 100,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "$name ",
                  textScaleFactor: 1,
                  softWrap: true,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
