//class untuk warana

import 'package:flutter/material.dart';

var bashUrl = "http://192.168.200.7:8000";
var warna = Warna.defaultColors();

class Warna {
  final Color primary;
  final Color secondary;
  final Color red;
  final Color grey;

  Warna({
    required this.primary,
    required this.secondary,
    required this.red,
    required this.grey,
  });

  // Contoh factory method untuk menggunakan default value seperti di class sebelumnya
  factory Warna.defaultColors() {
    return Warna(
      primary: Color(0xFFFFFFFF),
      secondary: Color(0xFF4584FF),
      red: Color(0xFFEB3C3C),
      grey: Color(0xFF979797),
    );
  }
}
