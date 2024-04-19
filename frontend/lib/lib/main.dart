import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_garderob/pages/main_page.dart';
import 'package:my_garderob/pages/photo_page.dart';
import 'package:my_garderob/pages/room_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/RoomPage':(BuildContext context) => RoomPage()
      },
      theme: ThemeData(
          textTheme:
              GoogleFonts.robotoSlabTextTheme(Theme.of(context).textTheme)),
      home: MainPage(),
      // home: MainPage(),
    );
  }
}
