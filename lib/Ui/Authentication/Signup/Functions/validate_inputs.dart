import 'package:string_validator/string_validator.dart';
//
import '../../../../Models/UserAuthModel/user_auth_model.dart';

String validateInputs({
  UserAuthModel userAuthModel,
  String passwordConfirmation,
}) {
  //var special_characters = new RegExp(r'[^\w\s]+');

  if (userAuthModel.userName.isEmpty) {
    return "من فضلك ادخل اسم المستخدم";
  } else if (userAuthModel.userName.length < 3) {
    return "اسم مستخدم الذي ادخلته قصير";
  } else if (userAuthModel.storeName.isEmpty) {
    return "من فضلك ادخل اسم متجرك";
  } else if (userAuthModel.storeName.length < 3) {
    return "اسم المتجر الذي ادخلته قصير";
  } else if (userAuthModel.email.isEmpty) {
    return "من فضلك ادخل بريك الالكتروني";
  } else if (!isEmail(userAuthModel.email)) {
    return "بريد الكتروني غير صالح";
  } else if (userAuthModel.password == null || userAuthModel.password.isEmpty) {
    return "من فضلك ادخل كلمة المرور";
  } else if (userAuthModel.password.length < 6) {
    return "اقل عدد 6 احرف وارقام ورموز";
  } else if (isAlpha(userAuthModel.password)) {
    return "كلمة المرور يجب ان تحتوي على احرف وارقام ورموز";
  } else if (isNumeric(userAuthModel.password)) {
    return "كلمة المرور يجب ان تحتوي على احرف وارقام ورموز";
  } else if (passwordConfirmation == null || passwordConfirmation.isEmpty) {
    return "من فضلك أكد كلمة المرور";
  } else if (userAuthModel.password != passwordConfirmation) {
    return "كلمة المرور غير متطابقة";
  } else {
    return null;
  }
}
