import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petstore/routes.dart';
import 'package:petstore/utils/theme_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(//Simulare of MaterialApp using Getx package (it is required on real devices)
      title: 'Pets Store',
      debugShowCheckedModeBanner: false, // for removing debug badge
      initialRoute: '/', //initial Route
      theme: ThemeUtils.light,
      darkTheme: ThemeUtils.dark,
      themeMode: ThemeMode.light,
      routes: Routes().routes, //The list of routes
    );
  }
}