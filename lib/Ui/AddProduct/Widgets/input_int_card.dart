import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputIntCard extends StatefulWidget {
  final String type;
  final String initialText;
  final ValueChanged<String> onChange;

  InputIntCard({
    Key key,
    this.type,
    this.initialText,
    this.onChange,
  }) : super(key: key);

  @override
  _InputIntCardState createState() => _InputIntCardState();
}

class _InputIntCardState extends State<InputIntCard> {
  TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
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
          Container(
            margin: EdgeInsets.only(
              right: 2,
            ),
            child: Text(
              widget.type + " : ",
              textScaleFactor: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
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
                  style: TextStyle(
                    fontSize: 18,
                  ),
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
                      left: 12,
                      top: 8,
                      bottom: 8,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
