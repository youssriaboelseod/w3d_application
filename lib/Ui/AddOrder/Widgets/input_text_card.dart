import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class InputTextCard extends StatefulWidget {
  final String type;
  final String initialText;
  final String hintText;
  final ValueChanged<String> onChange;
  final bool readOnly;

  InputTextCard({
    Key key,
    this.type,
    this.initialText,
    this.hintText,
    this.onChange,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _InputTextCardState createState() => _InputTextCardState();
}

class _InputTextCardState extends State<InputTextCard> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    String textTemp = widget.initialText.isEmpty ? null : widget.initialText;
    _controller = TextEditingController(text: textTemp);
  }

  @override
  void dispose() {
    _controller.dispose();
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
        children: [
          Expanded(
            child: Container(
              child: Card(
                color: Colors.blueGrey[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _controller,
                  onChanged: widget.onChange,
                  readOnly: widget.readOnly,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 2,
                  decoration: InputDecoration(
                    helperMaxLines: 2,
                    hintText: widget.hintText,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      right: 12,
                      left: 8,
                      top: 8,
                      bottom: 8,
                    ),
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
              textScaleFactor: 1,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
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
