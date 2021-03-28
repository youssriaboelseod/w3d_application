import 'dart:io';

import 'package:flutter/material.dart';
import 'package:w3d/Ui/1MainHelper/Alerts/alerts.dart';
import 'package:w3d/Ui/1MainHelper/Helpers/helper.dart';
import 'package:w3d/Ui/1MainHelper/Snacks/snackbar.dart';
import 'package:woocommerce/models/products.dart';
import 'package:html/parser.dart' show parse;
import 'input_text_card.dart';

import 'input_double_card.dart';

import 'buttons.dart';
import '../Functions/update_product.dart';
import '../../../Models/Product/product_model.dart';
import 'multi_select_images_card.dart';
import 'options_button.dart';

// ignore: must_be_immutable
class UpdateProductForm extends StatefulWidget {
  final WooProduct product;
  UpdateProductForm({this.product});

  @override
  _UpdateProductFormState createState() => _UpdateProductFormState();
}

class _UpdateProductFormState extends State<UpdateProductForm> {
  List<File> imagesFiles = [];
  List<String> imagesUrls = [];

  String name = "";
  String description = "";
  String categoryId = "";
  String price = "";

  void updateImagesFiles(List<File> imagesFilesInp) {
    imagesFiles.clear();
    imagesFiles.addAll(imagesFilesInp);
  }

  void updateImagesUrl(List<String> imagesUrlsInp) {
    imagesUrls.clear();
    imagesUrls.addAll(imagesUrlsInp);
  }

  Future<void> update(BuildContext context) async {
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
    // check before preparing the price
    String output = await updateProductFn(
      context: context,
      name: name.trim(),
      description: description.trim(),
      price: price,
      categoryId: categoryId,
      imagesFiles: imagesFiles,
      imagesUrls: imagesUrls,
      productId: widget.product.id.toString(),
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
        body: "تمت تعديل المنتج بنجاح",
      );
    }
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  @override
  void initState() {
    super.initState();
    price = widget.product.price ?? "";
    categoryId = categoryId = getCategoryId(
      nameInp: widget.product.categories[0].name,
    );

    name = widget.product.name ?? "";
    description = widget.product.shortDescription.isEmpty
        ? ""
        : _parseHtmlString(widget.product.shortDescription);

    widget.product.images.forEach((element) {
      imagesUrls.add(element.src);
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
                  initialText: name,
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
                  initialText: description,
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
                  initialText1: price,
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
                  initialValue: widget.product.categories[0].name,
                  onChangeValue: (value) {
                    categoryId = getCategoryId(nameInp: value);
                  },
                  options: getCategoriesNames(),
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                MultiSelectImagesCard(
                  onChangeFiles: updateImagesFiles,
                  onChangeUrls: updateImagesUrl,
                  product: widget.product,
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                UpdateButton(
                  function: update,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpdateButton extends StatefulWidget {
  final Future<void> Function(BuildContext context) function;
  UpdateButton({this.function});
  @override
  _UpdateButtonState createState() => _UpdateButtonState();
}

class _UpdateButtonState extends State<UpdateButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.black,
              ),
            ),
          )
        : Button(
            iconData: Icons.check,
            backgroundColor: Color(0xFF8795DD),
            function: () async {
              setState(() {
                _isLoading = true;
              });

              await widget.function(context);
              setState(() {
                _isLoading = false;
              });
            },
            title: "تحديث المنتج",
            textColor: Colors.white,
          );
  }
}
