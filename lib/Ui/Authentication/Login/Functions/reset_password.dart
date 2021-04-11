import '../../../1MainHelper/Functions/main_functions.dart';

//

void contactToResetPassword(String email) async {
  openWhatAppMain(
    phoneNumber: "966501722732",
    message: "نسيت كلمة المرور" + email,
  );
}
