import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/resources/clothersfolders.dart';
import 'package:my_garderob/resources/image_clother.dart';
import 'package:my_garderob/widgets/back_buttom.dart';

import '../functions/bloc.dart';

var _seasonValue = "Multi";
var _colorValue = "Multi";

class PhotoPage extends StatefulWidget {
  final String bodyPart;
  final String imageFile;

  const PhotoPage({super.key, required this.bodyPart, required this.imageFile});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  late String imageFile;

  // final typeClother = _chooseTypeClother(bodypart);

  // List<String> ClotherType = _chooseTypeClother(bodypart);

  @override
  void initState() {
    super.initState();
    //Для использования в State
    imageFile = widget.imageFile;
  }

  final TextEditingController seasonController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  late String selectValue;

  @override
  Widget build(BuildContext context) {
    print(widget.bodyPart);
    // print(typeClother);
    return Scaffold(
      backgroundColor: GarderobColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Align(
            //     alignment: Alignment.topLeft,
            //     child: BackActionButtom(
            //       howPagePop: "RoomPage",
            //     )),
            Column(children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.black, width: 2))),

//TODO CHANGE IN DEBAG

                child: Image.file(
                  File(imageFile),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 50),
              Container(
                height: 50,
                width: 279,
                decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.black, width: 1)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    children: [
                      Text("Season: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20)),
                      Expanded(child: SizedBox()),
                      DropdownButton(
                          items: DropDownMenues.seasonsDropDownList,
                          onChanged: (String? selectedValue) {
                            if (selectedValue is String) {
                              setState(() {
                                _seasonValue = selectedValue;
                              });
                            }
                          },
                          value: _seasonValue,
                          // style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                          icon: Icon(Icons.menu),
                          underline: Container(
                            color: GarderobColors.background,
                          ),
                          style: GoogleFonts.robotoSlab(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.black))),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 279,
                decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.black, width: 1)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    children: [
                      Text("Color: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20)),
                      Expanded(child: SizedBox()),
                      DropdownButton(
                          items: DropDownMenues.colorsDropDownList,
                          onChanged: (String? selectedValue) {
                            if (selectedValue is String) {
                              setState(() {
                                _colorValue = selectedValue;
                              });
                            }
                          },
                          value: _colorValue,
                          // style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                          icon: Icon(Icons.menu),
                          underline: Container(
                            color: GarderobColors.background,
                          ),
                          style: GoogleFonts.robotoSlab(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.black))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ]),
            SaveBotton(
              imageFile: imageFile,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: BackActionButtom(
                  onTap: () => Navigator.of(context).pop(),
                )),
          ],
        ),
      ),
    );
  }

//Тут есть попросик нужно перепроверить
//   List _bodypartClother() {
//       List<DropdownMenuItem<String>> dropdownItems = [];
//       //Вставить сюда список одежды(ориентируясь на bodypart)
//     for (String clother in ["", "", ""]) {
//       var newItem = DropdownMenuItem(
//         child: Text(clother),
//         value: clother,
//       );
//       dropdownItems.add(newItem);
//     }
//     return dropdownItems;
//   }
//Вспомнить тип бодипарта и сделать свитч кайс со списком видов одежды
}

List _chooseTypeClother(bodypart) {
  switch (bodypart) {
    case "Head":
      return AddedClother.head.keys.toList();
    case "Torso":
      return AddedClother.torso.keys.toList();
    case "Legs":
      return AddedClother.legs.keys.toList();
    case "Feet":
      return AddedClother.feet.keys.toList();
  }
  return [""];
}

class SaveBotton extends StatelessWidget {
  final imageFile;

  const SaveBotton({
    super.key,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 78),
        child: GestureDetector(
          onTap: () {
            SafePhoto.photohead = imageFile;
            Navigator.pushNamed(context, '/RoomPage');
          },
          child: Container(
            alignment: Alignment.center,
            height: 45,
            width: 279,
            decoration: BoxDecoration(
                color: Color(0xFF203531),
                borderRadius: BorderRadius.circular(40)),
            child: Text("Save",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }
}
