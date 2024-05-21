import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_garderob/bloc/photo_bloc.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/pages/room_page.dart';
import 'package:rxdart/rxdart.dart';

class OpenType extends StatelessWidget {
  final bodyPart;
  final addedClotherList;
  final type;

  const OpenType({super.key, this.addedClotherList, this.type, this.bodyPart});

  @override
  Widget build(BuildContext context) {
    List<int> indexTypesClother = _getIndexRightType();
    return Scaffold(
      backgroundColor: GarderobColors.background,
      body: SafeArea(
        child: ListView.builder(
          itemCount: indexTypesClother.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                sendToRoomPage(addedClotherList['image'][indexTypesClother[index]]);
                Navigator.pushNamed(context, '/RoomPage'
                  //, arguments: [addedClotherList['image']
                  //     [indexTypesClother[index]], bodyPart]
                );
              },
              child: Container(
                padding: EdgeInsets.only(top: 5),
                height: 200,
                width: 200,
                child: Image.network(
                    addedClotherList['image'][indexTypesClother[index]]),
              ),
            );
          },
        ),
      ),
    );
  }
  void sendToRoomPage(path){
    switch(bodyPart){
      case "Head":
        SavePhotoToRoom.headController.add(path);
      case "Torso":
        SavePhotoToRoom.torsoController.add(path);
      case "Legs":
        SavePhotoToRoom.legsController.add(path);
      case "Feet":
        SavePhotoToRoom.feetController.add(path);
    }

  }

  List<int> _getIndexRightType() {
    List<int> result = [];
    int index = 0;
    for (var i in addedClotherList["typeClothes"]) {
      if (i == type) {
        result.add(index);
      }
      index += 1;
    }
    return result;
  }
}
