import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts_arabic/fonts.dart';

class InputDoubleCard extends StatefulWidget {
  final String type;
  final String initialText1;

  final ValueChanged<String> onChangeFirst;

  InputDoubleCard({
    Key key,
    this.type,
    this.onChangeFirst,
    this.initialText1,
  }) : super(key: key);

  @override
  _InputDoubleCardState createState() => _InputDoubleCardState();
}

class _InputDoubleCardState extends State<InputDoubleCard> {
  TextEditingController _controller1;

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController(text: widget.initialText1);
  }

  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 2,
            ),
            child: Text(
              "ر.س ",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              textScaleFactor: 1,
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            width: 120,
            child: Card(
              color: Colors.blueGrey[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _controller1,
                onChanged: widget.onChangeFirst,
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.multiline,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: 2,
            ),
            child: Text(
              widget.type + " : ",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              textScaleFactor: 1,
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
