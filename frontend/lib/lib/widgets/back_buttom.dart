import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/garderob_colors.dart';

class BackActionButtom extends StatelessWidget {
  final String howPagePop;
  const BackActionButtom({super.key, required this.howPagePop});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch(howPagePop){
          case "back":
            Navigator.of(context).pop();
            break;
          case "RoomPage":
            Navigator.pushNamed(context, 'RoomPage');
        }

      },
      child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 40,
          child: Icon(Icons.arrow_back_sharp)),
    );
  }
}
