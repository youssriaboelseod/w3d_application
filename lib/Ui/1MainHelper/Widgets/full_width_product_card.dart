import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import 'package:woocommerce/woocommerce.dart';

//
import '../../../Providers/FavouritesProvider/favourites_provider.dart';
import '../../../Models/Product/product_model.dart';
import '../../Product/Screen/product_screen.dart';
import '../Functions/add_remove_favourite.dart';
import '../Snacks/snackbar.dart';

class FullWidthProductCard extends StatelessWidget {
  final WooProduct product;
  const FullWidthProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
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
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 180,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: CachedNetworkImage(
              imageUrl: product.images.length != 0 ? product.images[0].src : "",
              fit: BoxFit.contain,
              width: double.maxFinite,
              height: double.maxFinite,
              errorWidget: (context, url, error) {
                return Image.asset(
                  "assets/images/placeholder0.png",
                );
              },
              placeholder: (context, url) {
                return Image.asset(
                  "assets/images/placeholder0.png",
                );
              },
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: FavoriteStar(),
          ),
        ],
      ),
    );
  }
}

class ImageAnimation extends StatelessWidget {
  final WooProduct product;
  const ImageAnimation({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Hero(
      tag: product.id.toString(),
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
                          tag: product.id.toString(),
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
      width: size.width,
      child: GestureDetector(
        onTap: () {
          //Navigator.of(context).pushNamed(
          //ProductScreen.routeName,
          //arguments: product,
          //);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                ),
                child: Text(
                  product.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontFamily: 'Raphtalia',
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                product.price.isNotEmpty
                    ? product.price.toString() + "  ر.س"
                    : "",
                textAlign: TextAlign.center,
                maxLines: 1,
                textDirection: TextDirection.rtl,
                textScaleFactor: 1,
                style: TextStyle(
                  fontFamily: 'Raphtalia',
                  fontSize: 20,
                  color: Colors.black,
                ),
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
