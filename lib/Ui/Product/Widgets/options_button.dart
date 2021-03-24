import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class OptionsButton extends StatefulWidget {
  final String title;
  final List<String> options;
  final ValueChanged<String> onChangeValue;

  OptionsButton({Key key, this.title, this.options, this.onChangeValue})
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
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
    );
  }
}
