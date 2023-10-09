import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mario/helper_classes/barrier.dart';
import 'package:flutter_mario/helper_classes/bird.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static double _birdYAxis = 0.0;

  double _initial_ht = _birdYAxis;
  double _time = 0.0;
  double _ht = 0.0;
  var _timer;
  bool _gameHasStarted = false;
 static double _barrierOneX = 1.0;
  double _barrierTwoX = _barrierOneX+0.5;

  void _jump() {
    setState(() {
      _initial_ht = _birdYAxis;
      _time = 0;
    });
  }

  void _startGame() {
    _gameHasStarted = true;
    _barrierOneX=0;
    _barrierTwoX=.95;

    Timer.periodic(const Duration(milliseconds: 60), (Timer timer) {
      // This function will be executed every 60ms.
      _time += 0.05;
      _ht = -4.9 * _time * _time + 2.8 * _time;


      if(_barrierOneX<-2.1)
      {
        _barrierOneX=_barrierOneX + 3.5;
      }
      else
      {
        _barrierOneX=_barrierOneX - 0.05;
      }


      if(_barrierTwoX<-2)
      {
        _barrierTwoX=_barrierTwoX + 3.5;
      }
      else
      {
        _barrierTwoX=_barrierTwoX - 0.05;
      }




//      print("bird y axis is $_birdYAxis ");




      setState(() {
        _barrierOneX=  _barrierOneX-0.01;
        _barrierTwoX=  _barrierTwoX-0.01;


        _birdYAxis = _initial_ht - _ht;
      });

      if (_birdYAxis > 1) {
        timer.cancel();
        _gameHasStarted = false;

        _birdYAxis = 0.0;

        _initial_ht = _birdYAxis;
        _time = 0.0;
        _ht = 0.0;
      }


      print("x is $_barrierOneX ");
      if( _barrierOneX > 0.05  && _barrierOneX <-0.05  )
      {

        timer.cancel();
        _gameHasStarted = false;

        _birdYAxis = 0.0;

        _initial_ht = _birdYAxis;
        _time = 0.0;
        _ht = 0.0;

      }



    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        if (_gameHasStarted) {
          _jump();
        } else {
          _startGame();
        }
      },
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, _birdYAxis),
                    color: Colors.blue,
                    duration: const Duration(milliseconds: 0),
                    child: const Bird(),
                  ),
                  _gameHasStarted
                      ? const SizedBox()
                      : const Align(
                          alignment: Alignment(0, -0.3),
                          child: Text(
                            "T A P  T O  P L A Y,",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          )),
                  AnimatedContainer(
                      alignment: Alignment(_barrierOneX, 1.2),
                      duration: const Duration(milliseconds: 0),
                      child: Barrier(size: 100)),
                  AnimatedContainer(
                      alignment: Alignment(_barrierOneX, -1.2),
                      duration: const Duration(milliseconds: 0),
                      child: Barrier(size: 100)),
                  AnimatedContainer(
                      alignment:  Alignment(_barrierTwoX, 1.2),
                      duration: const Duration(milliseconds: 0),
                      child: Barrier(size: 200)),
                  AnimatedContainer(
                      alignment:  Alignment(_barrierTwoX, -1.2),
                      duration: const Duration(milliseconds: 0),
                      child: Barrier(size: 150)),
                ],
              )),
          Container(
            color: Colors.green,
            height: 20,
          ),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "SCORE",
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("10")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "BEST",
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("10"),
                      ],
                    )
                  ],
                ),
              ))
        ],
      )),
    );
  }
}
