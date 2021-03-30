import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w3d/Providers/AuthDataProvider/auth_data_provider.dart';
import 'package:w3d/Providers/ManageProductsProvider/manage_products_provider.dart';

Future<String> addProductFn({
  BuildContext context,
  String name,
  String description,
  String price,
  String categoryId,
  List<File> imagesFiles,
}) async {
  String userId =
      Provider.of<AuthDataProvider>(context, listen: false).currentUser.id;
  String phoneNumber = Provider.of<AuthDataProvider>(context, listen: false)
      .currentUser
      .phoneNumber;

  if (phoneNumber.isEmpty) {
    return "من فضلك قم باضافة رقم هاتفك اولا , لكي يستطيع المشتري ان يتواصل معك";
  }
  //
  Map productMap = {
    "name": name,
    "post_author": userId,
    "type": "external",
    "regular_price": price,
    "short_description": description,
    "categories": [
      categoryId,
    ],
    "external_url": "https://wsend.co/" + phoneNumber, // phoneNumber,

    "button_text": "للتواصل",
    "description": "whatsapp://send?phone=" + phoneNumber,
  };
  int counter = 0;
  List<String> imagesUrl = [];

  while (counter < imagesFiles.length) {
    String imageUrl =
        await Provider.of<ManageProductsProvider>(context, listen: false)
            .uploadImageToServer(
      context: context,
      imageFile: imagesFiles[counter],
    );
    imagesUrl.add(imageUrl);
    counter += 1;
  }

  if (imagesUrl.length != 0) {
    productMap.addAll(
      {
        "featured_image": {
          "src": imagesUrl[0],
        },
      },
    );
    imagesUrl.removeAt(0);
    productMap.addAll(
      {
        "gallery_images": imagesUrl.map((element) {
          if (element.isNotEmpty) {
            return {
              "src": element,
              //"position": counter.toString(),
            };
          }
        }).toList(),
      },
    );
  } else {
    productMap.addAll(
      {
        "gallery_images": [],
      },
    );
  }

  String output =
      await Provider.of<ManageProductsProvider>(context, listen: false)
          .createProduct(
    context: context,
    productMap: productMap,
    vendorId: userId,
  );
  return output;
}
