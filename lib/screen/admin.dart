import 'package:antriku/help/help.dart';
import 'package:flutter/material.dart';

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warna.primary,
      body: Column(
        children: [
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double containerHeight =
                    MediaQuery.of(context).size.height / 2.5;
                double containerWidth = MediaQuery.of(context).size.width;
                return Container(
                    padding: EdgeInsets.only(bottom: 50),
                    // color: Colors.red,
                    height: containerHeight,
                    width: containerWidth,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset("assets/images/papan.png"),
                        Container(
                          margin: EdgeInsets.only(top: 120),
                          // color: Colors.amber,
                          height: containerHeight / 2,
                          width: containerWidth / 2,
                          child: const Column(
                            children: [
                              Text(
                                "No. 1220",
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Nama : sdffE",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ));
              },
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Item $index"),
              );
            },
          ))
        ],
      ),
    );
  }
}
