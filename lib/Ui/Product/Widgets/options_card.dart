import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';

// paper size card سابقا

class OptionsCard extends StatefulWidget {
  final String title;
  final List<String> options;
  final ValueChanged<String> onChangeValue;

  const OptionsCard({Key key, this.onChangeValue, this.options, this.title})
      : super(key: key);

  @override
  _OptionsCardState createState() => _OptionsCardState();
}

class _OptionsCardState extends State<OptionsCard> {
  Color onChangeColorForBackground = Colors.grey;

  Color onChangeColorForText = Colors.white;
  int selectedIndex = 0;
  void select(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              widget.title,
              textScaleFactor: 1,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 80,
            width: size.width,
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  return Circle(
                    options: widget.options,
                    index: index,
                    select: select,
                    onChangeValue: widget.onChangeValue,
                    isSelected: selectedIndex == index ? true : false,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Circle extends StatelessWidget {
  final int index;
  final bool isSelected;
  final ValueChanged<int> select;
  final ValueChanged<String> onChangeValue;
  final List<String> options;

  Circle({
    Key key,
    this.index,
    this.select,
    this.onChangeValue,
    this.isSelected,
    this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 8,
        right: 5,
      ),
      child: GestureDetector(
        onTap: () {
          select(index);
          onChangeValue(options[index]);
        },
        child: CircleAvatar(
          backgroundColor: isSelected ? Colors.blueGrey[600] : Colors.black,
          radius: 30,
          child: CircleAvatar(
            radius: isSelected ? 27 : 29,
            backgroundColor: Colors.black,
            child: Text(
              options[index],
              textScaleFactor: 1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
