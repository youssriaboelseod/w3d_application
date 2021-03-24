import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  final String initialText;
  final bool readOnly;
  final Function callSetState;
  final IconData prefixIcon;
  final String title;
  final String hintText;

  final ValueChanged<String> onChanged;
  InputField({
    Key key,
    this.initialText,
    this.readOnly,
    this.onChanged,
    this.prefixIcon,
    this.title,
    this.callSetState,
    this.hintText,
  }) : super(key: key);
  TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = TextEditingController(text: initialText);

    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
    return Align(
      alignment: Alignment.centerRight,
      child: TextField(
        controller: _controller,
        onChanged: onChanged,
        readOnly: readOnly,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hintText ?? null,
          suffix: Text(
            "$title :  ",
            textScaleFactor: 1,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          border: InputBorder.none,
          suffixIcon: Icon(
            this.prefixIcon,
            color: Colors.black,
            size: 18,
          ),
        ),
      ),
    );
  }
}
