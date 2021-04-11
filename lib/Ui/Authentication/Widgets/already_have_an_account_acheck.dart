import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "تسجيل جديد" : "تسجيل الدخول",
            textScaleFactor: 1,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          login ? "لا املك حساب؟" : "املك حساب مسبقا؟",
          textScaleFactor: 1,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}
