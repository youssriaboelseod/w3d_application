import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';
import '../../../Providers/DynamicLinksProvider/dynamic_links_provider.dart';
import '../../1MainHelper/Alerts/alerts.dart';
import '../../UpdateProduct/Screen/update_product_screen.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../1MainHelper/Snacks/snackbar.dart';
import 'package:provider/provider.dart';
import '../../../Providers/AuthDataProvider/auth_data_provider.dart';

import '../../../Providers/ManageProductsProvider/manage_products_provider.dart';
import '../../../Providers/ProductsProvider/products_provider.dart';
import '../../../Providers/FavouritesProvider/favourites_provider.dart';
import '../../1MainHelper/carousel_pro/src/carousel_pro.dart';

// ignore: must_be_immutable
class ImageSwitcherCard extends StatelessWidget {
  final Map<String, dynamic> productMap;
  ImageSwitcherCard({Key key, this.productMap}) : super(key: key);
  List<String> imagesUrls = [];
  WooProduct pr;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    productMap["value"].images.forEach((element) {
      imagesUrls.add(element.src);
    });
    return Container(
      height: size.height < 500 ? 200 : 280,
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 10,
      ),
      child: Hero(
        tag: productMap["value"].id,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 15,
                  bottom: 5,
                ),
                child: new Carousel(
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
                  boxFit: BoxFit.cover,
                  images: imagesUrls.length == 0
                      ? []
                      : List.generate(
                          imagesUrls.length,
                          (index) => ImageAnimation(
                            imagesUrls: imagesUrls,
                            index: index,
                          ),
                        ),
                ),
              ),
              Positioned(
                top: 10,
                right: 0,
                child: OptionsIcons(
                  productMap: productMap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageAnimation extends StatelessWidget {
  final List<String> imagesUrls;
  final int index;

  const ImageAnimation({Key key, this.imagesUrls, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          showImage(
            context: context,
            index: index,
            imagesUrls: imagesUrls,
          );
        },
        child: CachedNetworkImage(
          imageUrl: imagesUrls[index],
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
    );
  }
}

class ImagesSwitcherNew extends StatefulWidget {
  final List<String> imagesUrls;
  final int index;

  const ImagesSwitcherNew({Key key, this.imagesUrls, this.index})
      : super(key: key);

  @override
  _ImagesSwitcherNewState createState() => _ImagesSwitcherNewState();
}

class _ImagesSwitcherNewState extends State<ImagesSwitcherNew> {
  int selectedIndex;
  @override
  void initState() {
    selectedIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Material(
      color: Colors.black54,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                InkWell(
                  child: Hero(
                    tag: widget.imagesUrls[selectedIndex],
                    child: CachedNetworkImage(
                      imageUrl: widget.imagesUrls[selectedIndex],
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      width: size.width - 8,
                      height: size.height - 20,
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
                Positioned(
                  top: size.height / 2.1,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        selectedIndex = selectedIndex - 1;
                        if (selectedIndex == -1) {
                          selectedIndex = widget.imagesUrls.length - 1;
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: size.height / 2.1,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        selectedIndex = selectedIndex + 1;
                        if (selectedIndex == widget.imagesUrls.length) {
                          selectedIndex = 0;
                        }
                        setState(() {});
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showImage({BuildContext context, List<String> imagesUrls, int index}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return ImagesSwitcherNew(
          imagesUrls: imagesUrls,
          index: index,
        );
      },
    ),
  );
}

class OptionsIcons extends StatefulWidget {
  final Map<String, dynamic> productMap;

  OptionsIcons({Key key, this.productMap}) : super(key: key);

  @override
  _OptionsIconsState createState() => _OptionsIconsState();
}

class _OptionsIconsState extends State<OptionsIcons> {
  bool check = false;

  String action = "";

  bool _isProcessing = false;

  bool checkIfItIsYourProduct = false;

  @override
  void initState() {
    String id =
        Provider.of<AuthDataProvider>(context, listen: false).currentUser.id;
    if (widget.productMap["vendorId"].toString() == id) {
      checkIfItIsYourProduct = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FavoriteStar(
            product: widget.productMap["value"],
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.grey[800],
              size: 35,
            ),
            onPressed: () async {
              final String productPermalink =
                  widget.productMap["value"].permalink;

              if (productPermalink == null) {
                return;
              } else {
                print("Product ID To Share == ");
                print(widget.productMap["value"].id.toString());
                final productDynamicLink =
                    await Provider.of<DynamicLinksProvider>(context,
                            listen: false)
                        .createAndGetDynamicLink(
                  itemId: widget.productMap["value"].id.toString(),
                  itemName: widget.productMap["value"].name,
                  itemUrl: widget.productMap["value"].images.length == 0
                      ? Uri.parse(
                          "https://firebasestorage.googleapis.com/v0/b/w3d-app.appspot.com/o/login.png?alt=media&token=f9a3d494-6502-4065-8b69-a80f716eef6f")
                      : Uri.parse(widget.productMap["value"].images[0].src),
                );

                await Share.share(
                  productDynamicLink,
                );
              }
            },
          ),
          checkIfItIsYourProduct
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey[800],
                        size: 35,
                      ),
                      onPressed: () async {
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new UpdateProductScreen(
                              product: widget.productMap["value"],
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.grey[800],
                        size: 35,
                      ),
                      onPressed: () async {
                        if (_isProcessing) {
                          return;
                        }

                        String choice = await showAlertYesOrNo(
                          context: context,
                          title: "???? ???????? ?????? ???????????? ??",
                        );

                        if (choice == "no") {
                          // Nothing to do
                        } else if (choice == "yes") {
                          showTopSnackBar(
                            context: context,
                            title: "?????????? ??????????",
                            body: "???????? ?????? ????????????",
                          );

                          _isProcessing = true;

                          String output =
                              await Provider.of<ManageProductsProvider>(
                            context,
                            listen: false,
                          ).deleteProduct(
                            productId: widget.productMap["value"].id.toString(),
                          );

                          if (output == null) {
                            Navigator.of(context).pop();
                            showTopSnackBar(
                              context: context,
                              title: "????????",
                              body: "???? ?????? ???????????? ??????????",
                            );
                            Provider.of<ProductsProvider>(context,
                                    listen: false)
                                .removeProductById(
                              productId: widget.productMap["value"].id,
                            );
                          } else {
                            showTopSnackBar(
                              context: context,
                              title: "??????????",
                              body: "?????? ?????? ?????? ???? ???????? ???????? ?????? ????????",
                            );
                          }
                        }

                        _isProcessing = false;
                      },
                    ),
                  ],
                )
              : Container(),
        ],
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

          action = "?????? ?????? ???????????? ???? ??????????????";
        } else {
          await Provider.of<FavouritesProvider>(context, listen: false)
              .addFavouriteProduct(
            productId: widget.product.id,
          );
          action = "?????? ?????????? ???????????? ?????? ??????????????";
        }
        showTopSnackBar(
          context: context,
          body: action,
          title: "????????",
        );

        setState(() {
          _isFavorite = !_isFavorite;
        });

        _isProcessing = false;
      },
    );
  }
}
