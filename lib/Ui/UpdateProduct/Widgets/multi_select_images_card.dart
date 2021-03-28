import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:woocommerce/models/products.dart';

//
import '../../1MainHelper/Alerts/alerts.dart';

class MultiSelectImagesCard extends StatefulWidget {
  final Function onChangeFiles;
  final Function onChangeUrls;
  final WooProduct product;

  const MultiSelectImagesCard(
      {Key key, this.onChangeFiles, this.onChangeUrls, this.product})
      : super(key: key);

  @override
  _MultiSelectImagesCardState createState() => _MultiSelectImagesCardState();
}

class _MultiSelectImagesCardState extends State<MultiSelectImagesCard> {
  List<Asset> images = <Asset>[];
  List<String> currentProductImagesUrls = [];

  @override
  void initState() {
    super.initState();
    widget.product.images.forEach((element) {
      currentProductImagesUrls.add(element.src);
    });
  }

  List<File> imagesFiles = [];

  Future<void> getFileList() async {
    imagesFiles.clear();
    for (int i = 0; i < images.length; i++) {
      var filePath =
          await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);

      imagesFiles.add(
        File(filePath),
      );
    }
    // add the images' files in the List in add_product_form
    widget.onChangeFiles(imagesFiles);
  }

  void removeImageFile(int index) {
    imagesFiles.removeAt(index);
    images.removeAt(index);
    widget.onChangeFiles(imagesFiles);
    setState(() {});
  }

  void removeImageUrl(int index) {
    currentProductImagesUrls.removeAt(index);
    widget.onChangeUrls(currentProductImagesUrls);

    setState(() {});
  }

  Widget buildListView() {
    return Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            children: [
              ...List.generate(
                imagesFiles.length,
                (index) {
                  return ImageCardFromFile(
                    imageFile: imagesFiles[index],
                    key: ValueKey(imagesFiles[index]),
                    index: index,
                    removeImage: removeImageFile,
                  );
                },
              ),
              ...List.generate(
                currentProductImagesUrls.length,
                (index) {
                  return ImageCardFromNetwork(
                    imageUrl: currentProductImagesUrls[index],
                    key: ValueKey(currentProductImagesUrls[index]),
                    index: index,
                    removeImage: removeImageUrl,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> loadAssets() async {
    if ((images.length + currentProductImagesUrls.length) == 4) {
      showAlertNoAction(
        context: context,
        message: "لقد وصلت للحد الاقصى من الصور",
      );
      return;
    }
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4 - images.length - currentProductImagesUrls.length,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Pick images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      //
      print(e);
    }

    if (!mounted) return;
    //
    if (resultList.length == 0) {
      return;
    }
    images.clear();
    images.addAll(resultList);

    await getFileList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          RaisedButton.icon(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            color: Colors.black,
            onPressed: () async {
              //pickImages();
              await loadAssets();
            },
            label: Text(
              "اضافة صور",
              textScaleFactor: 1,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.add_a_photo,
              color: Colors.white,
              size: 30,
            ),
          ),
          buildListView(),
        ],
      ),
    );
  }
}

class ImageCardFromFile extends StatelessWidget {
  final File imageFile;
  final Function removeImage;
  final int index;

  const ImageCardFromFile({
    Key key,
    this.imageFile,
    this.removeImage,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            showImageFromFile(
              context: context,
              imageFile: imageFile,
              size: size,
            );
          },
          child: Container(
            height: 140,
            width: 140,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  imageFile,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/placeholder.png",
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: Icon(
              Icons.remove_circle_outline,
              size: 30,
              color: Colors.red,
            ),
            onPressed: () {
              removeImage(index);
            },
          ),
        ),
      ],
    );
  }
}

void showImageFromFile({BuildContext context, File imageFile, Size size}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return new Material(
          color: Colors.black54,
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: InkWell(
              child: Hero(
                tag: imageFile,
                child: Image.file(
                  imageFile,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/placeholder.png",
                      width: 150.0,
                      height: 150.0,
                    );
                  },
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 700),
    ),
  );
}

class ImageCardFromNetwork extends StatelessWidget {
  final String imageUrl;
  final Function removeImage;
  final int index;

  const ImageCardFromNetwork({
    Key key,
    this.imageUrl,
    this.index,
    this.removeImage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            showImageFromNetwork(
              context: context,
              imageUrl: imageUrl,
            );
          },
          child: Container(
            height: 140,
            width: 140,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      "assets/images/placeholder.png",
                    );
                  },
                  placeholder: (context, url) {
                    return Image.asset(
                      "assets/images/placeholder.png",
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: Icon(
              Icons.remove_circle_outline,
              size: 30,
              color: Colors.red,
            ),
            onPressed: () {
              removeImage(index);
            },
          ),
        ),
      ],
    );
  }
}

void showImageFromNetwork({BuildContext context, String imageUrl}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return new Material(
          color: Colors.black54,
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: InkWell(
              child: Hero(
                tag: imageUrl,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      "assets/images/placeholder.png",
                      width: 150.0,
                      height: 150.0,
                    );
                  },
                  placeholder: (context, url) {
                    return Image.asset(
                      "assets/images/placeholder.png",
                      width: 150.0,
                      height: 150.0,
                    );
                  },
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 700),
    ),
  );
}
