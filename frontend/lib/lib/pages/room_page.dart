import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/pages/catalog_page.dart';
import 'package:my_garderob/widgets/back_buttom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_garderob/widgets/widget_icons.dart';

import '../functions/bloc.dart';
import '../resources/clothersfolders.dart';
import '../resources/image_clother.dart';

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
                        // Показыавть только что сохраненную фотографию (Убрать)
                        (SafePhoto.photohead != "")
                            ? ImageContainer(
                                ImagePath: SafePhoto.photohead, onTap: () {})
                            : IconWidget(
                                height: 100.0,
                                ImagePath: ImageClother.iconHat,
                                onTap: () => _teleportToCatalogPage(CatalogState.head),
                              ),
                        IconWidget(
                          height: 200.0,
                          ImagePath: ImageClother.iconPolo,
                          onTap: () => _teleportToCatalogPage(CatalogState.torso),
                        ),
                        IconWidget(
                          height: 250.0,
                          ImagePath: ImageClother.iconPants,
                          onTap: () => _teleportToCatalogPage(CatalogState.legs),
                        ),
                        IconWidget(
                            height: 100.0,
                            ImagePath: ImageClother.iconShoose,
                            onTap: () => _teleportToCatalogPage(CatalogState.feet)),
                      ],
                    ),
                  ),
                ),
                //Кнопка для удаления токена входа
                //TODO убрать
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('text');
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      child: Icon(Icons.menu),
                    ),
                  ),
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
