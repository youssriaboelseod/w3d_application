import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:url_launcher/url_launcher.dart';
//
import '../../../1MainHelper/Snacks/snackbar.dart';
import '../Functions/Signup_Function.dart';
import '../Functions/validate_inputs.dart';
import '../../Login/Screen/login_screen.dart';
import '../../Signup/Widgets/background.dart';
import '../../Widgets/already_have_an_account_acheck.dart';
import '../../Widgets/rounded_button.dart';
import '../../Widgets/rounded_input_field.dart';
import '../../Widgets/rounded_password_field.dart';
import '../../../Home/Screen/home_screen.dart';
import '../../../1MainHelper/Alerts/alerts.dart';
import '../../../../Models/UserAuthModel/user_auth_model.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  final userNameNode = FocusNode();
  final storeNameNode = FocusNode();
  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  final confirmPasswordNode = FocusNode();

  String userName = "";
  String storeName = "";
  String email = "";
  String password;
  String passwordConfirmation;
  bool _isProcessing = false;

  Future<void> signUp(BuildContext context) async {
    String output;
    FocusScope.of(context).unfocus();
    UserAuthModel userAuthModel = UserAuthModel(
      email: email.trim(),
      password: password,
      userName: storeName.trim(),
      storeName: storeName.trim(),
    );
    // validate user's inputs
    output = validateInputs(
      userAuthModel: userAuthModel,
      passwordConfirmation: passwordConfirmation,
    );
    if (output != null) {
      showAlertNoAction(
        context: context,
        message: output,
      );
      return;
    } else {
      setState(() {
        _isProcessing = true;
      });
      // online sign up
      output = await signUpWithEmailAndPassword(
        context: context,
        userAuthModel: userAuthModel,
      );
      setState(() {
        _isProcessing = false;
      });

      if (output != null) {
        showAlertNoAction(
          context: context,
          message: output,
        );
        return;
      } else {
        showTopSnackBar(
          context: context,
          title: "??????????",
          body: "???? ?????????? ???????????? ??????????",
        );

        await Future.delayed(Duration(milliseconds: 2000));

        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    }
  }

  _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              height: 100,
              width: size.width / 1.2,
              //fit: BoxFit.fill,
            ),
            SizedBox(
              height: 10,
            ),
            RoundedInputField(
              hintText: "?????????? ?????? ???????? ??????????????",
              onChanged: (value) {
                storeName = value;
              },
              icon: Icons.store,
              focusNode: storeNameNode,
              nextFocusNode: emailNode,
            ),
            RoundedInputField(
              hintText: "???????????? ????????????????????",
              textInputType: TextInputType.emailAddress,
              icon: Icons.email,
              onChanged: (value) {
                email = value;
              },
              focusNode: emailNode,
              nextFocusNode: passwordNode,
            ),
            RoundedPasswordField(
              hintText: "???????? ????????????",
              onChanged: (value) {
                password = value;
              },
              focusNode: passwordNode,
              nextFocusNode: confirmPasswordNode,
            ),
            RoundedPasswordField(
              hintText: "?????????? ???????? ????????????",
              onChanged: (value) {
                passwordConfirmation = value;
              },
              focusNode: confirmPasswordNode,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  _openUrl(
                      "https://050saa.com/%D8%B3%D9%8A%D8%A7%D8%B3%D8%A9-%D8%A7%D9%84%D8%AE%D8%B5%D9%88%D8%B5%D9%8A%D8%A9/");
                },
                child: Text(
                  "???????????????? ???????? ?????????? ?????? ?????????? ????????????????",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: Colors.black,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  _openUrl(
                      "https://050saa.com/%D8%B4%D8%B1%D9%88%D8%B7-%D8%A7%D9%84%D8%A5%D8%B3%D8%AA%D8%AE%D8%AF%D8%A7%D9%85/");
                },
                child: Text(
                  "???????? ??????????????????",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: Colors.black,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            _isProcessing
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SpinKitChasingDots(
                          color: Colors.black,
                        ),
                      ],
                    ),
                  )
                : RoundedButton(
                    text: "?????????? ????????",
                    press: () async {
                      await signUp(context);
                    },
                  ),
            _isProcessing
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 8,
                    ),
                    child: AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
