import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:w3d/Providers/SlidersProvider/slider_provider.dart';

import '../../1MainHelper/carousel_pro/src/carousel_pro.dart';

class ImageSwitcherCard extends StatelessWidget {
  const ImageSwitcherCard({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> sliders =
        Provider.of<SlidersProvider>(context, listen: false).getSliders;
    Size size = MediaQuery.of(context).size;
    print(size.height);
    return Container(
      height: size.height < 500 ? 170 : 200,
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 10,
        left: 5,
        right: 5,
      ),
      child: Hero(
        tag: "productModel.id",
        child: Material(
          color: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Carousel(
            autoplayDuration: Duration(
              seconds: 6,
            ),
            animationDuration: Duration(
              seconds: 6,
            ),
            dotColor: Colors.black26,
            dotIncreaseSize: 1.7,
            dotBgColor: Colors.transparent,
            autoplay: true,
            boxFit: BoxFit.fill,
            images: sliders
                .map((e) => ImageAnimation(
                      imageUrl: e,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class ImageAnimation extends StatelessWidget {
  final String imageUrl;

  const ImageAnimation({Key key, this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: GestureDetector(
        onTap: () {
          showImage(
            context: context,
            imageUrl: imageUrl,
            size: size,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            alignment: Alignment.center,
            fit: BoxFit.fill,
            placeholder: (context, url) {
              return Image.asset(
                "assets/images/placeholder.png",
                width: 150.0,
                height: 150.0,
              );
            },
            errorWidget: (context, url, error) {
              return Image.asset(
                "assets/images/placeholder.png",
                width: 150.0,
                height: 150.0,
              );
            },
          ),
        ),
      ),
    );
  }
}

void showImage({
  BuildContext context,
  String imageUrl,
  Size size,
}) {
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
