import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samatoll/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      title: 'Sama Toll',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}