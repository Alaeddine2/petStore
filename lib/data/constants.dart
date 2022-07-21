import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFF67952);
const Color bgColor = Color(0xFFFBFBFD);
const Color darkBgColor = Color.fromARGB(255, 35, 35, 36);

const double defaultPadding = 16.0;
const double defaultBorderRadius = 12.0;
const String serverDomain = 'https://petstore.swagger.io/';
List<BoxShadow> shadowList = [
  const BoxShadow(color: Color.fromARGB(255, 224, 224, 224), blurRadius: 30, offset: Offset(0, 10))
];

const statusList = ['available', 'pending', 'sold'];