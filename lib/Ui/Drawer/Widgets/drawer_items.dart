import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../Favourites/Screen/favourites_screen.dart';
import '../../1MainHelper/Snacks/snackbar.dart';
import '../../Authentication/Login_Or_Signup/Screen/login_or_signup_screen.dart';
import '../../MyOrders/Screen/my_orders_screen.dart';
import '../../../Providers/AuthDataProvider/auth_data_provider.dart';
import '../../../Ui/Profile/Screen/profile_screen.dart';
import '../../StartApp/Screen/start_app_screen.dart';
import '../../PaymentMethods/Screen/payment_methods_screen.dart';
import '../../Design/Screen/design_screen.dart';
import '../../OrderDesign/Screen/order_design_screen.dart';
import 'package:provider/provider.dart';
import '../Functions/drawer_functions.dart';

class DrawerItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double _fontSize = getFontSize(width);
    bool checkIfSignedIn =
        Provider.of<AuthDataProvider>(context, listen: false).checkIfSignedIn();
    final _heigth = MediaQuery.of(context).size.height - 180;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: Container(
            height: _heigth,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      FlatButton.icon(
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        label: Text(
                          "حسابي",
                          style: TextStyle(
                            fontSize: _fontSize,
                            color: Colors.white,
                          ),
                          textScaleFactor: 1,
                        ),
                        onPressed: () {
                          if (!checkIfSignedIn) {
                            showTopSnackBar(
                              context: context,
                              body: "من فضلك قم بالتسجيل اولا",
                              title: "تنبيه",
                            );
                            return;
                          }
                          Navigator.of(context)
                              .pushNamed(ProfileScreen.routeName);
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.black38,
                    indent: 15,
                    endIndent: 60,
                  ),
                  Row(
                    children: [
                      FlatButton.icon(
                        icon: const Icon(
                          Icons.payment,
                          color: Colors.white,
                        ),
                        label: Text(
                          "طلباتي",
                          style: TextStyle(
                            fontSize: _fontSize,
                            color: Colors.white,
                          ),
                          textScaleFactor: 1,
                        ),
                        onPressed: () {
                          if (!checkIfSignedIn) {
                            showTopSnackBar(
                              context: context,
                              body: "من فضلك قم بالتسجيل اولا",
                              title: "تنبيه",
                            );
                            return;
                          }
                          Navigator.of(context)
                              .pushNamed(MyOrdersScreen.routeName);
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.black38,
                    indent: 15,
                    endIndent: 60,
                  ),
                  Row(
                    children: [
                      FlatButton.icon(
                        icon: const Icon(
                          Icons.payments_outlined,
                          color: Colors.white,
                        ),
                        label: Text(
                          "طرق الدفع",
                          style: TextStyle(
                            fontSize: _fontSize,
                            color: Colors.white,
                          ),
                          textScaleFactor: 1,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(PaymentMethodsScreen.routeName);
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.black38,
                    indent: 15,
                    endIndent: 60,
                  ),
                  Row(
                    children: [
                      FlatButton.icon(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                        label: Text(
                          "المفضلة",
                          style: TextStyle(
                            fontSize: _fontSize,
                            color: Colors.white,
                          ),
                          textScaleFactor: 1,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(FavouritesScreen.routeName);
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.black38,
                    indent: 15,
                    endIndent: 60,
                  ),
                  Row(
                    children: [
                      FlatButton.icon(
                        icon: const Icon(
                          Icons.design_services,
                          color: Colors.white,
                        ),
                        label: Text(
                          "صمم",
                          style: TextStyle(
                            fontSize: _fontSize,
                            color: Colors.white,
                          ),
                          textScaleFactor: 1,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(DesignScreen.routeName);
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.black38,
                    indent: 15,
                    endIndent: 60,
                  ),
                  Row(
                    children: [
                      FlatButton.icon(
                        icon: const Icon(
                          Icons.design_services,
                          color: Colors.white,
                        ),
                        label: Text(
                          "اطلب تصميمك الخاص",
                          style: TextStyle(
                            fontSize: _fontSize,
                            color: Colors.white,
                          ),
                          textScaleFactor: 1,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(OrderDesignScreen.routeName);
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.black38,
                    indent: 15,
                    endIndent: 60,
                  ),
                  Row(
                    children: [
                      FlatButton.icon(
                        icon: const Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                        label: Text(
                          "تواصل معانا",
                          style: TextStyle(
                            fontSize: _fontSize,
                            color: Colors.white,
                          ),
                          textScaleFactor: 1,
                        ),
                        onPressed: () {
                          showContact(context);
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.black38,
                    indent: 15,
                    endIndent: 60,
                  ),
                  Row(
                    children: [
                      FlatButton.icon(
                        icon: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        label: Text(
                          "مشاركة التطبيق",
                          style: TextStyle(
                            fontSize: _fontSize,
                            color: Colors.white,
                          ),
                          textScaleFactor: 1,
                        ),
                        onPressed: () {
                          shareApp();
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.black38,
                    indent: 15,
                    endIndent: 60,
                  ),
                  !checkIfSignedIn
                      ? Row(
                          children: [
                            FlatButton.icon(
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              label: Text(
                                "تسجيل الدخول",
                                style: TextStyle(
                                  fontSize: _fontSize,
                                  color: Colors.white,
                                ),
                                textScaleFactor: 1,
                              ),
                              onPressed: () async {
                                Navigator.of(context).pushNamed(
                                  LoginOrSignupScreen.routeName,
                                );
                              },
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            FlatButton.icon(
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              label: Text(
                                "تسجيل الخروج",
                                style: TextStyle(
                                  fontSize: _fontSize,
                                  color: Colors.white,
                                ),
                                textScaleFactor: 1,
                              ),
                              onPressed: () async {
                                await Provider.of<AuthDataProvider>(context,
                                        listen: false)
                                    .clearAuthDataTable();

                                while (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                                // state = true --> we will fetch data
                                // state = false --> we don't need to fetch data
                                Navigator.of(context).pushReplacement(
                                  new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new StartAppScreen(
                                      state: false,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            Divider(
              thickness: 3,
              color: Colors.black38,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "MT-Adawy Group",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CupertinoColors.systemTeal,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textScaleFactor: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
