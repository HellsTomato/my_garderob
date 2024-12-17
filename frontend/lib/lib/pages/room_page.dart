import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/pages/catalog_page.dart';
import 'package:my_garderob/widgets/back_buttom.dart';
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
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    (SafePhoto.photohead != "") ? ImageContainer(ImagePath: SafePhoto.photohead, onTap: (){}) :
                    IconWidget(
                      height: 100.0,
                      ImagePath:ImageClother.iconHat,
                      onTap: () => _teleportTo(CatalogState.head),
                    ),
                    IconWidget(
                      height: 200.0,
                      ImagePath: ImageClother.iconPolo,
                      onTap: () => _teleportTo(CatalogState.torso),
                    ),
                    IconWidget(
                      height: 250.0,
                      ImagePath: ImageClother.iconPants,
                      onTap: () => _teleportTo(CatalogState.legs),
                    ),
                    IconWidget(
                        height: 100.0,
                        ImagePath: ImageClother.iconShoose,
                        onTap: () => _teleportTo(CatalogState.feet)),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _teleportTo(final bodyPart) {
    Navigator.of((context)).push(MaterialPageRoute(
        builder: (context) => CatalogPage(
              bodyPart: bodyPart,
            )));
  }
}
