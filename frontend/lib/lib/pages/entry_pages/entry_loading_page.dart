import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_garderob/colors/garderob_colors.dart';
import 'package:my_garderob/pages/room_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_page.dart';

class EntryLoadingPage extends StatefulWidget {
  const EntryLoadingPage({super.key});

  @override
  State<EntryLoadingPage> createState() => _EntryLoadingPageState();
}

class _EntryLoadingPageState extends State<EntryLoadingPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              backgroundColor: GarderobColors.background,
              body: Align(
                alignment: Alignment.center,
                child: Text(
                  "Hello!",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
                ),
              ));
        }
        if (snapshot.hasError) {
//Запускает после того как отрендерися виджет чтобы не выдало ошибки
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).push(PageTransition(
                child: MainPage(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500)));
          });

          return Scaffold(
            backgroundColor: GarderobColors.background,
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).push(PageTransition(
                child: RoomPage(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500)));
          });
          return Scaffold(
            backgroundColor: GarderobColors.background,
          );
          return Text(snapshot.data!);
        }
      },
    );
  }
}

Future<String?> _getData() async {
  await Future.delayed(Duration(milliseconds: 300));
  final prefs = await SharedPreferences.getInstance();
  var text = await prefs.getString("text");
  if (text == null) {
    throw "";
  }
  return text;
}
