import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_garderob/bloc/photo_bloc.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/widgets/back_buttom.dart';

class OpenType extends StatelessWidget {
  final addedClotherListFromServer;
  final filterIndexes;
  final filterValue;
  final indexRightNow;
  final bodyPart;

  const OpenType({
    super.key,
    required this.filterIndexes,
    this.addedClotherListFromServer,
    required this.filterValue,
    this.indexRightNow,
    required this.bodyPart,
  });

  @override
  Widget build(BuildContext context) {
    var rightFilterValues = searchRightFilter();
    var chetchik = -2;
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (BuildContext context, index) {
            print(index);
            chetchik += 2;
            if (chetchik >= rightFilterValues.length) {
              return SizedBox();
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PhotoContainerWidget(
                      chetchik: chetchik,
                      addedClotherList: addedClotherListFromServer,
                      filterIndexes: filterIndexes,
                      bodyPart: bodyPart,
                      rightFilterValues: rightFilterValues),
                  // если счетчик >= длине, то объекта с этим номером не существует
                  if ((chetchik + 1) >= rightFilterValues.length)
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 170,
                      ),
                    )
                  else
                    PhotoContainerWidget(
                        chetchik: (chetchik + 1),
                        addedClotherList: addedClotherListFromServer,
                        filterIndexes: filterIndexes,
                        bodyPart: bodyPart,
                        rightFilterValues: rightFilterValues),
                ],
              );
            }

            //   else{return SizedBox();}
          },
          itemCount: rightFilterValues.length,
        ),
      ),
    );

  }

  List searchRightFilter() {
    var result = [];
    var i = 0;
    while (i < filterIndexes.length) {
      if (addedClotherListFromServer[filterValue][filterIndexes[i]] ==
          indexRightNow) {
        result.add(filterIndexes[i]);
      }
      i += 1;
    }
    return result;
  }
}

class PhotoContainerWidget extends StatelessWidget {
  final bodyPart;
  final addedClotherList;
  final filterIndexes;
  final chetchik;
  final rightFilterValues;

  const PhotoContainerWidget({
    super.key,
    required this.chetchik,
    required this.addedClotherList,
    required this.filterIndexes,
    required this.bodyPart,
    required this.rightFilterValues,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        sendToRoomPage(
            addedClotherList['image'][rightFilterValues[chetchik]], bodyPart);
        Navigator.pushNamed(context, '/RoomPage');
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white10,
            border: Border.all(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(6)),
        width: 170,
        height: 170,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Colors.black,
                )),
            Align(
                alignment: Alignment.center,
                child: Image.network(
                  addedClotherList['image'][rightFilterValues[chetchik]],
                  fit: BoxFit.contain,
                )),
          ],
        ),
      ),
    );
  }

  void sendToRoomPage(path, bodyPart) {
    switch (bodyPart) {
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
}
