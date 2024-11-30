// core/functions/color_four_lines.dart
import 'dart:ui';

import 'package:flutter/material.dart';

TextSpan buildColoredLine(String text, Color color) {
  return TextSpan(
    text: text,
    style: TextStyle(color: color, fontSize: 20, fontFamily: 'Amiri'),
  );
}
