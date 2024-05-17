import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/physics.dart';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/functions/server_api.dart';
import 'package:my_garderob/pages/create_photo/choice_type_page.dart';
import 'package:my_garderob/resources/clothersfolders.dart';
import 'package:my_garderob/widgets/back_buttom.dart';

import '../../functions/photo_page_dop.dart';
import '../room_page.dart';
import 'loading_page.dart';

//то что показывается и отправляются на сервер
var _seasonValue = "Multi";
var _colorValue = "Multi";
var typeValue = '';
var _error = false;

class PhotoPage extends StatefulWidget {
  final String bodyPart;
  final File imageFile;

  const PhotoPage({
    super.key,
    required this.bodyPart,
    required this.imageFile,
  });

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  late File imageFile;
  late String bodyPart;

  // late bool fromCameraMen;
  @override
  void initState() {
    super.initState();
    //Для использования в State
    bodyPart = widget.bodyPart;
    imageFile = widget.imageFile;
  }

  @override
  Widget build(BuildContext context) {
    final String type;
    final _ChoicedTypeWidgetState? state =
    context.findAncestorStateOfType<_ChoicedTypeWidgetState>();
    if (state == null) {
      type = "Change";
    } else {
      type = state.choicedType;
    }
    return Scaffold(
      backgroundColor: GarderobColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: BackActionButtom(
                  onTap: () {
                    Navigator.pop(context);
                  },
                )),
            Column(children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.black, width: 2))),
                child: Image.file(
                  imageFile,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 50),
//Кнопка сезонов
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
//Кнопка цветов
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
//Кнопка типа
              ChoicedTypeWidget(bodyPart: bodyPart),
              SizedBox(
                height: 20,
              ),
            ]),
            SaveBotton(
              onTap: () {
                if (typeValue == "Change" || typeValue == ""){
                  setState(() {
                    _error = true;
                  });
                }
                else{
                Navigator.of((context)).push(MaterialPageRoute(
                    builder: (context) =>
                        SaveLoadingPage(
                          seasonValue: _seasonValue,
                          colorValue: _colorValue,
                          typeValue: typeValue,
                          bodyPart: bodyPart,
                          imageFile: imageFile,
                        )));}
              },
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
}

class ChoicedTypeWidget extends StatefulWidget {
  const ChoicedTypeWidget({
    super.key,
    required this.bodyPart,
  });

  final String bodyPart;

  @override
  State<ChoicedTypeWidget> createState() => _ChoicedTypeWidgetState();
}

class _ChoicedTypeWidgetState extends State<ChoicedTypeWidget> {
  @override
  void initState() {
    super.initState();
  }

  var choicedType = "Change";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 279,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: _error ? Colors.red : Colors.black, width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Row(
          children: [
            Text("Type: ",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
            Expanded(child: SizedBox()),
            GestureDetector(

              //Получаем String значение от ChoicedPage для того что бы отображать что выбрал пользователь
                onTap: () async {
                  final result = await Navigator.of(context)
                      .push<String>(MaterialPageRoute(
                      builder: (context,) =>
                          ChoicedPage(
                            bodyPart: widget.bodyPart,
                          )));
                  setState(() {
                    _error = false;
                    choicedType = result! as String;
                    typeValue = choicedType;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 49,
                  width: 200,
                  child: Row(
                    children: [
                      Expanded(child: SizedBox()),
                      Text(choicedType,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20)),
                      SizedBox(
                        width: 2,
                      ),
                      Icon(Icons.menu)
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class SaveBotton extends StatelessWidget {
  final VoidCallback onTap;

  const SaveBotton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 78),
        child: GestureDetector(
          onTap: onTap,
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


