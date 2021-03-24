//

String validateInputs({String phoneNumber}) {
  if (phoneNumber == null || phoneNumber.trim().isEmpty) {
    return "Please provide your phone number";
  } else if (phoneNumber.length < 6) {
    return "Invalid phone number";
  } else {
    return null;
  }
}

bool validateOtpInputs({
  String code1,
  String code2,
  String code3,
  String code4,
  String code5,
  String code6,
}) {
  if (code1 == null || code1.trim().isEmpty) {
    return false;
  } else if (code2 == null || code2.trim().isEmpty) {
    return false;
  } else if (code3 == null || code3.trim().isEmpty) {
    return false;
  } else if (code4 == null || code4.trim().isEmpty) {
    return false;
  } else if (code5 == null || code5.trim().isEmpty) {
    return false;
  } else if (code6 == null || code6.trim().isEmpty) {
    return false;
  } else {
    return true;
  }
}
