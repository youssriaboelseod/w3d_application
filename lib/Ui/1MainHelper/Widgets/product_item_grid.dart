import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';
//
import '../../Product/Screen/product_screen.dart';
import '../../../Providers/FavouritesProvider/favourites_provider.dart';
import '../Snacks/snackbar.dart';

class ProductItemGrid extends StatelessWidget {
  final WooProduct product;

  const ProductItemGrid({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 180,
        height: 300,
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
            child: FavoriteStar(
              product: product,
            ),
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
  const ImageAnimation({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
      width: 180,
      //height: 80,

      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (BuildContext context) => new ProductScreen(
                productModel: product,
              ),
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
                                width: 70,
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
                          width: 70,
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
                    textDirection: TextDirection.rtl,
                    textScaleFactor: 1,
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

  String action = "";

  bool _isProcessing = false;
  @override
  void initState() {
    _isFavorite = Provider.of<FavouritesProvider>(context, listen: false)
        .checkIfFavourite(
      productId: widget.product.id,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.grey[800],
        size: 35,
      ),
      onPressed: () async {
        if (_isProcessing) {
          return;
        }
        _isProcessing = true;
        if (_isFavorite) {
          await Provider.of<FavouritesProvider>(context, listen: false)
              .removeFavouriteProduct(
            productId: widget.product.id,
          );

          action = "تمت حذف المنتج من المفضلة";
        } else {
          await Provider.of<FavouritesProvider>(context, listen: false)
              .addFavouriteProduct(
            productId: widget.product.id,
          );
          action = "تمت اضافة المنتج الي المفضلة";
        }
        showTopSnackBar(
          context: context,
          body: action,
          title: "رائع",
        );

        setState(() {
          _isFavorite = !_isFavorite;
        });

        _isProcessing = false;
      },
    );
  }
}
