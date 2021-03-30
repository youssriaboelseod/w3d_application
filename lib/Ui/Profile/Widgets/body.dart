import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

import '../../../Providers/AuthDataProvider/auth_data_provider.dart';
import '../../Authentication/Phone/Screen/add_phone_number_screen.dart';

import 'profile_item_card.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Top(),
        Bottom(),
      ],
    );
  }
}

class Bottom extends StatelessWidget {
  String name;
  String email;
  String phoneNumber;

  //
  bool readOnly = true;

  @override
  Widget build(BuildContext context) {
    name = Provider.of<AuthDataProvider>(context, listen: false)
        .currentUser
        .userName;
    email =
        Provider.of<AuthDataProvider>(context, listen: false).currentUser.email;
    phoneNumber = Provider.of<AuthDataProvider>(context, listen: false)
        .currentUser
        .phoneNumber;

    return Expanded(
      child: Container(
        color: Color(0xffecf0f0),
        child: ListView(
          padding: EdgeInsets.all(
            10,
          ),
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                color: Color(0xffb3c4c4),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8,
                    left: 8,
                    right: 8,
                  ),
                  child: ProfileItemCard(
                    initialText: name,
                    function: null,
                    prefixIcon: Icons.person,
                    title: "الاسم",
                  ),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                color: Color(0xffb3c4c4),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8,
                    left: 8,
                    right: 8,
                  ),
                  child: ProfileItemCard(
                    initialText: email,
                    function: null,
                    prefixIcon: Icons.email,
                    title: "البريد",
                  ),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                color: Color(0xffb3c4c4),
                child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8,
                      left: 8,
                      right: 8,
                    ),
                    child: Consumer<AuthDataProvider>(
                      builder: (context, value, child) {
                        phoneNumber = value.currentUser.phoneNumber;
                        return phoneNumber.isNotEmpty
                            ? ProfileItemCard(
                                initialText: phoneNumber,
                                function: () {
                                  Navigator.of(context).pushNamed(
                                      AddPhoneNumberScreen.routeName);
                                },
                                prefixIcon: Icons.call,
                                title: "الهاتف",
                              )
                            : FlatButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      AddPhoneNumberScreen.routeName);
                                },
                                icon: Icon(
                                  Icons.add_circle,
                                  size: 30,
                                ),
                                label: Text(
                                  "أضف رقم الهاتف",
                                  textScaleFactor: 1,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontFamily: ArabicFonts.Cairo,
                                    package: 'google_fonts_arabic',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                      },
                    )),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Top extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return Column(
      children: [
        Container(
          height: 130,
          child: Stack(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(width),
                    bottomRight: Radius.circular(width),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      radius: 56.0,
                      backgroundImage: AssetImage(
                        "assets/images/logo.png",
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Consumer<AuthDataProvider>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value.currentUser.userName,
                textScaleFactor: 1,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
