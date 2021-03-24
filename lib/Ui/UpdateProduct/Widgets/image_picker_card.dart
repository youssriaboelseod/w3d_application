import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagePickerCard extends StatefulWidget {
  final String type;
  final String imageUrl;

  final ValueChanged<File> onChange;

  ImagePickerCard({
    Key key,
    this.type,
    this.onChange,
    this.imageUrl,
  }) : super(key: key);

  @override
  _ImagePickerCardState createState() => _ImagePickerCardState();
}

class _ImagePickerCardState extends State<ImagePickerCard> {
  File imageFile;

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () async {
                        await _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () async {
                      await _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      imageFile = image;
    });
    widget.onChange(imageFile);
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      imageFile = image;
    });
    widget.onChange(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 2,
            ),
            child: Text(
              widget.type + " : ",
              textScaleFactor: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add_a_photo,
              size: 35,
              color: Colors.black,
            ),
            onPressed: () {
              _showPicker(context);
            },
          ),
          Spacer(),
          widget.imageUrl.isNotEmpty
              ? ImageCardFromNetwork(
                  imageUrl: widget.imageUrl,
                )
              : imageFile == null
                  ? Container()
                  : ImageCardFromFile(
                      imageFile: imageFile,
                    )
        ],
      ),
    );
  }
}

class ImageCardFromFile extends StatelessWidget {
  final File imageFile;

  const ImageCardFromFile({Key key, this.imageFile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: GestureDetector(
        onTap: () {
          showImageFromFile(
            context: context,
            imageFile: imageFile,
          );
        },
        child: Container(
          height: 150,
          width: 150,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                imageFile,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showImageFromFile({BuildContext context, File imageFile}) {
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
                  width: 300.0,
                  height: 320.0,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
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

  const ImageCardFromNetwork({Key key, this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      child: GestureDetector(
        onTap: () {
          showImageFromNetwork(
            context: context,
            imageUrl: imageUrl,
          );
        },
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
                  "assets/images/logo_wide.png",
                  width: 150.0,
                  height: 150.0,
                );
              },
              placeholder: (context, url) {
                return Image.asset(
                  "assets/images/logo_wide.png",
                  width: 150.0,
                  height: 150.0,
                );
              },
            ),
          ),
        ),
      ),
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
                  width: 300.0,
                  height: 320.0,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      "assets/images/logo_wide.png",
                      width: 150.0,
                      height: 150.0,
                    );
                  },
                  placeholder: (context, url) {
                    return Image.asset(
                      "assets/images/logo_wide.png",
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
