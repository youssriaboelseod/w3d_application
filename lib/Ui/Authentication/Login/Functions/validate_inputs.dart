//
import 'package:string_validator/string_validator.dart';

import '../../../../Models/UserAuthModel/user_auth_model.dart';

String validateInputs({
  UserAuthModel userAuthModel,
}) {
  if (userAuthModel.email.isEmpty) {
    return "Please provide email";
  } else if (userAuthModel.password == null || userAuthModel.password.isEmpty) {
    return "Please provide password";
  } else {
    return null;
  }
}

String validateEmail({String email}) {
  if (email == null || email.trim().isEmpty) {
    return "Please provide email";
  } else if (!isEmail(email)) {
    return "Invalid email";
  } else {
    return null;
  }
}
