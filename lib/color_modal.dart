import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyColorsModal {
  List<dynamic> categoryList = [];

  List<Gradient> getGradientColors() {
    List<Gradient> GradientColors = [
      LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xff4568dc).withOpacity(0.3),
          Color(0XFFb06ab3).withOpacity(0.5),
        ],
      ),
      LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xffddd6f3),
          Color(0xfffaaca8),
        ],
      ),
      LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.teal.shade300,
          Colors.cyan.shade100,
        ],
      ),
      LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.indigo.shade100,
          Colors.indigo.shade100,
        ],
      ),
      LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.red.shade100,
          Colors.blue.shade100,
        ],
      ),
      LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.pink.shade100,
          Colors.pink.shade100,
        ],
      ),
      LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.red.shade100,
          Colors.red.shade100,
        ],
      ),
      LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.teal.shade100,
          Colors.amber.shade100,
        ],
      ),
      LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blueAccent.shade100,
          Colors.purple.shade100,
        ],
      ),
      LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.lightBlue.shade300,
          Colors.green.shade100,
        ],
      ),
      LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.amber,
          Colors.deepOrange,
        ],
      ),
      LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.amber,
          Colors.deepOrange,
        ],
      ),
    ];
    return GradientColors;
  }
}
