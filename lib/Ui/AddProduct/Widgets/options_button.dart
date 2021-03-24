import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class OptionsButton extends StatefulWidget {
  final String type;
  final List<String> options;
  final ValueChanged<String> onChangeValue;

  OptionsButton({Key key, this.type, this.options, this.onChangeValue})
      : super(key: key);

  @override
  _OptionsButtonState createState() => _OptionsButtonState();
}

class _OptionsButtonState extends State<OptionsButton> {
  String dropdownValue;
  @override
  void initState() {
    super.initState();
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
            padding: EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                12,
              ),
              color: Colors.black,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButton<String>(
                hint: Text(
                  "اختر القسم",
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
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                  widget.onChangeValue(newValue);
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
          Container(
            margin: EdgeInsets.only(
              right: 2,
            ),
            child: Text(
              widget.type + " : ",
              textScaleFactor: 1,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
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
