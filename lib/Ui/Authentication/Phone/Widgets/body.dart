import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts_arabic/fonts.dart';
//
import '../../../Authentication/Phone/Functions/validate_inputs.dart';
import '../../../1MainHelper/Alerts/alerts.dart';
import '../Functions/verify_phone_number.dart';
import '../Widgets/submit_phone_number_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InputPhoneNumberBlock(),
    );
  }
}

// ignore: must_be_immutable
class InputPhoneNumberBlock extends StatelessWidget {
  String countryCode = "";
  String number = "";

  //
  Future<void> submitPhoneNumber(
    BuildContext context,
    Function resetLoading,
  ) async {
    String phoneNumber = countryCode + number;
    // Validate phone number
    String output = validateInputs(phoneNumber: phoneNumber);
    if (output != null) {
      showAlertNoAction(
        context: context,
        message: output,
      );
      return;
    }

    // Send verification code and try to auto verify code
    await sendVerificationCode(
      phoneNumber: phoneNumber,
      context: context,
      resetLoading: resetLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: (size.height / 4),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Text(
                      "سوف نرسل رمز تأكيد الي رقم هاتفك",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: CountryCodePicker(
                                onChanged: (value) {
                                  countryCode = value.dialCode;
                                },
                                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                initialSelection: 'SA',
                                favorite: ['+966', 'SA'],
                                // optional. Shows only country name and flag
                                showCountryOnly: false,
                                // optional. Shows only country name and flag when popup is closed.
                                showOnlyCountryWhenClosed: false,
                                // optional. aligns the flag and the Text left
                                alignLeft: false,

                                onInit: (value) {
                                  countryCode = value.dialCode;
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "اختار كود الدولة",
                            textScaleFactor: 1,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Card(
                      color: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.ltr,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: "ادخل رقم هاتفك",
                            hintStyle: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          onChanged: (value) {
                            number = value;
                          },
                        ),
                      ),
                    ),
                  ),
                  SubmitButton(
                    title: "ارسال",
                    submitFn: submitPhoneNumber,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
