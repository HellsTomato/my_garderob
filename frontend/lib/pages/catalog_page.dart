import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/functions/photo_page_dop.dart';
import 'package:my_garderob/pages/product_page.dart';
import 'package:my_garderob/resources/clothersfolders.dart';
import 'package:my_garderob/widgets/back_buttom.dart';

class CatalogPage extends StatelessWidget {
  final String bodyPart;
  final addedClother;

  const CatalogPage(
      {super.key, required this.bodyPart, required this.addedClother});

  //Сделать переход addedClotherList до конца
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GarderobColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Choose your look:',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 80),
                child: FutureBuilder(
                  future: addedClother,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ){
                      return CircularProgressIndicator(color: Colors.black);
                    }
                    if (snapshot.hasError){
                      return Center(
                        child: Text("Please, Check Your Internet Connection",style: TextStyle(
                            color: Color(0xFF203531),
                            fontSize: 11,
                            fontWeight: FontWeight.w800),),
                      );
                    }
                    return CatalogContent(
                      bodyPart: bodyPart,
                      addedClother: snapshot.data!,
                    );
                  },
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: BackActionButtom(onTap: (){Navigator.pop(context);},),
                )),
          ],
        ),
      ),
    );
  }
}

class CatalogContent extends StatelessWidget {
  final addedClother;
  final bodyPart;

  const CatalogContent({super.key, this.bodyPart, this.addedClother});

//Пор
  @override
  Widget build(BuildContext context) {
    switch (bodyPart) {
      case "Head":
        return BodyPart(
          addedClotherRevers: AddedClother.head.map((k, v) => MapEntry(v, k)),
          addedClotherListFromServer: addedClother, bodyPart: 'Head',
        );
      case "Torso":
        return BodyPart(
          addedClotherRevers: AddedClother.torso.map((k, v) => MapEntry(v, k)),
          addedClotherListFromServer: addedClother, bodyPart: 'Torso',
        );
      case "Legs":
        return BodyPart(
          addedClotherRevers: AddedClother.legs.map((k, v) => MapEntry(v, k)),
          addedClotherListFromServer: addedClother, bodyPart: 'Legs',
        );
      case "Feet":
        return BodyPart(
          addedClotherRevers: AddedClother.feet.map((k, v) => MapEntry(v, k)),
          addedClotherListFromServer: addedClother, bodyPart: 'Feet',
        );
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
  final String bodyPart;
  final addedClotherListFromServer;
  final addedClotherRevers;

  const BodyPart(
      {super.key,
      required this.addedClotherRevers,
      required this.addedClotherListFromServer, required this.bodyPart});

  @override
  Widget build(BuildContext context) {
    final typeClother = addedClotherListFromServer["typeClothes"];
    List<int> typeClotherUnique = [];
    for (var i in typeClother){
      if(!typeClotherUnique.contains(i)){
        typeClotherUnique.add(i);
      }

    }

    return Align(
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: typeClotherUnique.length,
        itemBuilder: (BuildContext context, int index) {
          if (addedClotherRevers[typeClotherUnique[index]] != null) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 2),
              child: GestureDetector(
                onTap: () {
                  print(typeClotherUnique[index]);
                  Navigator.of((context)).push(MaterialPageRoute(
                    builder: (context) => OpenType(bodyPart: bodyPart, addedClotherList: addedClotherListFromServer, type: typeClotherUnique[index])));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    addedClotherRevers[typeClotherUnique[index]],
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
