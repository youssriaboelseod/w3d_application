import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import '../../../Providers/AuthDataProvider/auth_data_provider.dart';
import '../../../Providers/ManageProductsProvider/manage_products_provider.dart';

Future<String> updateProductFn({
  BuildContext context,
  String name,
  String productId,
  String description,
  String price,
  String categoryId,
  List<File> imagesFiles,
  List<String> imagesUrls,
}) async {
  String userId =
      Provider.of<AuthDataProvider>(context, listen: false).currentUser.id;
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
  };
  int counter = 0;

  while (counter < imagesFiles.length) {
    String imageUrl =
        await Provider.of<ManageProductsProvider>(context, listen: false)
            .uploadImageToServer(
      context: context,
      imageFile: imagesFiles[counter],
    );
    imagesUrls.add(imageUrl);
    counter += 1;
  }
  if (imagesUrls.length != 0) {
    productMap.addAll(
      {
        "featured_image": {
          "src": imagesUrls[0],
        },
      },
    );
    imagesUrls.removeAt(0);
    productMap.addAll(
      {
        "gallery_images": imagesUrls.map((element) {
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
          .updateProduct(
    context: context,
    productMap: productMap,
    vendorId: userId,
    productId: productId,
  );
  return output;
}
