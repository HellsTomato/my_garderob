import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_garderob/bloc/photo_bloc.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/pages/catalog_page.dart';
import 'package:my_garderob/pages/entry_pages/entrance_page.dart';
import 'package:my_garderob/resources/clothersfolders.dart';
import 'package:my_garderob/resources/image_clother.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:my_garderob/bloc/photo_bloc.dart';
import 'create_photo/camera_page.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _ImageRoomPageState();
}

class _ImageRoomPageState extends State<RoomPage> {
  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  @override
  Widget build(BuildContext context) {
    var addedClotherFormServer = _serverRequest();
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: GarderobColors.background,
          body: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PhotoWidgetContent(
                              height: 60.0,
                              bodyPart: BodyPartName.head,
                              onTap: () {
                                _teleportToCatalogPage(
                                    BodyPartName.head, addedClotherFormServer);
                              }),
                          PhotoWidgetContent(
                              height: 180.0,
                              bodyPart: BodyPartName.torso,
                              onTap: () {
                                _teleportToCatalogPage(
                                    BodyPartName.torso, addedClotherFormServer);
                              }),
                          PhotoWidgetContent(
                              height: 280.0,
                              bodyPart: BodyPartName.legs,
                              onTap: () {
                                _teleportToCatalogPage(
                                    BodyPartName.legs, addedClotherFormServer);
                              }),
                          PhotoWidgetContent(
                              height: 50.0,
                              bodyPart: BodyPartName.feet,
                              onTap: () {
                                _teleportToCatalogPage(
                                    BodyPartName.feet, addedClotherFormServer);
                              }),
                        ],
                      )),
                ),
                //TODO убрать
                Align(
                  alignment: Alignment.topLeft,
                  child: DeleteButtom(),
                ),
              ],
            ),
          ),
        ));
  }

  void _teleportToCatalogPage(final bodyPart, final addedClother) {
    Navigator.of((context)).push(MaterialPageRoute(
        builder: (context) => CatalogPage(
              bodyPart: bodyPart,
              addedClother: addedClother,
            )));
  }

  Future<Map> convertToCatalog(fList) async {
    final list = await fList;
    var id = [];
    var name = [];
    var image = [];
    var typeClothes = [];
    var season = [];
    var colors = [];
    for (var i in list) {
      id.add(i["id"]);
      name.add(i["name"]);
      image.add(i["image"]);
      typeClothes.add(i["type_clothes"]);
      season.add(i["season"]);
      colors.add(i["colors"]);
    }
    var result = {
      "id": id,
      "name": name,
      "image": image,
      "typeClothes": typeClothes,
      "season": season,
      "colors": colors
    };
    return result;
  }

  Future<Map> _serverRequest() async {
    final prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString("text");
    var headers = {
      'Authorization': 'Token $token',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse('http://6efba428f094.hosting.myjino.ru//clothes/'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      List<dynamic> list = json.decode(result);
      return await convertToCatalog(list);
    } else if (response.statusCode == 400 ||
        response.statusCode == 404 ||
        response.statusCode == 401) {
      throw "Error";
    } else {
      return {};
    }
  }
}

class PhotoWidgetContent extends StatelessWidget {
  final String bodyPart;
  final height;
  final VoidCallback onTap;

  const PhotoWidgetContent(
      {super.key,
      required this.height,
      required this.bodyPart,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    switch (bodyPart) {
      case BodyPartName.head:
        return StreamBuilder(
            stream: SavePhotoToRoom.headController,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.data! == '') {
                return IconWidget(
                  onTap: onTap,
                  height: 60.0,
                  iconPath: ImageClother.iconCap,
                  bodyPart: bodyPart,
                );
              } else {
                return ImageWidget(
                  ImagePath: snapshot.data!,
                  height: 100.0,
                  bodyPart: bodyPart,
                );
              }
            });

      case BodyPartName.torso:
        return StreamBuilder(
            stream: SavePhotoToRoom.torsoController,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.data! == '') {
                return IconWidget(
                  onTap: onTap,
                  height: 180.0,
                  iconPath: ImageClother.iconTshirt,
                  bodyPart: bodyPart,
                );
              } else {
                return ImageWidget(
                  ImagePath: snapshot.data!,
                  height: height,
                  bodyPart: bodyPart,
                );
              }
            });
      case BodyPartName.legs:
        return StreamBuilder(
            stream: SavePhotoToRoom.legsController,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.data! == '') {
                return IconWidget(
                  onTap: onTap,
                  height: 280.0,
                  iconPath: ImageClother.iconShtany,
                  bodyPart: bodyPart,
                );
              } else {
                return ImageWidget(
                  ImagePath: snapshot.data!,
                  height: height,
                  bodyPart: bodyPart,
                );
              }
            });
      case BodyPartName.feet:
        return StreamBuilder(
            stream: SavePhotoToRoom.feetController,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.data! == '') {
                return IconWidget(
                  onTap: onTap,
                  height: 50.0,
                  iconPath: ImageClother.iconKrosy,
                  bodyPart: bodyPart,
                );
              } else {
                return ImageWidget(
                  ImagePath: snapshot.data!,
                  height: 90.0,
                  bodyPart: bodyPart,
                );
              }
            });
    }
    return const Placeholder();
  }
}

class IconWidget extends StatelessWidget {
  final iconPath;
  final bodyPart;

  const IconWidget({
    super.key,
    required this.onTap,
    required this.height,
    required this.iconPath,
    required this.bodyPart,
  });

  final VoidCallback onTap;
  final height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            height: height,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    iconPath,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: AddWidget(
                    onTap: () {
                      Navigator.of((context)).push(MaterialPageRoute(
                          builder: (context) => CameraMen(bodyPart: bodyPart)));
                    },
                    delete: false,
                  ),
                )
              ],
            )));
  }
}

//Кнопка для удаления токена входа
class DeleteButtom extends StatelessWidget {
  const DeleteButtom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('text');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EntrancePage()));
        SavePhotoToRoom.headController.add('');
        SavePhotoToRoom.torsoController.add('');
        SavePhotoToRoom.legsController.add('');
        SavePhotoToRoom.feetController.add('');
      },
      child: Container(
        height: 30,
        width: 30,
        child: Icon(Icons.menu),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final bodyPart;
  final height;
  final String ImagePath;

  const ImageWidget(
      {super.key,
      this.height,
      required this.ImagePath,
      required this.bodyPart});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        // padding: EdgeInsets.all(2),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.network(ImagePath, fit: BoxFit.fitHeight),
            ),
            Align(
              alignment: Alignment.topRight,
              child: AddWidget(
                onTap: () {
                  deletePhotoClother(bodyPart);
                },
                delete: true,
              ),
            )
          ],
        ));
  }

  void deletePhotoClother(bodyPart) {
    switch (bodyPart) {
      case BodyPartName.head:
        SavePhotoToRoom.headController.add("");
      case BodyPartName.torso:
        SavePhotoToRoom.torsoController.add('');
      case BodyPartName.legs:
        SavePhotoToRoom.legsController.add('');
      case BodyPartName.feet:
        SavePhotoToRoom.feetController.add('');
    }
  }
}

class AddWidget extends StatelessWidget {
  final bool delete;

  const AddWidget({
    super.key,
    required this.onTap,
    required this.delete,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 2)),
        child: Icon(delete ? Icons.clear : Icons.add, size: 30),
      ),
    );
  }
}
