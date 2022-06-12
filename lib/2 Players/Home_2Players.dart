import 'package:flutter/material.dart';
import 'Board_2Players.dart';

class Home_2Players extends StatelessWidget {
  static const String routeName='Home_2Players';
  String player1Name='';
  String player2Name='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(202, 240, 248, 1.0),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(2, 62, 138, 1.0),
        ),
      ),
      body:  Container(
        color: Color.fromRGBO(202, 240, 248, 1.0),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(child: Container()),
            Expanded(
              flex: 2,
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (newText){
                            player1Name=newText;
                          },
                          decoration: InputDecoration(
                            labelText: 'Player 1',
                            labelStyle:TextStyle(
                              color: Color.fromRGBO(2, 62, 138, 1.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (newText){
                            player2Name=newText;
                          },
                          decoration: InputDecoration(
                            labelText: 'Player 2',
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(2, 62, 138, 1.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: MaterialButton(onPressed: (){
                          Navigator.pushReplacementNamed(context,Board_2Players.routeName,arguments: BoardArgs2Players(player1Name: player1Name, player2Name: player2Name));
                        },
                            child: Text('Start Game',style: TextStyle(
                              color: Color.fromRGBO(248, 249, 250, 1.0),
                            ),),
                            color: Color.fromRGBO(2, 62, 138, 1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
