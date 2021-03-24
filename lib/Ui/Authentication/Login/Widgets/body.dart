import 'package:flutter/material.dart';
import 'package:w3d/Ui/1MainHelper/Snacks/snackbar.dart';
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
  bool _enableResetPassword = false;

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

  Future<void> resetPassword() async {
    // Remove spaces
    email = email.trim();

    String output;
    FocusScope.of(context).unfocus();
    // validate user's inputs
    output = validateEmail(
      email: email,
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
      output = await resetPasswordFn(
        email: email,
      );
      if (output != null) {
        showAlertNoAction(
          context: context,
          message: output,
        );
        return;
      } else {
        setState(() {
          _isForgotPassword = false;
          _enableResetPassword = false;
          _isProcessing = false;
        });

        showTopSnackBar(
          context: context,
          body: "",
          title: "",
        );
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
            _enableResetPassword
                ? Container()
                : RoundedPasswordField(
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
                    text: _enableResetPassword
                        ? "تغير كلمة المرور"
                        : "تسجيل الدخول",
                    press: () async {
                      if (_enableResetPassword) {
                        await resetPassword();
                      } else {
                        await login(context);
                      }
                    },
                  ),
            _isProcessing
                ? Container()
                : _isForgotPassword
                    ? FlatButton(
                        child: Text(
                          _enableResetPassword
                              ? "العودة الى تسجيل الدخول"
                              : "هل نسيت كلمة المرور ؟",
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: Colors.indigo,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _enableResetPassword = !_enableResetPassword;
                          });
                        },
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
