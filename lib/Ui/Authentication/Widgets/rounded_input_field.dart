import 'package:flutter/material.dart';
import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextInputType textInputType;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.focusNode,
    this.nextFocusNode,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        focusNode: focusNode,
        textInputAction: nextFocusNode != null
            ? TextInputAction.next
            : (nextFocusNode ?? TextInputAction.done),
        onChanged: onChanged,
        cursorColor: Color(0xFF140035),
        keyboardType: textInputType,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontSize: 18,
        ),
        decoration: InputDecoration(
          suffixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
