import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '1 Player/Home_1Player.dart';
import '2 Players/Home_2Players.dart';

class MainMenu extends StatefulWidget {
  static const String routeName = 'MainMenu';
  @override
  _MainMenuState createState() => _MainMenuState();
}
class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(202, 240, 248, 1.0),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                'X-O GAME',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
            ),
             Expanded(

               child: Container(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text('Choose the number of players',style: TextStyle(
                         fontSize: 24,
                         fontWeight: FontWeight.bold
                     ),),
                      Padding(
                       padding: const EdgeInsets.only(top: 20.0,left: 10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           MaterialButton(
                             onPressed: () {
                               Navigator.push(context, PageTransition(duration: Duration(milliseconds: 800),type: PageTransitionType.rightToLeftWithFade, child: Home_1Player()));
                             },
                             child: Text('1 Player',style: TextStyle(
                               color: Color.fromRGBO(248, 249, 250, 1.0),
                             ),),
                             color: Color.fromRGBO(2, 62, 138, 1.0),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(8),
                             ),
                           ),
                           MaterialButton(
                             onPressed: () {
                               Navigator.push(context, PageTransition(duration: Duration(milliseconds: 800),type: PageTransitionType.leftToRightWithFade, child: Home_2Players()));
                             },
                             child: Text('2 Players',style: TextStyle(
                               color: Color.fromRGBO(248, 249, 250, 1.0),
                             ),),
                             color: Color.fromRGBO(2, 62, 138, 1.0),
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(8)
                             ),),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
             ),
          ],
        ),
      ),
    );
  }
}
