import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
//
import '../../../1MainHelper/Snacks/snackbar.dart';
import '../../../Home/Screen/home_screen.dart';
import '../Functions/Login_Function.dart';
import '../Functions/validate_inputs.dart';
import '../../Login/Widgets/background.dart';
import '../../Signup/Screen/signup_screen.dart';
import '../../Widgets/already_have_an_account_acheck.dart';
import '../../Widgets/rounded_button.dart';
import '../../Widgets/rounded_input_field.dart';
import '../../Widgets/rounded_password_field.dart';
import '../Functions/reset_password.dart';
import '../../../../Models/UserAuthModel/user_auth_model.dart';
import '../../../1MainHelper/Alerts/alerts.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  final emailNode = FocusNode();
  final passwordNode = FocusNode();

  String email = "";
  String password;
  bool _isProcessing = false;
  bool _isForgotPassword = false;

  Future<void> login(BuildContext context) async {
    UserAuthModel userAuthModel = UserAuthModel(
      email: email.trim(),
      password: password,
    );

    String output;
    FocusScope.of(context).unfocus();
    // validate user's inputs
    output = validateInputs(
      userAuthModel: userAuthModel,
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
      output = await loginWithEmailAndPassword(
        userAuthModel: userAuthModel,
        context: context,
      );

      if (output != null) {
        if (output == "الباسورد غير صحيح") {
          _isForgotPassword = true;
        }
        setState(() {
          _isProcessing = false;
        });
        showAlertNoAction(
          context: context,
          message: output,
        );
        return;
      } else {
        showTopSnackBar(
          context: context,
          title: "رائع",
          body: "تم تسجيل الدخول بنجاح",
        );
        await Future.delayed(
          Duration(seconds: 2),
        );

        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
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
              "assets/images/login.png",
              height: 220,
              width: size.width / 1.5,
              fit: BoxFit.fill,
            ),
            RoundedInputField(
              hintText: "اسم المستخدم او البريد الالكتروني",
              icon: Icons.person,
              textInputType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
              focusNode: emailNode,
              nextFocusNode: passwordNode,
            ),
            RoundedPasswordField(
              hintText: "كلمة المرور",
              onChanged: (value) {
                password = value;
              },
              focusNode: passwordNode,
            ),
            _isProcessing
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                    ),
                  )
                : RoundedButton(
                    text: "تسجيل الدخول",
                    press: () async {
                      await login(context);
                    },
                  ),
            _isForgotPassword
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        contactToResetPassword(email);
                      },
                      child: Text(
                        "هل نسيت كلمة المرور ؟",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        textScaleFactor: 1,
                        style: TextStyle(
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          color: Colors.grey,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            _isProcessing
                ? Container()
                : AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.of(context)
                          .pushReplacementNamed(SignupScreen.routeName);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
