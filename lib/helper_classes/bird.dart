import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  const Bird({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 100,width: 100,
        child: Image.asset('images/flappy_bird3.png',));
  }
}
