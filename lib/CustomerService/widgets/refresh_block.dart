import 'package:flutter/material.dart';

class RefreshBlock extends StatelessWidget {
  final Function refresh;
  RefreshBlock(this.refresh);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "No internet connection",
                textScaleFactor: 1,
              ),
              SizedBox(
                height: 10,
              ),
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  size: 25,
                ),
                onPressed: () async {
                  await refresh();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
