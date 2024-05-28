import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/functions/photo_page_dop.dart';
import 'package:my_garderob/pages/product_page.dart';
import 'package:my_garderob/resources/clothersfolders.dart';
import 'package:my_garderob/widgets/back_buttom.dart';

class CatalogPage extends StatefulWidget {
  final String bodyPart;
  final addedClother;

  const CatalogPage(
      {super.key, required this.bodyPart, required this.addedClother});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  //Сделать переход addedClotherList до конца

  String filter = 'typeClothes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GarderobColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(6)),
                margin: EdgeInsets.only(right: 10, top: 10),
                width: 110,
                height: 60,
                child: DropdownButton(
                    items: DropDownMenues.filterDropDownList,
                    onChanged: (String? selectedValue) {
                      if (selectedValue is String) {
                        setState(() {
                          filter = selectedValue;
                        });
                      }
                    },
                    value: filter,
                    // style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: GarderobColors.lines),
                    borderRadius: BorderRadius.circular(20),
                    style: GoogleFonts.robotoSlab(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: GarderobColors.lines))),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Choose:',
                        style: TextStyle(
                            color: GarderobColors.lines,
                            fontSize: 40,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 80),
                child: FutureBuilder(
                  future: widget.addedClother,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(color: Colors.black);
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Please, Check Your Internet Connection",
                          style: TextStyle(
                              color: Color(0xFF203531),
                              fontSize: 11,
                              fontWeight: FontWeight.w800),
                        ),
                      );
                    }
                    return CatalogContent(
                      filter: filter,
                      bodyPart: widget.bodyPart,
                      addedClother: snapshot.data!,
                    );
                  },
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: BackActionButtom(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class CatalogContent extends StatelessWidget {
  final String filter;
  final addedClother;
  final bodyPart;

  const CatalogContent(
      {super.key, this.bodyPart, this.addedClother, required this.filter});

//Пор
  @override
  Widget build(BuildContext context) {
    switch (bodyPart) {
      case "Head":
        return BodyPart(
          filterValue: filter,
          typeClotherReverse: AddedClother.head.map((k, v) => MapEntry(v, k)),
          addedClotherListFromServer: addedClother,
          bodyPart: 'Head',
        );
      case "Torso":
        return BodyPart(
          filterValue: filter,
          typeClotherReverse: AddedClother.torso.map((k, v) => MapEntry(v, k)),
          addedClotherListFromServer: addedClother,
          bodyPart: 'Torso',
        );
      case "Legs":
        return BodyPart(
          filterValue: filter,
          typeClotherReverse: AddedClother.legs.map((k, v) => MapEntry(v, k)),
          addedClotherListFromServer: addedClother,
          bodyPart: 'Legs',
        );
      case "Feet":
        return BodyPart(
          filterValue: filter,
          typeClotherReverse: AddedClother.feet.map((k, v) => MapEntry(v, k)),
          addedClotherListFromServer: addedClother,
          bodyPart: 'Feet',
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
// Map _filteredMap(filter, bodyPart){
//   switch(filter){
//     case "season":
//       return IdServer.seasonReverse;
//     case 'color':
//     return IdServer.colorReverse;
//
//     default:  ;
//   }
// }
}

class BodyPart extends StatelessWidget {
  final String filterValue;
  final String bodyPart;
  final addedClotherListFromServer;
  final typeClotherReverse;

  const BodyPart({
    super.key,
    // {59: Polo, 60: T-shirts, 85: Tank tops, 62: Blouses, 63: Shirts, 68: Sweaters}
    required this.typeClotherReverse,
    // {id: [12, 13, 31, 32, 33, 40], name: ["testName", "testName", "testName", "testName,] image: [http://6efba428f094.hosting.myjino.ru/media/images/user_2/image_cropper_1715981558682.png, http://6efba428f094.hosting.myjino.ru/media/images/user_2/image_cropper_1715981713529.png, }
    required this.addedClotherListFromServer,
    required this.bodyPart,
    required this.filterValue,
  });

  @override
  Widget build(BuildContext context) {
    List keysTypeReverse = typeClotherReverse.keys.toList();
    int index = 0;
    //использум для того чтобы достучаться до фильтра с помощью индекса
    var filterIndexes = [];
    //Сделано для показа на странице
    var uniqueFilterIndex = [];
    for (var type in addedClotherListFromServer["typeClothes"]) {
      if (keysTypeReverse.contains(type)) {
        // хранит индексы нужных элементов
        filterIndexes.add(index);

        if (!uniqueFilterIndex
            .contains(addedClotherListFromServer[filterValue][index])) {
          uniqueFilterIndex.add(addedClotherListFromServer[filterValue][index]);
        }
      }
      index += 1;
    }

    var listByFilter = chooseFilterType(typeClotherReverse);
    return ListView.builder(
      itemCount: uniqueFilterIndex.length,
      itemBuilder: (BuildContext context, int idx) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 2),
          child: GestureDetector(
            onTap: () {
              Navigator.of((context)).push(MaterialPageRoute(
                  builder: (context) => OpenType(
                        filterIndexes: filterIndexes,
                        filterValue: filterValue,
                        addedClotherListFromServer: addedClotherListFromServer,
                        indexRightNow: uniqueFilterIndex[idx], bodyPart: bodyPart,
                      )));
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(6)),
              child: Text(
                listByFilter[uniqueFilterIndex[idx]],
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
            ),
          ),
        );
      },
    );
    // return Align(
    //   alignment: Alignment.center,
    //   child: ListView.builder(
    //     itemCount: 4,
    //     itemBuilder: (BuildContext context, int index) {
    //       if (IdServer.seasonReverse[5] != null) {
    //         return Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 40, vertical: 2),
    //           child: GestureDetector(
    //             onTap: () {
    //               Navigator.of((context)).push(MaterialPageRoute(
    //                   builder: (context) => OpenType(
    //                         bodyPart: bodyPart,
    //                         addedClotherList: addedClotherListFromServer,
    //                         type: [12, 23],
    //                         // type: typeClotherUnique[index]
    //                       )));
    //             },
    //             child: Container(
    //               alignment: Alignment.center,
    //               height: 40,
    //               decoration: BoxDecoration(
    //                   border: Border.all(color: Colors.black, width: 1),
    //                   borderRadius: BorderRadius.circular(6)),
    //               child: Text(
    //                 typeClotherReverse[5],
    //                 style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
    //               ),
    //             ),
    //           ),
    //         );
    //       }
    //       return SizedBox();
    //     },
    //   ),
    // );
  }

  Map chooseFilterType(typeClotherReverse) {
    switch (filterValue) {
      case 'colors':
        return IdServer.colorReverse;
      case 'season':
        return IdServer.seasonReverse;
      default:
        return typeClotherReverse;
    }
  }
}
