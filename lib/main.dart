import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mario/pages/home.dart';

void main() {
 // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeLeft,
  //
  // ]);

  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home()));
}

