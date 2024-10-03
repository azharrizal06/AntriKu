import 'package:flutter/material.dart';

class Dhasbroad extends StatefulWidget {
  const Dhasbroad({super.key});

  @override
  State<Dhasbroad> createState() => _DhasbroadState();
}

class _DhasbroadState extends State<Dhasbroad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dhasbroad"),
      ),
      body: Center(child: Text("Dhasbroad")),
    );
  }
}
