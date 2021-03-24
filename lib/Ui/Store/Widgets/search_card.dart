import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchCard extends StatelessWidget {
  ValueChanged<String> onChange;
  SearchCard({this.onChange});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 12,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextField(
            style: TextStyle(
              fontSize: 18,
            ),
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 2,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: "Search about anything!",
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              helperMaxLines: 2,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            onChanged: onChange,
          ),
        ),
      ),
    );
  }
}
