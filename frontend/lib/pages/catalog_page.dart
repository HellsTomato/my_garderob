import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/functions/photo_page_dop.dart';
import 'package:my_garderob/resources/clothersfolders.dart';

class CatalogPage extends StatelessWidget {
  final String bodyPart;
  const CatalogPage({super.key, required this.bodyPart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GarderobColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text('Choose your look:', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),),
            ),
            Padding(
                padding: EdgeInsets.only(top: 80),
                child: CatalogContent(bodyPart: bodyPart)),
            Align(alignment: Alignment.topLeft, child: Padding(
              padding: EdgeInsets.only(top: 7),
              child: BackButton(),
            )),
          ],
        ),
      ),
    );
  }
}

class CatalogContent extends StatelessWidget {
  final bodyPart;

  const CatalogContent({super.key, this.bodyPart});
//Пор
  @override
  Widget build(BuildContext context) {
    switch (bodyPart) {
      case "Head":
        return BodyPart(bodypart: AddedClother.head);
      case "Torso":
        return BodyPart(bodypart: AddedClother.torso);
      case "Legs":
        return BodyPart(bodypart: AddedClother.legs);
      case "Feet":
        return BodyPart(bodypart: AddedClother.feet);
      default:
        return Center(
            child: ColoredBox(
                color: Colors.yellowAccent,
                child: SizedBox(
                    height: 100,
                    width: 200,
                    child: Center(child: Text('Error')))));
    }
  }
}

class BodyPart extends StatelessWidget {
  final Map<String, int> bodypart;

  const BodyPart({super.key, required this.bodypart});

  @override
  Widget build(BuildContext context) {
    List<String> keys = bodypart.keys.toList();
    return Align(
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: bodypart.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 2),
            child: Container(
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(6)),
              child: Text(
                keys[index.toInt()],
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}
