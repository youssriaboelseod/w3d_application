import 'package:flutter/material.dart';
import '../../Login/Screen/login_screen.dart';
import '../../../Home/Screen/home_screen.dart';
import '../../Login_Or_Signup/Widgets/background.dart';
import '../../Widgets/rounded_button.dart';
import '../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/signup.png",
              height: size.height * 0.5,
            ),
            RoundedButton(
              text: "تسجيل الدخول",
              color: kPrimaryLightColor,
              press: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
            ),
            RoundedButton(
              text: "متابعة بدون تسجيل",
              press: () {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
