import 'package:flutter/material.dart';

class BoardButton extends  StatelessWidget {
  String text;
  int index;
  Function onBtnClick;
  Color winnerBackGround;
  BoardButton(this.text,this.index,this.onBtnClick,this.winnerBackGround);
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(margin: EdgeInsets.only(left: 2,right: 2,bottom: 2),
      child: ElevatedButton(
        onPressed: () {
          onBtnClick(index);
        }, style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(winnerBackGround),
      ),
        child: Text(text,style: TextStyle(
            fontSize: 50,
            color: Colors.black
        ),),
      ),
    ));
  }
}
