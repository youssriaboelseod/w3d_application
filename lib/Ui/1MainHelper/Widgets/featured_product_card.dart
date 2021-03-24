import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts_arabic/fonts.dart';

import 'package:woocommerce/woocommerce.dart';

//
import '../../Product/Screen/product_screen.dart';
import '../Functions/add_remove_favourite.dart';
import '../Snacks/snackbar.dart';

class FeaturedProductCard extends StatelessWidget {
  final WooProduct product;
  final int index;

  const FeaturedProductCard({Key key, this.product, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 180,
        height: 265,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              ImageAnimation(
                product: product,
                index: index,
              ),
              DetailsCard(
                product: product,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final WooProduct product;

  const ImageCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 170,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: CachedNetworkImage(
              imageUrl: product.images.length != 0 ? product.images[0].src : "",
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: double.maxFinite,
              errorWidget: (context, url, error) {
                return Image.asset(
                  "assets/images/placeholder.png",
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                );
              },
              placeholder: (context, url) {
                return Image.asset(
                  "assets/images/placeholder.png",
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: FavoriteStar(),
          ),
          (product.onSale && product.regularPrice.isNotEmpty)
              ? Positioned(
                  left: 0,
                  top: 0,
                  child: PercentageCard(
                    product: product,
                  ),
                )
              : Container(),
          product.type == "external"
              ? Container()
              : Positioned(
                  right: 0,
                  bottom: 0,
                  child: ExpressCard(),
                ),
        ],
      ),
    );
  }
}

class PercentageCard extends StatelessWidget {
  final WooProduct product;

  const PercentageCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double discount =
        double.parse(product.regularPrice) - double.parse(product.price);
    double percentage = (discount / double.parse(product.regularPrice)) * 100;

    return Container(
      width: 60,
      padding: EdgeInsets.all(
        5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
        ),
        color: Colors.grey,
      ),
      child: Text(
        "\% " + percentage.round().toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}

class ExpressCard extends StatelessWidget {
  final WooProduct product;

  const ExpressCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      padding: EdgeInsets.all(
        5,
      ),
      color: Colors.grey,
      child: Text(
        "Express",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ImageAnimation extends StatelessWidget {
  final WooProduct product;
  final int index;
  const ImageAnimation({Key key, this.product, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime tempDate = DateTime.now();

    return Hero(
      tag: (product.id + index).toString() + tempDate.toString(),
      child: Material(
        child: InkWell(
          onTap: () {
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
                          tag: (product.id + index).toString() +
                              tempDate.toString(),
                          child: CachedNetworkImage(
                            imageUrl: product.images.length != 0
                                ? product.images[0].src
                                : "",
                            width: 300.0,
                            height: 320.0,
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
          },
          child: ImageCard(
            product: product,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Color(0xFFECF0F0),
      ),
      // placeholderBuilder: (context, heroSize, child) {
      // return ImageBackground();
      //},
    );
  }
}

class DetailsCard extends StatelessWidget {
  final WooProduct product;

  const DetailsCard({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: 180,
      //height: 80,

      child: GestureDetector(
        onTap: () {
          new MaterialPageRoute(
            builder: (BuildContext context) => new ProductScreen(
              productModel: product,
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: Text(
                  product.name.trim(),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            (product.onSale && product.regularPrice.isNotEmpty)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      product.regularPrice.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(
                                left: 2,
                              ),
                              child: Container(
                                width: 80,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    product.regularPrice.toString() + "  ر.س",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    textDirection: TextDirection.rtl,
                                    textScaleFactor: 1,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontFamily: ArabicFonts.Cairo,
                                      package: 'google_fonts_arabic',
                                      fontSize: 16,
                                      color: Colors.black,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 2,
                        ),
                        child: Container(
                          width: 80,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              product.price.isNotEmpty
                                  ? product.price.toString() + "  ر.س"
                                  : "",
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              softWrap: true,
                              textScaleFactor: 1,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: ArabicFonts.Cairo,
                                package: 'google_fonts_arabic',
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Text(
                    product.price.isNotEmpty
                        ? product.price.toString() + "  ر.س"
                        : "",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    textScaleFactor: 1,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class FavoriteStar extends StatefulWidget {
  final WooProduct product;

  FavoriteStar({Key key, this.product}) : super(key: key);

  @override
  _FavoriteStarState createState() => _FavoriteStarState();
}

class _FavoriteStarState extends State<FavoriteStar> {
  bool _isFavorite = false;

  bool check = false;

  String action = "";

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.grey[800],
        size: 35,
      ),
      onPressed: () async {
        return;
        if (_isProcessing) {
          return;
        }
        _isProcessing = true;
        if (_isFavorite) {
          check = await removeFavouriteProduct(
            context: context,
            //product: widget.WooProduct,
          );
          action = "removed from";
        } else {
          check = await addFavouriteProduct(
            context: context,
            //product: widget.WooProduct,
          );
          action = "added to";
        }
        if (check) {
          showTopSnackBar(
            context: context,
            body: "Product is $action your favourites",
            title: "Great",
          );

          setState(() {
            _isFavorite = !_isFavorite;
          });
        } else {
          showTopSnackBar(
            context: context,
            body: "Please, try again",
            title: "Failed",
          );
        }
        _isProcessing = false;
      },
    );
  }
}
