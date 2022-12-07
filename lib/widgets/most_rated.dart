import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

class MostRated extends StatelessWidget {
  const MostRated({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Stack(children: [
          Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            width: constraints.maxWidth * 0.55,
            height: constraints.maxHeight * 0.45,
            child: FittedBox(
              alignment: Alignment.topLeft,
              child: Text(
                "Most Bought\nFood",
                maxLines: 2,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
          Positioned(
            right: constraints.maxWidth * 0.5,
            left: 0,
            bottom: constraints.maxHeight * 0.1,
            top: constraints.maxHeight * 0.45,
            child: FittedBox(
              alignment: Alignment.topLeft,
              child: Text(
                "Jollof rice with chicken,\nplaintain and salad",
                maxLines: 3,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),

          //flex: 2,
          Positioned(
            right: 0,
            bottom: constraints.maxHeight * 0.1,
            left: constraints.maxWidth * 0.5,
            top: constraints.maxHeight * 0.08,
            child: Image.network("https://i.ibb.co/vJv2WKz/Nigerian-Jollof-Rice-and-fried-plantains-removebg-preview.png"),
          ),
        ]);
      },
    );
  }
}
