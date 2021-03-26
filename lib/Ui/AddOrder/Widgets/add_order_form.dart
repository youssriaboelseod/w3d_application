import 'dart:io';
import 'package:provider/provider.dart';
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

import 'package:flutter/material.dart';

import '../Widgets/input_text_card.dart';

import 'buttons.dart';

class AddOrderForm extends StatefulWidget {
  @override
  _AddOrderFormState createState() => _AddOrderFormState();
}

class _AddOrderFormState extends State<AddOrderForm> {
  String firstName;
  String lastName;
  String city;
  String address;
  String location;
  String note;
  String email;
  String phoneNumber;
  PaymentMethods paymentMethod = PaymentMethods.bank;

  bool _isLoading = false;

  Future<void> addOrder() async {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        city.isEmpty ||
        location.isEmpty ||
        address.isEmpty) {
      showAlertNoAction(
        context: context,
        message: "من فضلك ادخل جميع البيانات",
      );
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
        lastName: lastName,
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
          lastNameInp: lastName,
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
    //
    firstName = Provider.of<AuthDataProvider>(context, listen: false)
        .currentUser
        .firstName;
    lastName = Provider.of<AuthDataProvider>(context, listen: false)
        .currentUser
        .lastName;
    city =
        Provider.of<AuthDataProvider>(context, listen: false).currentUser.city;
    address = Provider.of<AuthDataProvider>(context, listen: false)
        .currentUser
        .address;
    location = Provider.of<AuthDataProvider>(context, listen: false)
        .currentUser
        .location;
    print(firstName);
    print(lastName);
    print(city);
    print(address);
    print(location);
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
                  hintText: "ادخل الاسم الاول",
                  type: "الاسم الاول",
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
                  hintText: "ادخل الاسم الاخير",
                  type: "الاسم الاخير",
                  initialText: lastName,
                  onChange: (value) {
                    lastName = value;
                  },
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
                  readOnly: true,
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
