import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true; // True indicates O's turn, false indicates X's turn

  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[600],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Player 1 (X)',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          xScore.toString(),
                          style:const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                       const Text(
                          'Player 2 (O)',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          oScore.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          displayElement[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: _clearScoreBoard,
                    child: const Text("Clear Score Board"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (displayElement[index] == '') {
        if (oTurn) {
          displayElement[index] = 'O';
          print('Player 2 Turn ');
        } else {
          displayElement[index] = 'X';
          print('Player 1 Turn');
        }
        filledBoxes += 1;
        oTurn = !oTurn;
      }
      _checkWinner();
    });
  }

  void _checkWinner() {
    //for checking horizontal
    if( displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '')
      {
       _showWinDialog(displayElement[0]);
      }
    else if  ( displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != ''){
      _showWinDialog(displayElement[3]);
    }
   else if( displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != ''){
      _showWinDialog(displayElement[6]);
    }
   //for checking vertical
   else if(displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != ''){
      _showWinDialog(displayElement[0]);
    }
else if(displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] !=''){
      _showWinDialog(displayElement[1]);
    }
    else if(displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] !=''){
      _showWinDialog(displayElement[2]);
    }
    //checking diagonally
    else if(displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] !=''){
      _showWinDialog(displayElement[0]);
    }
    else if(displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] !=''){
      _showWinDialog(displayElement[2]);
    }
    else if(filledBoxes == 9){
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
   showDialog(
       barrierDismissible: false,
       context: context,
   builder:(BuildContext context){
return AlertDialog(
  title: const Text("Draw"),
  actions: [
    ElevatedButton(
      child: const Text("Play Again"),
      onPressed: () {
        _clearBoard();
        Navigator.of(context).pop();
      },
    )
  ],
);
  }
  );

  }
  void _showWinDialog(String winner) {
    showDialog(
        context: context,
    barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
              title:Text("\" " + winner + " \" is Winner!!!"),
          actions: [
          ElevatedButton(
          child:const Text("Play Again"),
          onPressed: () {
          _clearBoard();
          Navigator.of(context).pop();
          },
          )
          ],
        );
  });
    if (winner == 'O') {
      oScore += 1;
    } else if (winner == 'X') {
      xScore += 1;
    }
  }
  
  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
      filledBoxes = 0;
    });
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
      filledBoxes = 0;
    });
  }
}
