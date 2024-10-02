import 'package:flutter/material.dart';

class Sples extends StatefulWidget {
  const Sples({
    super.key,
  });

  @override
  State<Sples> createState() => _SplesState();
}

class _SplesState extends State<Sples> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
