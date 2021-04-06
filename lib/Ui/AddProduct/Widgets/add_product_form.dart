import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
//
import '../../MyProducts/Screen/my_products_screen.dart';
import '../../../Providers/AuthDataProvider/auth_data_provider.dart';
import '../../Profile/Screen/profile_screen.dart';
import 'multi_select_images_card.dart';
import '../../1MainHelper/Helpers/helper.dart';
import 'options_button.dart';
import '../Widgets/input_text_card.dart';
import 'input_double_card.dart';
import 'buttons.dart';
import '../Functions/add_product.dart';
import '../../1MainHelper/Alerts/alerts.dart';
import '../../1MainHelper/Snacks/snackbar.dart';

class AddProductForm extends StatefulWidget {
  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  List<File> imagesFiles = [];
  String name = "";
  String description = "";
  String categoryId = "";
  String phoneNumber;

  String price = "";

  bool _isLoading = false;
  bool checkIfSignedIn = false;
  @override
  void initState() {
    super.initState();
    checkIfSignedIn =
        Provider.of<AuthDataProvider>(context, listen: false).checkIfSignedIn();
    phoneNumber = Provider.of<AuthDataProvider>(context, listen: false)
        .currentUser
        .phoneNumber;
  }

  void addImagesFiles(List<File> imagesFilesInp) {
    imagesFiles.clear();
    imagesFiles.addAll(imagesFilesInp);
  }

  Future<void> addProduct() async {
    if (!checkIfSignedIn) {
      showTopSnackBar(
        context: context,
        body: "من فضلك قم بالتسجيل اولا",
        title: "تنبيه",
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
    if (name.isEmpty) {
      showAlertNoAction(
        context: context,
        message: "من فضلك ادخل اسم المنتج",
      );
      return;
    }
    if (categoryId.isEmpty) {
      showAlertNoAction(
        context: context,
        message: "من فضلك اختار القسم الذي ينتمي اليه المنتج",
      );
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });
    String output = await addProductFn(
      context: context,
      name: name.trim(),
      description: description.trim(),
      price: price,
      categoryId: categoryId,
      imagesFiles: imagesFiles,
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
        body: "تمت اضافة المنتج بنجاح",
      );
      await Future.delayed(
        Duration(
          milliseconds: 1500,
        ),
      );

      Navigator.of(context).pushReplacementNamed(
        MyProductsScreen.routeName,
      );
    }
    setState(() {
      _isLoading = false;
    });
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
                InputTextCard(
                  hintText: "ادخل اسم المنتج",
                  type: "الاسم",
                  onChange: (value) {
                    name = value;
                  },
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                InputTextCard(
                  hintText: "ادخل وصف قصير للمنتج",
                  type: "الوصف",
                  onChange: (value) {
                    description = value;
                  },
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                InputDoubleCard(
                  type: "السعر",
                  hintText: "00",
                  onChangeFirst: (value) {
                    price = value;
                  },
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                OptionsButton(
                  type: "القسم",
                  onChangeValue: (value) {
                    categoryId = getCategoryId(nameInp: value);
                    FocusScope.of(context).unfocus();
                  },
                  options: getCategoriesNames(),
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                MultiSelectImagesCard(
                  function: addImagesFiles,
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                _isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SpinKitChasingDots(
                          color: Colors.black,
                        ),
                      )
                    : Button(
                        iconData: Icons.check,
                        backgroundColor: Colors.black,
                        function: () async {
                          await addProduct();
                        },
                        title: "أضف المنتج",
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
