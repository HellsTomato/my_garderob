import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/functions/photo_page_dop.dart';
import 'package:my_garderob/pages/create_photo/photo_page.dart';
import 'package:my_garderob/resources/clothersfolders.dart';
import 'package:my_garderob/pages/create_photo/photo_page.dart';
class ChoicedPage extends StatelessWidget {
  final String bodyPart;
  const ChoicedPage({super.key, required this.bodyPart});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: GarderobColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text('Choose Type:', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),),
            ),
            Padding(
                padding: EdgeInsets.only(top: 75),
                child: ChoicedContent(bodyPart: bodyPart)),
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

class ChoicedContent extends StatelessWidget {
  final bodyPart;

  const ChoicedContent({super.key, this.bodyPart});
//Пор
  @override
  Widget build(BuildContext context) {
    switch (bodyPart) {
      case "Head":
        return BodyPartList(bodypart: AddedClother.head);
      case "Torso":
        return BodyPartList(bodypart: AddedClother.torso);
      case "Legs":
        return BodyPartList(bodypart: AddedClother.legs);
      case "Feet":
        return BodyPartList(bodypart: AddedClother.feet);
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

class BodyPartList extends StatelessWidget {
  final Map<String, int> bodypart;
  const BodyPartList({super.key, required this.bodypart});

  @override
  Widget build(BuildContext context) {
    List<String> keys = bodypart.keys.toList();
    return Align(
      alignment: Alignment.centerRight,
      child: ListView.builder(
        itemCount: bodypart.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 75, right: 5, top: 2, bottom: 2),
            child: GestureDetector(
              onTap: (){
                //отправляем с контекством название элемента одежды на предыдущую страницу
                Navigator.pop(context, keys[index.toInt()]);},
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
            ),
          );
        },
      ),
    );
  }
}

