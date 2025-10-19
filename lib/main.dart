import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samatoll/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // GetMaterialApp au lieu de MaterialApp
      title: 'Sama Toll',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}