import 'package:provider/provider.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:flutter/material.dart';
import '../../Profile/Screen/profile_screen.dart';
//
import '../../../Providers/AuthDataProvider/auth_data_provider.dart';
import '../../../Providers/OrdersProvider/order_provider.dart';
import '../../1MainHelper/Helpers/helper.dart';
import '../../Cart/Screen/cart_screen.dart';
import 'bill_form.dart';
import 'radio_buttons.dart';
import '../../PaymentMethods/Screen/payment_methods_screen.dart';
import '../../1MainHelper/Alerts/alerts.dart';
import '../../1MainHelper/Snacks/snackbar.dart';

import '../Widgets/input_text_card.dart';
import 'buttons.dart';

class AddOrderForm extends StatefulWidget {
  @override
  _AddOrderFormState createState() => _AddOrderFormState();
}

class _AddOrderFormState extends State<AddOrderForm> {
  bool checkIfSignedIn = false;
  String firstName;

  String city;
  String address;
  String location;
  String note;
  String email;
  String phoneNumber;
  PaymentMethods paymentMethod = PaymentMethods.bank;

  bool _isLoading = false;

  Future<void> addOrder() async {
    if (!checkIfSignedIn) {
      showTopSnackBar(
        context: context,
        body: "من فضلك قم بالتسجيل اولا",
        title: "تنبيه",
      );
      return;
    }
    if (firstName.isEmpty ||
        city.isEmpty ||
        location.isEmpty ||
        address.isEmpty) {
      showAlertNoAction(
        context: context,
        message: "من فضلك ادخل جميع البيانات",
      );
      return;
    }

    if (phoneNumber.isEmpty) {
      final String result = await showAlertNoAction(
        context: context,
        message: "من فضلك قم باضافة رقم هاتفك اولا",
        outputAction: "Go to phone page",
      );
      if (result == "Go to phone page") {
        await Navigator.of(context).pushNamed(ProfileScreen.routeName);
        phoneNumber = Provider.of<AuthDataProvider>(context, listen: false)
            .currentUser
            .phoneNumber;
      }
      return;
    }

    FocusScope.of(context).unfocus();
    final result = await showAlertYesOrNo(
      context: context,
      title: "هل تريد اتمام الطلب ؟",
    );
    if (result == "no") {
      return;
    } else if (result == "yes") {
      setState(() {
        _isLoading = true;
      });
      // my function
      String output;
      output =
          await Provider.of<OrdersProvider>(context, listen: false).createOrder(
        context: context,
        firstName: firstName,
        city: city,
        address: address,
        location: location,
        note: note,
        email: email,
        phoneNumber: phoneNumber,
        paymentMethod: paymentMethod,
      );
      if (output != null) {
        showAlertNoAction(
          context: context,
          message: output,
        );
      } else {
        showTopSnackBar(
          context: context,
          title: "رائع",
          body: "تمت تنفيذ الطلب بنجاح",
        );
        await Provider.of<AuthDataProvider>(context, listen: false)
            .updateUserOrderInforInAuthDataTable(
          addressInp: address,
          cityInp: city,
          firstNameInp: firstName,
          lastNameInp: "", //lastName,
          locationInp: location,
        );

        await Future.delayed(
          Duration(
            seconds: 1,
          ),
        );
        Navigator.of(context)
            .popUntil(ModalRoute.withName(CartScreen.routeName));
        Navigator.of(context)
            .pushReplacementNamed(PaymentMethodsScreen.routeName);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    email =
        Provider.of<AuthDataProvider>(context, listen: false).currentUser.email;
    phoneNumber = Provider.of<AuthDataProvider>(context, listen: false)
        .currentUser
        .phoneNumber;
    checkIfSignedIn =
        Provider.of<AuthDataProvider>(context, listen: false).checkIfSignedIn();
    //
    firstName = Provider.of<AuthDataProvider>(context, listen: false)
        .currentUser
        .firstName;

    city =
        Provider.of<AuthDataProvider>(context, listen: false).currentUser.city;
    address = Provider.of<AuthDataProvider>(context, listen: false)
        .currentUser
        .address;
    location = Provider.of<AuthDataProvider>(context, listen: false)
        .currentUser
        .location;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BillForm(),
                InputTextCard(
                  hintText: "ادخل الاسم الكامل",
                  type: "الاسم",
                  initialText: firstName,
                  onChange: (value) {
                    firstName = value;
                  },
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                InputTextCard(
                  type: "الدولة",
                  initialText: "المملكة العربية السعودية",
                  readOnly: true,
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                InputTextCard(
                  hintText: "ادخل اسم المدينة",
                  type: "المدينة",
                  initialText: city,
                  onChange: (value) {
                    city = value;
                  },
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                InputTextCard(
                  hintText: "ادخل عنوان الشارع / الحي",
                  type: "العنوان",
                  initialText: address,
                  onChange: (value) {
                    address = value;
                  },
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                InputTextCard(
                  hintText: "ادخل المنطقة",
                  type: "المنطقة",
                  initialText: location,
                  onChange: (value) {
                    location = value;
                  },
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                InputTextCard(
                  type: "الهاتف",
                  initialText: phoneNumber,
                  //hintText: phoneNumber,
                  //readOnly: true,
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                InputTextCard(
                  type: "البريد",
                  initialText: email,
                  //hintText: email,
                  readOnly: true,
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                InputTextCard(
                  type: "الملاحظات",
                  hintText: "اي ملاحظات للبائع",
                  initialText: "",
                  onChange: (value) {
                    note = value;
                  },
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                RadioButtons(
                  onChange: (value) {
                    paymentMethod = value;
                  },
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                const Text(
                  "تنويه : يتم الشحن ما بين 3 ايام الى 7 ايام",
                  overflow: TextOverflow.fade,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontSize: 17,
                    color: Colors.black,
                  ),
                  softWrap: true,
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                _isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.black,
                          ),
                        ),
                      )
                    : Button(
                        iconData: Icons.check,
                        backgroundColor: Colors.black,
                        function: () async {
                          await addOrder();
                        },
                        title: "تأكيد الطلب",
                        textColor: Colors.white,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
