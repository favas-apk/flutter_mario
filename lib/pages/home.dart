import 'dart:async';

import 'package:flutter/material.dart';
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

  void _jump() {
    setState(() {
      _initial_ht = _birdYAxis;
      _time = 0;
    });
  }

  void _startGame() {
    _gameHasStarted = true;

    Timer.periodic(Duration(milliseconds: 60), (Timer timer) {
      // This function will be executed every 500ms.
      _time += 0.05;
      _ht = -4.9 * _time * _time + 2.8 * _time;

      setState(() {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                if (_gameHasStarted) {
                  _jump();
                } else {
                  _startGame();
                }
              },
              child: AnimatedContainer(
                alignment: Alignment(0, _birdYAxis),
                color: Colors.blue,
                duration: Duration(milliseconds: 0),
                child: const Bird(),
              ),
            )),
        Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
            ))
      ],
    ));
  }
}
