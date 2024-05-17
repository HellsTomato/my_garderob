import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/pages/catalog_page.dart';
import 'package:my_garderob/pages/entry_pages/entrance_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../functions/photo_page_dop.dart';
import '../resources/image_clother.dart';
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
  Widget build(BuildContext context) {
//Не пускает пользователя в поле регистрации
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
                        IconWidget(
                          height: 100.0,
                          ImagePath: ImageClother.iconHat,
                          onTap: () =>
                              _teleportToCatalogPage("Head"),
                          addWidget: AddWidget(bodyPart: "Head"),
                        ),
                        IconWidget(
                          height: 200.0,
                          ImagePath: ImageClother.iconPolo,
                          onTap: () =>
                              _teleportToCatalogPage("Torso"),
                          addWidget: AddWidget(bodyPart: "Torso"),
                        ),
                        IconWidget(
                          height: 250.0,
                          ImagePath: ImageClother.iconPants,
                          onTap: () =>
                              _teleportToCatalogPage("Legs"),
                          addWidget: AddWidget(bodyPart: "Legs"),
                        ),
                        IconWidget(
                          height: 100.0,
                          ImagePath: ImageClother.iconShoose,
                          onTap: () =>
                              _teleportToCatalogPage("Feet"),
                          addWidget: AddWidget(bodyPart: "Feet"),
                        ),
                      ],
                    ),
                  ),
                ),
                //TODO убрать
                Align(
                  alignment: Alignment.topLeft,
                  child: DeleteButtom(),
                )
              ],
            ),
          ),
        ));
  }

  void _teleportToCatalogPage(final bodyPart) {
    Navigator.of((context)).push(MaterialPageRoute(
        builder: (context) => CatalogPage(
              bodyPart: bodyPart,
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
        print("Delete");
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('text');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EntrancePage()));
      },
      child: Container(
        height: 30,
        width: 30,
        child: Icon(Icons.menu),
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  final height;
  final String ImagePath;
  final VoidCallback onTap;
  final Widget addWidget;

  const IconWidget(
      {super.key,
      required this.height,
      required this.ImagePath,
      required this.onTap,
      required this.addWidget});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: height,
          width: double.infinity,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Align(alignment: Alignment.center, child: Image.asset(ImagePath)),
              Align(alignment: Alignment.topRight, child: addWidget)
            ],
          )),
    );
  }
}

class AddWidget extends StatelessWidget {
  const AddWidget({
    super.key,
    required this.bodyPart,
  });

  final String bodyPart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of((context)).push(MaterialPageRoute(
          builder: (context) => CameraMen(bodyPart: bodyPart))),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 2)),
        child: Icon(Icons.add, size: 40),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  final height;
  final String ImagePath;
  final VoidCallback onTap;

  const ImageContainer(
      {super.key, this.height, required this.ImagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: height,
          width: double.infinity,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Image.file(File(ImagePath))),
            ],
          )),
    );
  }
}
