import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/clothersfolders.dart';

class DropDownMenues {
  DropDownMenues._();

  static const seasonsDropDownList = [
    DropdownMenuItem(
      child: Text("Winter"),
      value: "Winter",
    ),
    DropdownMenuItem(
      child: Text("Spring"),
      value: "Spring",
    ),
    DropdownMenuItem(
      child: Text("Summer"),
      value: "Summer",
    ),
    DropdownMenuItem(
      child: Text("Autumn"),
      value: "Autumn",
    ),
    DropdownMenuItem(
      child: Text("Multi"),
      value: "Multi",
    ),
  ];
  static const colorsDropDownList = [
    DropdownMenuItem(
      child: Text("White"),
      value: "White",
    ),
    DropdownMenuItem(
      child: Text("Black"),
      value: "Black",
    ),
    DropdownMenuItem(
      child: Text("Red"),
      value: "Red",
    ),
    DropdownMenuItem(
      child: Text("Yellow"),
      value: "Yellow",
    ),
    DropdownMenuItem(
      child: Text("Green"),
      value: "Green",
    ),
    DropdownMenuItem(
      child: Text("Blue"),
      value: "Blue",
    ),
    DropdownMenuItem(
      child: Text("Orange"),
      value: "Orange",
    ),
    DropdownMenuItem(
      child: Text("Purple"),
      value: "Purple",
    ),
    DropdownMenuItem(
      child: Text("Multi"),
      value: "Multi",
    ),
    DropdownMenuItem(
      child: Text("Brown"),
      value: "Brown",
    ),
  ];
  static List<DropdownMenuItem<String>> typeHeadList = AddedClother.head.keys
      .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();
  static List<DropdownMenuItem<String>> typeTorsoList = AddedClother.torso.keys
      .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();
  static List<DropdownMenuItem<String>> typeLegsList = AddedClother.legs.keys
      .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();
  static List<DropdownMenuItem<String>> typeFeetList = AddedClother.feet.keys
      .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();


  static const filterDropDownList = [
    DropdownMenuItem(
      child: Text("Type"),
      value: "typeClothes",
    ),
    DropdownMenuItem(
      child: Text("Color"),
      value: "colors",
    ),
    DropdownMenuItem(
      child: Text("Season"),
      value: "season",
    ),
  ];
}

class IdServer {
  static const season = {
    "Winter": 1,
    "Spring": 2,
    "Summer": 3,
    "Autumn": 4,
    "Multi": 5,
  };

  static const seasonReverse = {1: "Winter", 2: "Spring", 3: "Summer", 4: "Autumn", 5: "Multi"};
  static const color = {
    "White": 1,
    "Black": 2,
    "Red": 3,
    "Yellow": 4,
    "Green": 5,
    "Blue": 6,
    "Orange": 7,
    "Purple": 8,
    "Multi": 9,
    "Brown": 10,
  };
  static const colorReverse = {1: "White", 2: "Black", 3: "Red", 4: "Yellow", 5: "Green", 6: "Blue", 7: "Orange", 8: "Purple", 9: "Multi", 10: "Brown"};


}
