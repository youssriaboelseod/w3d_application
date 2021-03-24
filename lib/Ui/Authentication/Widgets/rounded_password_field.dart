import 'package:flutter/material.dart';
import 'text_field_container.dart';
import '../constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  RoundedPasswordField({
    Key key,
    this.onChanged,
    this.hintText,
    this.focusNode,
    this.nextFocusNode,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        focusNode: widget.focusNode,
        textInputAction: widget.nextFocusNode != null
            ? TextInputAction.next
            : (widget.nextFocusNode ?? TextInputAction.done),
        obscureText: _hidePassword,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontSize: 18,
        ),
        onChanged: widget.onChanged,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: GestureDetector(
            onTap: () {
              setState(() {
                _hidePassword = !_hidePassword;
              });
            },
            child: Icon(
              Icons.visibility,
              color: Colors.black,
            ),
          ),
          suffixIcon: Icon(
            Icons.lock,
            color: Colors.black,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
