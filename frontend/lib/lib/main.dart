import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_garderob/pages/entry_pages/entry_loading_page.dart';
import 'package:my_garderob/pages/room_page.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    runApp(new MyApp());
  });

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
      home: EntryLoadingPage(),
      // home: MainPage(),
    );
  }
}
