import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import '../Functions/get_variation_price.dart';
import 'package:woocommerce/models/products.dart';

class OptionsButton extends StatefulWidget {
  final String title;
  final WooProduct productModel;
  final List<String> options;
  final ValueChanged<String> onChangeValue;
  final ValueChanged<String> onChangePrice;
  final ValueChanged<String> onChangeRegularPrice;

  OptionsButton({
    Key key,
    this.title,
    this.options,
    this.onChangeValue,
    this.productModel,
    this.onChangePrice,
    this.onChangeRegularPrice,
  }) : super(key: key);

  @override
  _OptionsButtonState createState() => _OptionsButtonState();
}

class _OptionsButtonState extends State<OptionsButton> {
  String dropdownValue;
  @override
  void initState() {
    super.initState();
  }

  bool _isLoading = false;
  String price = "";
  String regularPrice = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 2,
                  bottom: 2,
                  right: 20,
                  left: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                  color: Colors.black,
                ),
                child: Directionality(
                  // add this
                  textDirection: TextDirection.rtl,
                  child: DropdownButton<String>(
                    hint: Text(
                      "تحديد احد الخيارات",
                      textScaleFactor: 1,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                      color: Colors.white,
                    ),
                    value: dropdownValue,
                    dropdownColor: Colors.grey[600],
                    elevation: 10,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    underline: Container(),
                    onChanged: (String newValue) async {
                      if (widget.title != "المقاس") {
                        setState(() {
                          dropdownValue = newValue;
                        });
                        widget.onChangeValue(newValue);
                        return;
                      }

                      setState(() {
                        _isLoading = true;
                        dropdownValue = newValue;
                      });

                      widget.onChangeValue(newValue);

                      // 491 = 490
                      // 490 = 990
                      //489 = 290
                      final output = await getVariationPrice(
                        context: context,
                        productId: widget.productModel.id.toString(),
                      );

                      // [{id: 5, name: المقاس, option: XL}]

                      if (output != null) {
                        print("output");
                        print(output);

                        output.forEach((e) {
                          print(e["attributes"].length);
                          if (e["attributes"].length != 0) {
                            if (dropdownValue ==
                                e["attributes"][0]["option"].toString()) {
                              price = e["price"].toString();
                              regularPrice = e["regular_price"].toString();
                              widget.onChangePrice(price);
                              widget.onChangeRegularPrice(regularPrice);
                            }
                          }
                        });
                      }

                      setState(() {
                        _isLoading = false;
                      });
                    },
                    items: widget.options
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                widget.title + " :",
                textScaleFactor: 1,
                textDirection: TextDirection.rtl,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          _isLoading
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.black,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
