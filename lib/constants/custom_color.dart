
import 'package:flutter/material.dart';

Color hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}

Color registerBtnColor = hexStringToColor("#344D59");
Color isGreenColor = hexStringToColor("#137C8B");
Color beginBackgroundColor = hexStringToColor("#709CA7");
Color gridcolor = hexStringToColor("#344D59");
Color cardColor = hexStringToColor("#B8CBD0");
