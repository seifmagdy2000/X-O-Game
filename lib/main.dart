import 'package:flutter/material.dart';
import '1 Player/Board_1Player.dart';
import '1 Player/Home_1Player.dart';
import '2 Players/Board_2Players.dart';
import '2 Players/Home_2Players.dart';
import 'MainMenu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        MainMenu.routeName: (myContext) => MainMenu(),
        Home_1Player.routeName: (myContext) => Home_1Player(),
        Board_1Player.routeName: (myContext) => Board_1Player(),
        Board_2Players.routeName: (myContext) => Board_2Players(),
        Home_2Players.routeName: (myContext) => Home_2Players(),
      },
      initialRoute: MainMenu.routeName,
    );
  }
}
