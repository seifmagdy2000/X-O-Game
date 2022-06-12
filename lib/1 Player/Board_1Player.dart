import 'package:flutter/material.dart';
import '../MainMenu.dart';
import '../ScoreText.dart';

int currentMoves = 0;
List<String> boardState = ['', '', '', '', '', '', '', '', '']; //empty board
String winner = '';
int playerScore = 0;
int botScore = 0;
int draw = 0;
var _gamePageState;
var _turnState;
String _turn = 'O';
bool loading = false;
bool vsBot = true;
Color winnerColor = Color.fromRGBO(255, 183, 3, 1.0);
List<Color>winnerBackGround = [
  Color.fromRGBO(144, 224, 239, 1.0),
  Color.fromRGBO(144, 224, 239, 1.0),
  Color.fromRGBO(144, 224, 239, 1.0),
  Color.fromRGBO(144, 224, 239, 1.0),
  Color.fromRGBO(144, 224, 239, 1.0),
  Color.fromRGBO(144, 224, 239, 1.0),
  Color.fromRGBO(144, 224, 239, 1.0),
  Color.fromRGBO(144, 224, 239, 1.0),
  Color.fromRGBO(144, 224, 239, 1.0)
];

class Board_1Player extends StatefulWidget {
  static const String routeName = 'Board_1Player';
  @override
  _Board_1PlayerState createState() => _Board_1PlayerState();
}

class _Board_1PlayerState extends State<Board_1Player> {
  String player1Name = '';
  @override
  Widget build(BuildContext context) {
    var args = (ModalRoute
        .of(context)
        ?.settings
        .arguments) as BoardArgs;
    player1Name = args.player1Name;
    if (player1Name == '') {
      player1Name = 'Player';
    }
    _gamePageState = this;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 25),
          padding: EdgeInsets.all(10),
          color: Color.fromRGBO(202, 240, 248, 1.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Color.fromRGBO(202, 240, 248, 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Score(player1Name, playerScore, 'O'),
                      Score('Bot', botScore, 'X'),
                      Score('Draw', draw, ''),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Player's turn: $_turn",style: TextStyle(
                      fontSize: 22,
                      color: Color.fromRGBO(2, 62, 138, 1.0),
                      //fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BoardButton(0),
                    BoardButton(1),
                    BoardButton(2),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BoardButton(3),
                    BoardButton(4),
                    BoardButton(5),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BoardButton(6),
                    BoardButton(7),
                    BoardButton(8),
                  ],
                ),
              ),
              Status()
            ],
          )),
    );
  }
}
class BoardButton extends StatefulWidget {
  final int index;

  BoardButton(this.index);

  @override
  _BoardButtonState createState() => _BoardButtonState();
}

class _BoardButtonState extends State<BoardButton> {
  void onPlay() {
    _gamePageState.setState(() {
      currentMoves++;
      if (_checkGame()) {
        for (int i = 0; i < 9; i++) {
          if (boardState[i].isEmpty) {
            boardState[i] = ' ';
          }
        }
        if(winner=='O'||winner=='o'){
          playerScore++;
        }
        else if(winner=='X'||winner=='x'){
          botScore++;
        }
      } else if (currentMoves >= 9) {
        draw++;
        currentMoves = 0;
        for(int i =0;i<9;i++){
          winnerBackGround[i]=winnerColor;
        }
      }
      _turnState.setState(() {
        if (currentMoves % 2 == 0)
          _turn = 'O';
        else
          _turn = 'X';
        _gamePageState.setState(() {});
      });
    });
  }

  @override
  Widget build(context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 2, right: 2, bottom: 2),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                winnerBackGround[widget.index]),
          ),
          child: Text(
            boardState[widget.index].toUpperCase(),
            style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
          onPressed: () {
            if (boardState[widget.index] == '') {
              if (!loading) {
                loading = true;
                boardState[widget.index] = 'o';
                if (currentMoves >= 8) {} else
                  _bestMove(boardState);
              }
              onPlay();
            }
          },
        ),
      ),
    );
  }
}

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}
class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    _turnState = this;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(margin: EdgeInsets.only(left: 2, right: 2),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(
                                255, 183, 3, 1.0))
                    ),
                    onPressed: () {
                      _gamePageState.setState(() {
                        _restartGame();
                      });
                    },
                    child: Text('Restart', style: TextStyle(
                      color: Color.fromRGBO(2, 62, 138, 1.0),
                    ),),
                  ),
                )
            ),
            Expanded(
              child: Container(margin: EdgeInsets.only(left: 2, right: 2),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(
                          240, 113, 103, 1.0))
                  ),
                  onPressed: () {
                    _gamePageState.setState(() {
                      _resetGame();
                    });
                  },
                  child: Text('Reset',
                    style: TextStyle(
                        color: Color.fromRGBO(2, 62, 138, 1.0),
                        fontWeight: FontWeight.bold
                    ),),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(margin: EdgeInsets.only(left: 2, right: 2),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(2, 62, 138, 1.0),)
                  ),
                  onPressed: () {
                    setState(() {
                      _resetGame();
                      Navigator.pushReplacementNamed(context, MainMenu.routeName);
                    });
                  },
                  child: Text('New Game', style: TextStyle(
                    color: Color.fromRGBO(248, 249, 250, 1.0),
                  ),),
                ),
              ),)
          ],
        )
      ],
    );
  }
}
//-------------------------------------TicTacToe game fns ---------------------------

bool _checkGame() {
  for (int i = 0; i < 9; i += 3) {
    if (boardState[i] != '' &&
        boardState[i] == boardState[i + 1] &&
        boardState[i + 1] == boardState[i + 2]) {
      winner = boardState[i];
      winnerBackGround[i] = winnerColor;
      winnerBackGround[i + 1] = winnerColor;
      winnerBackGround[i + 2] = winnerColor;
      return true;
    }
  }
  for (int i = 0; i < 3; i++) {
    if (boardState[i] != '' &&
        boardState[i] == boardState[i + 3] &&
        boardState[i + 3] == boardState[i + 6]) {
      winner = boardState[i];
      winnerBackGround[i] = winnerColor;
      winnerBackGround[i + 3] = winnerColor;
      winnerBackGround[i + 6] = winnerColor;
      return true;
    }
  }
  if (boardState[0] != '' && boardState[0] == boardState[4] &&
      boardState[4] == boardState[8]) {
    winner = boardState[4];
    winnerBackGround[0] = winnerColor;
    winnerBackGround[4] = winnerColor;
    winnerBackGround[8] = winnerColor;
    return true;
  }
  if (boardState[2] != '' && boardState[2] == boardState[4] &&
      boardState[4] == boardState[6]) {
    winner = boardState[4];
    winnerBackGround[2] = winnerColor;
    winnerBackGround[4] = winnerColor;
    winnerBackGround[6] = winnerColor;
    return true;
  }
  return false;
}

void _restartGame() {
  currentMoves = 0;
  boardState = ['', '', '', '', '', '', '', '', ''];
  _turn = 'O';
  loading = false;
  winnerBackGround = [
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0)
  ];
}

void _resetGame() {
  currentMoves = 0;
  boardState = ['', '', '', '', '', '', '', '', ''];
  _turn = 'O';
  loading = false;
  playerScore = 0;
  botScore = 0;
  draw = 0;
  winner='';
  winnerBackGround = [
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0),
    Color.fromRGBO(144, 224, 239, 1.0)
  ];
}

//------------------------------ MIN-MAX ------------------------------------------

int max(int a, int b) {
  return a > b ? a : b;
}

int min(int a, int b) {
  return a < b ? a : b;
}

String player = 'x',
    opponent = 'o';

bool isMovesLeft(List<String> _board) {
  int i;
  for (i = 0; i < 9; i++) {
    if (_board[i] == '') return true;
  }
  return false;
}
int _eval(List<String> _board) {
  for (int i = 0; i < 9; i += 3) {
    if (_board[i] != '' &&
        _board[i] == _board[i + 1] &&
        _board[i + 1] == _board[i + 2]) {
      winner = _board[i];
      return (winner == player) ? 10 : -10;
    }
  }
  for (int i = 0; i < 3; i++) {
    if (_board[i] != '' &&
        _board[i] == _board[i + 3] &&
        _board[i + 3] == _board[i + 6]) {
      winner = _board[i];
      return (winner == player) ? 10 : -10;
    }
  }
  if (_board[0] != '' && (_board[0] == _board[4] && _board[4] == _board[8]) ||
      (_board[2] != '' && _board[2] == _board[4] && _board[4] == _board[6])) {
    winner = _board[4];
    return (winner == player) ? 10 : -10;
  }
  return 0;
}

int minmax(List<String> _board, int depth, bool isMax) {
  int score = _eval(_board);
  int best = 0,
      i;
  if (score == 10 || score == -10) return score;
  if (!isMovesLeft(_board)) return 0;
  if (isMax) {
    best = -1000;
    for (i = 0; i < 9; i++) {
      if (_board[i] == '') {
        _board[i] = player;
        best = max(best, minmax(_board, depth + 1, !isMax));
        _board[i] = '';
      }
    }
    return best;
  } else {
    best = 1000;
    for (i = 0; i < 9; i++) {
      if (_board[i] == '') {
        _board[i] = opponent;
        best = min(best, minmax(_board, depth + 1, !isMax));
        _board[i] = '';
      }
    }
    return best;
  }
}

int _bestMove(List<String> _board) {
  int bestMove = -1000,
      moveVal;
  int i,
      bi = 0;
  for (i = 0; i < 9; i++) {
    if (_board[i] == '') {
      moveVal = -1000;
      _board[i] = player;
      moveVal = minmax(_board, 0, false);
      _board[i] = '';
      if (moveVal > bestMove) {
        bestMove = moveVal;
        bi = i;
      }
    }
  }
  _board[bi] = player;
  _gamePageState.setState(() {});
  loading = false;
  _turnState.setState(() {
    _turn = 'X';
    currentMoves++;
  });
  return bestMove;
}

class BoardArgs {
  String player1Name;
  BoardArgs({required this.player1Name, player2Name});
}