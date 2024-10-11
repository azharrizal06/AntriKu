import 'package:antriku/help/help.dart';
import 'package:flutter/material.dart';

class TombolRegister extends StatelessWidget {
  TombolRegister(
      {super.key,
      required Animation<Offset>? offsetAnimation,
      required this.tinggi,
      required this.lebel,
      this.warna,
      required this.onTap})
      : _offsetAnimation = offsetAnimation;

  final Animation<Offset>? _offsetAnimation;
  final double tinggi;
  String lebel;
  Color? warna;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation!,
      child: InkWell(
        onTap: () {
          onTap!();
        },
        child: Container(
          decoration: BoxDecoration(
            color: warna, // Ganti dengan warna yang sesuai
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(60),
            ),
          ),
          width: double.infinity,
          height: tinggi,
          padding: EdgeInsets.only(top: 20),
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              "$lebel",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: warna != Warna.defaultColors().red
                      ? Warna.defaultColors().black
                      : Warna.defaultColors().primary),
            ),
          ),
        ),
      ),
    );
  }
}
