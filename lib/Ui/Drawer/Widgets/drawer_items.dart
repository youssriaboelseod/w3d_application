import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
import '../../Sales/Screen/sales_products_screen.dart';
//
import '../../Favourites/Screen/favourites_screen.dart';
import '../../1MainHelper/Snacks/snackbar.dart';
import '../../Authentication/Login_Or_Signup/Screen/login_or_signup_screen.dart';
import '../../MyOrders/Screen/my_orders_screen.dart';
import '../../../Providers/AuthDataProvider/auth_data_provider.dart';
import '../../../Ui/Profile/Screen/profile_screen.dart';
import '../../PaymentMethods/Screen/payment_methods_screen.dart';
import '../../../Providers/CartProvider/cart_provider.dart';
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
                          textScaleFactor: 1,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize: _fontSize,
                            color: Colors.white,
                          ),
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
                        icon: Image.asset(
                          "assets/icons/sale.png",
                          fit: BoxFit.contain,
                        ),
                        label: Text(
                          "العروض",
                          textScaleFactor: 1,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize: _fontSize,
                            color: Color(0xFFf1c40f),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SalesProductsScreen.routeName);
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
                          textScaleFactor: 1,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize: _fontSize,
                            color: Colors.white,
                          ),
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
                          textScaleFactor: 1,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize: _fontSize,
                            color: Colors.white,
                          ),
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
                          textScaleFactor: 1,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize: _fontSize,
                            color: Colors.white,
                          ),
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
                          Icons.language,
                          color: Colors.white,
                        ),
                        label: Text(
                          "تواصل معانا",
                          textScaleFactor: 1,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize: _fontSize,
                            color: Colors.white,
                          ),
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
                          Icons.info,
                          color: Colors.white,
                        ),
                        label: Text(
                          "عن الواعد",
                          textScaleFactor: 1,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize: _fontSize,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          showAboutW3d(context);
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
                          textScaleFactor: 1,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize: _fontSize,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          shareAppDialog(context);
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
                                textScaleFactor: 1,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  fontSize: _fontSize,
                                  color: Colors.white,
                                ),
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
                                textScaleFactor: 1,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  fontSize: _fontSize,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                await Provider.of<AuthDataProvider>(context,
                                        listen: false)
                                    .clearAuthDataTable();
                                await Provider.of<CartProvider>(context,
                                        listen: false)
                                    .clearCart();

                                while (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                                // state = true --> we will fetch data
                                // state = false --> we don't need to fetch data
                                Navigator.of(context).pushReplacementNamed(
                                  LoginOrSignupScreen.routeName,
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
                "www.050saa.com",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
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
