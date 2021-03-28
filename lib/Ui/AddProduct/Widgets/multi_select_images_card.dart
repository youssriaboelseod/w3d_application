import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:http/http.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:w3d/Ui/1MainHelper/Alerts/alerts.dart';

class MultiSelectImagesCard extends StatefulWidget {
  final Function function;

  const MultiSelectImagesCard({Key key, this.function}) : super(key: key);
  @override
  _MultiSelectImagesCardState createState() => _MultiSelectImagesCardState();
}

class _MultiSelectImagesCardState extends State<MultiSelectImagesCard> {
  List<Asset> images = <Asset>[];

  @override
  void initState() {
    super.initState();
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
    widget.function(imagesFiles);
  }

  void removeImage(int index) {
    imagesFiles.removeAt(index);
    images.removeAt(index);
    setState(() {});
  }

  Widget buildListView() {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagesFiles.length,
        itemBuilder: (context, index) {
          return ImageCardFromFile(
            imageFile: imagesFiles[index],
            key: ValueKey(imagesFiles[index]),
            index: index,
            removeImage: removeImage,
          );
        },
      ),
    );
  }

  Future<void> loadAssets() async {
    if (images.length == 4) {
      showAlertNoAction(
        context: context,
        message: "لقد وصلت للحد الاقصى من الصور",
      );
      return;
    }
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4 - images.length,
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
          images.length == 0 ? Container() : buildListView(),
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
        Container(
          child: GestureDetector(
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
        )
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
