import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/garderob_colors.dart';

class BackActionButtom extends StatelessWidget {
  final VoidCallback onTap;

  const BackActionButtom({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 40,
          child: Icon(Icons.arrow_back_sharp)),
    );
  }
}
