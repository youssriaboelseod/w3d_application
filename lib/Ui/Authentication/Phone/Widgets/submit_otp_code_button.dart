import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class SubmitButton extends StatefulWidget {
  final String title;
  final Function submitFn;

  SubmitButton({this.submitFn, this.title});
  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _isLoading = false;

  void resetLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFF416D6D),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Color(0xFF416d6d),
                child: FlatButton(
                  child: Text(
                    widget.title,
                    textScaleFactor: 1,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      _isLoading = true;
                    });

                    await widget.submitFn(context);

                    setState(() {
                      _isLoading = false;
                    });
                  },
                ),
              ),
            ),
          );
  }
}
