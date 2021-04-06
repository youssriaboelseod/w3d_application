import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//
import '../../Authentication/Login_Or_Signup/Screen/login_or_signup_screen.dart';
import '../../Home/Screen/home_screen.dart';
import '../Functions/start_app.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  Future<void> futureFn(BuildContext context) async {
    // state = null --> we will fetch data
    // state = false --> we don't need to fetch data

    bool checkSignedIn;
    checkSignedIn = await startApp(context);

    if (checkSignedIn) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      // if not signed in
      Navigator.of(context).pushReplacementNamed(LoginOrSignupScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "مرحبا بك في الواعد",
              textScaleFactor: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/images/signup.png",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            FutureBuilder(
              future: futureFn(context),
              builder: (fbctx, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SpinKitChasingDots(
                      color: Colors.black,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
