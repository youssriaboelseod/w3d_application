import 'package:flutter/material.dart';

class QuantityCard extends StatefulWidget {
  final Function onIncreament;
  final Function onDecreament;
  final ValueChanged<int> onChangeValue;

  const QuantityCard(
      {Key key, this.onIncreament, this.onDecreament, this.onChangeValue})
      : super(key: key);

  @override
  _QuantityCardState createState() => _QuantityCardState();
}

class _QuantityCardState extends State<QuantityCard> {
  int quantityValue = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "الكمية",
              textScaleFactor: 1,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 35,
                ),
                onPressed: () {
                  setState(() {
                    quantityValue += 1;
                  });
                  widget.onChangeValue(quantityValue);
                },
              ),
              SizedBox(
                width: 8,
              ),
              Card(
                elevation: 3,
                child: Container(
                  width: 60,
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    quantityValue.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textScaleFactor: 1,
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              IconButton(
                icon: Icon(
                  Icons.remove_circle_outline,
                  size: 35,
                ),
                onPressed: () {
                  if (quantityValue - 1 < 1) {
                    return;
                  }

                  setState(() {
                    quantityValue -= 1;
                  });
                  widget.onChangeValue(quantityValue);
                },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
