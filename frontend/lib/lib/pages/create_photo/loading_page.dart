import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../colors/garderob_colors.dart';
import '../../functions/photo_page_dop.dart';
import '../../functions/server_api.dart';
import '../../resources/clothersfolders.dart';
import '../room_page.dart';
import 'package:http/http.dart' as http;

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveLoadingPage extends StatelessWidget {
  // convertToRequest(_colorValue, typeValue, _seasonValue);
  SaveLoadingPage({
    super.key,
    this.bodyPart,
    this.imageFile,
    this.typeValue,
    this.colorValue,
    this.seasonValue,
  });

  final colorValue;
  final seasonValue;
  final bodyPart;
  final imageFile;
  final typeValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GarderobColors.background,
      body: SafeArea(
        child: FutureBuilder(
          future: convertToRequest(
              imageFile, bodyPart, colorValue, typeValue, seasonValue),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//Если ошибка
            if (snapshot.hasError || snapshot.data == false) {
              Navigator.pop(context);
              return Center(
                child:
                    SizedBox(height: 30, width: 30, child: Icon(Icons.close)),
              );

// пока ждем...
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
//Если все хорошо
            else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).push(PageTransition(
                    child: RoomPage(),
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 500)));
              });
              return Center(
                  child: SizedBox(
                      height: 30, width: 30, child: Icon(Icons.check)));
            }
          },
        ),
      ),
    );
  }

  Future<bool> convertToRequest(
    final imageFile,
    String bodyPart,
    String color1,
    String type_clothes,
    String getseason,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = await prefs.getString("text")!;
    final season = IdServer.season[getseason]!;

    final colors = [];
    colors.add(IdServer.color[color1]);

    var type = 0;
    switch (bodyPart) {
      case "Head":
        type = AddedClother.head[type_clothes]!;
        break;
      case "Torso":
        type = AddedClother.torso[type_clothes]!;
        break;
      case "Legs":
        type = AddedClother.legs[type_clothes]!;
        break;
      case "Feet":
        type = AddedClother.feet[type_clothes]!;
        break;
      default:
        break;
    }

    return serverRequest(token, colors, type, season, imageFile);
  }

  Future<bool> serverRequest(
      String token, List colors, type, int season, imageFile) async {
    var headers = {
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
      'Authorization': 'Token ${token}',
      'Content-Type': 'multipart/form-data'
    };
    var request = http.MultipartRequest('POST', Uri.parse(Request.sendPhoto));
    request.fields.addAll({
      'name': '"testName"',
      'type_clothes': '${type}',
      'season': '${season}',
    });
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    List<String> stringColors =
        colors.map((color) => color.toString()).toList();
    // Добавляем colors как MultipartFile СПИСКОМ
    for (var color in colors) {
      request.fields['colors'] = color.toString();
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
