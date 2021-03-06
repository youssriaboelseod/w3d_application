import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/cart_item.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:flutter/cupertino.dart';
//
import '../../../Providers/CartProvider/cart_provider.dart';
import '../../1MainHelper/Snacks/snackbar.dart';
import '../../1MainHelper/Helpers/helper.dart';
import '../../Product/Screen/product_screen.dart';

class CartItemCard extends StatelessWidget {
  final WooCartItem cartItem;
  const CartItemCard({Key key, this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 10,
              child: Stack(
                children: [
                  DetailsCard(
                    cartItem: cartItem,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: RemoveIcon(
                        cartItem: cartItem,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ImageAnimation(
              //product: productModel,
              cartItem: cartItem,
            ),
          ],
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final WooCartItem cartItem;

  const ImageCard({Key key, this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: (size.width / 3),
      height: 260,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          imageUrl: cartItem.images.length != 0 ? cartItem.images[0].src : "",
          fit: BoxFit.cover,
          width: double.maxFinite,
          height: double.maxFinite,
          errorWidget: (context, url, error) {
            return Image.asset(
              "assets/images/placeholder.png",
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: double.maxFinite,
            );
          },
          placeholder: (context, url) {
            return Image.asset(
              "assets/images/placeholder.png",
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: double.maxFinite,
            );
          },
        ),
      ),
    );
  }
}

class ImageBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: (size.width / 3),
      height: 260,
      child: Card(
        elevation: 5,
        color: Color(0xFFECF0F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            "assets/images/background.jpg",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class ImageAnimation extends StatelessWidget {
  final WooCartItem cartItem;
  const ImageAnimation({Key key, this.cartItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: cartItem.key,
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
                          tag: cartItem.key,
                          child: CachedNetworkImage(
                            imageUrl: cartItem.images.length != 0
                                ? cartItem.images[0].src
                                : "",
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
            cartItem: cartItem,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Color(0xFFECF0F0),
      ),
      placeholderBuilder: (context, heroSize, child) {
        return ImageBackground();
      },
    );
  }
}

// ignore: must_be_immutable
class DetailsCard extends StatelessWidget {
  final WooCartItem cartItem;

  DetailsCard({
    Key key,
    this.cartItem,
  }) : super(key: key);

  List<Map> variationsMap = [];
  void prepareVariations() {
    int counter = 0;
    while (counter < cartItem.variation.length) {
      String key = cartItem.variation[counter];
      if (key == "attribute_pa_size") {
        key = "????????????";
      } else if (key == "attribute_pa_sex") {
        key = "??????????";
      } else if (key == "attribute_pa_color") {
        key = "??????????";
      }
      String value = cartItem.variation[counter + 1];
      //value = utf8.encode(value.codeUnits);

      variationsMap.add({
        "key": key,
        "value": value,
      });
      counter += 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    prepareVariations();

    Map<String, dynamic> productMap =
        Provider.of<CartProvider>(context, listen: false).getProductById(
      id: cartItem.id,
    );

    return Container(
      width: (size.width / 1.5) + 10,
      height: 234,
      color: Color(0xFFecf0f0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (BuildContext context) => new ProductScreen(
                productMap: productMap,
              ),
            ),
          );
        },
        child: Card(
          color: Color(0xFFecf0f0),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: Color(0xFFecf0f0),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: size.width / 1.3,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 23,
                    right: 45,
                    top: 3,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      productMap["value"].name ?? "",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontSize: 20,
                        color: Color(0xFF416D6D),
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: variationsMap.length == 0
                          ? 40
                          : variationsMap.length == 1
                              ? 20
                              : variationsMap.length == 2
                                  ? 10
                                  : 1,
                    ),
                    ...variationsMap.map(
                      (e) => CartItemDetails(
                        title: e["key"],
                        value: e["key"] == "??????????"
                            ? getColorValue(e["value"])
                            : e["key"] == "??????????"
                                ? getTypeValue(e["value"])
                                : e["value"],
                      ),
                    ),
                    CartItemDetails(
                      title: "????????????",
                      value: cartItem.quantity.toString(),
                    ),
                    CartItemDetails(
                      title: "??????????",
                      value: cartItem.price + "  ????",
                    ),
                    CartItemDetails(
                      title: "?????????? ??????????",
                      value: cartItem.linePrice.toString() + "  ????",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItemDetails extends StatelessWidget {
  final String title;
  final String value;
  final int index;

  const CartItemDetails({
    Key key,
    this.title,
    this.value,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String valueModified = value.replaceAll("??.??", "");
    return Container(
      margin: EdgeInsets.only(
        left: 35,
        right: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            valueModified,
            textScaleFactor: 1,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: Colors.blueGrey,
              fontSize: 16,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            title + "  :  ",
            textScaleFactor: 1,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class RemoveIcon extends StatefulWidget {
  final WooCartItem cartItem;

  const RemoveIcon({Key key, this.cartItem}) : super(key: key);

  @override
  _RemoveIconState createState() => _RemoveIconState();
}

class _RemoveIconState extends State<RemoveIcon> {
  @override
  void initState() {
    super.initState();
  }

  bool check = false;
  String action = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFd1dbdb),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: _isLoading
          ? SpinKitChasingDots(
              color: Colors.black,
            )
          : IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.grey[800],
                size: 30,
              ),
              onPressed: () async {
                if (_isLoading) {
                  return;
                }
                setState(() {
                  _isLoading = true;
                });
                showTopSnackBar(
                  context: context,
                  title: "?????????? ??????????",
                  body: "???????? ?????? ???????????? ???? ??????????",
                );
                check = await Provider.of<CartProvider>(context, listen: false)
                    .removeProductFromCart(
                  cartItem: widget.cartItem,
                );

                if (check) {
                  showTopSnackBar(
                    context: context,
                    body: "???? ?????? ???????????? ???? ?????????? ??????????",
                    title: "????????",
                  );
                } else {
                  showTopSnackBar(
                    context: context,
                    body: "?????? ?????? ?????? ???? ???????? ???????? ?????? ????????",
                    title: "??????????",
                  );
                }
                setState(() {
                  _isLoading = false;
                });
              },
            ),
    );
  }
}
