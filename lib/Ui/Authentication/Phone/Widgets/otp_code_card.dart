import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts_arabic/fonts.dart';
import '../Functions/validate_inputs.dart';
import '../../../1MainHelper/Alerts/alerts.dart';
import '../Widgets/submit_otp_code_button.dart';

import '../Functions/verify_phone_number.dart';

// ignore: must_be_immutable
class OtpCodeCard extends StatelessWidget {
  OtpCodeCard({
    Key key,
  }) : super(key: key);
  String verificationCode = "";
  String code1;
  String code2;
  String code3;
  String code4;
  String code5;
  String code6;

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    //
    Future<void> submitCode(BuildContext context) async {
      // Validate the code
      bool check = validateOtpInputs(
        code1: code1,
        code2: code2,
        code3: code3,
        code4: code4,
        code5: code5,
        code6: code6,
      );

      if (check) {
        ////////////
        verificationCode = code1 + code2 + code3 + code4 + code5 + code6;
        await verifyCode(
          context: context,
          smsCode: verificationCode,
          phoneAuthCredential: null,
        );
      } else {
        showAlertNoAction(
          context: context,
          message: "من فضلك ادخل ال 6 ارقام المرسلة الي رقم هاتفك",
        );
        return;
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "تم ارسال كود تأكيد الى رقم هاتفك",
              textScaleFactor: 1,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "ادخل الكود",
              textScaleFactor: 1,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OneNumberInputCard(
                      onChanged: (value) {
                        code1 = value;
                        if (value.isNotEmpty) {
                          node.nextFocus();
                        }
                      },
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    OneNumberInputCard(
                      onChanged: (value) {
                        code2 = value;
                        if (value.isNotEmpty) {
                          node.nextFocus();
                        }
                      },
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    OneNumberInputCard(
                      onChanged: (value) {
                        code3 = value;
                        if (value.isNotEmpty) {
                          node.nextFocus();
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OneNumberInputCard(
                      onChanged: (value) {
                        code4 = value;
                        if (value.isNotEmpty) {
                          node.nextFocus();
                        }
                      },
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    OneNumberInputCard(
                      onChanged: (value) {
                        code5 = value;
                        if (value.isNotEmpty) {
                          node.nextFocus();
                        }
                      },
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    OneNumberInputCard(
                      onChanged: (value) {
                        code6 = value;
                      },
                    ),
                  ],
                ),
                SubmitButton(
                  title: "تحقق",
                  submitFn: submitCode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OneNumberInputCard extends StatelessWidget {
  final ValueChanged<String> onChanged;

  OneNumberInputCard({Key key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        height: 60,
        width: 60,
        child: Center(
          child: TextField(
            textAlign: TextAlign.center,
            maxLength: 1,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: onChanged,
            style: TextStyle(
              fontSize: 25,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: "",
            ),
          ),
        ),
      ),
    );
  }
}
