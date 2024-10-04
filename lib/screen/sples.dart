import 'package:antriku/help/help.dart';
import 'package:antriku/screen/Dhasbroad.dart';
import 'package:antriku/screen/login.dart';
import 'package:flutter/material.dart';

import '../help/localData.dart';

class Sples extends StatefulWidget {
  const Sples({
    super.key,
  });

  @override
  State<Sples> createState() => _SplesState();
}

class _SplesState extends State<Sples> {
  bool _isPositioned = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 500), () {
      setState(() {
        _isPositioned = true;
      });
    });

    Future.delayed(Duration(seconds: 4), () {
      nextpage();
    });
  }

  Future<void> nextpage() async {
    var isLogin = await LocalData().IsLogin();
    // bool isLogin = true;

    print("IsLogin: $isLogin");
    isLogin == true
        ? Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dhasbroad()))
        : Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warna.primary,
      body: Stack(
        children: <Widget>[
          AnimatedAlign(
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
            alignment: _isPositioned
                ? Alignment.center
                : Alignment(0.0, -1.5), // Dari atas ke tengah
            child: Text(
              'Antriku',
              style: TextStyle(fontSize: 70, fontFamily: "Actonia"),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
            bottom: _isPositioned ? -20 : -80,
            // / Menempatkan di tengah
            child: Image.asset(
              "assets/images/antri.png",
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
