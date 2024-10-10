import 'package:flutter/material.dart';

import '../help/help.dart';

class pengunjung extends StatelessWidget {
  const pengunjung({super.key});

  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: warna.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Warna.defaultColors().red, width: 2),
            ),
            height: tinggi / 5,
            width: lebar,
            child: Column(
              children: [
                Text(
                  "No. 1220",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Nama : sdffE",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
