import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts_arabic/fonts.dart';

class AddToCartButton extends StatefulWidget {
  final Future Function() function;
  AddToCartButton({this.function});

  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _isLoading
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: SpinKitChasingDots(
              color: Colors.black,
            ),
          )
        : GestureDetector(
            onTap: () async {
              setState(() {
                _isLoading = true;
              });
              await widget.function();
              setState(() {
                _isLoading = false;
              });
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.blue,
              child: Container(
                width: size.width,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "اضف إلى السلة",
                      textScaleFactor: 1,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
