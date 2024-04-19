import 'package:flutter/material.dart';

enum CatalogState { head, torso, legs, feet }

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
}

