import 'package:flutter/material.dart';

class InputTextCard extends StatelessWidget {
  final String type;
  final String hintText;
  final ValueChanged<String> onChange;

  const InputTextCard({
    Key key,
    this.type,
    this.hintText,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.blueGrey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          onChanged: onChange,
          style: TextStyle(
            fontSize: 18,
          ),
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            helperMaxLines: 2,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(
              left: 12,
              top: 8,
              bottom: 8,
            ),
          ),
        ),
      ),
    );
  }
}
