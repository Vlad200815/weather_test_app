import 'package:flutter/material.dart';

class Responsiveness {
  late double scale;
  late double width;
  late double height;

  void init(BoxConstraints constraints) {
    width = constraints.maxWidth;
    height = constraints.maxHeight;

    const int baseWidth = 412;
    const int baseHeight = 892;

    final scaleW = width / baseWidth;
    final scaleH = height / baseHeight;

    scale = (scaleW + scaleH) / 2;
  }
}
