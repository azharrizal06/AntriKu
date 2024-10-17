import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/GetAntriUser.dart';
import '../Model/antriansekarang.dart';
import '../help/help.dart';
import '../help/localData.dart';
import '../widget/TombolRegister.dart';

class pengunjung extends StatefulWidget {
  const pengunjung({super.key});

  @override
  State<pengunjung> createState() => _pengunjungState();
}

class _pengunjungState extends State<pengunjung> with TickerProviderStateMixin {
  Timer? _timer;
  AnimationController? _controller;
  Animation<Offset>? _offsetAnimation;
  AntrianSekarang respon = AntrianSekarang();
  GetantriUser responantri = GetantriUser();

  @override
  initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1, milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Start from offscreen (bottom)
      end: Offset.zero, // End at its normal position
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));

    _controller?.forward();

    // _timer = Timer.periodic(Duration(seconds: 2), (timer) {
    //   getantrinow();
    // });
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future getantrinow() async {
    try {
      var token = await LocalData().GetDataAuth();
      var response = await http.get(
        Uri.parse("$bashUrl/api/antrian/saatini"),
        headers: {
          'Authorization': 'Bearer ${token?.token}',
          'Accept': 'application/json',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        print(body);
        setState(() {
          respon = AntrianSekarang.fromMap(body);
        });
      } else {
        // Handle error response
      }
    } catch (e) {
      print("Error: $e");
      // Handle exception
    }
  }

  Future<void> Getantri() async {
    try {
      var token = await LocalData().GetDataAuth();
      var id = token?.user?.id;
      var response = await http.get(
        Uri.parse("$bashUrl/api/antrian/$id/user"),
        headers: {
          'Authorization': 'Bearer ${token?.token}',
          'Accept': 'application/json',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        print(body);
        setState(() {
          responantri = GetantriUser.fromMap(body);
        });
      } else {
        // Handle error response
      }
    } catch (e) {
      print("Error: $e");
      // Handle exception
    }
  }

  Future createantri() async {
    try {
      var token = await LocalData().GetDataAuth();
      var response = await http.post(
        Uri.parse("$bashUrl/api/antrian/create"),
        headers: {
          'Authorization': 'Bearer ${token?.token}',
          'Accept': 'application/json',
        },
        body: {
          "nama": token?.user?.name,
        },
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        var body = json.decode(response.body);
        print(body);
        GetantriUser respon = GetantriUser.fromMap(body);
        setState(() {
          respon = responantri = GetantriUser.fromMap(body);
        });
        Getantri();
      } else {
        print("error response");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    print("Nama ${respon.antrian?.nama}");

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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "No. ${respon.antrian?.nomor ?? ""}",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Nama : ${respon.antrian?.nama ?? ""}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ));
                },
              ),
            ),
            responantri.data == null
                ? Container()
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Warna.defaultColors().red, width: 2),
                    ),
                    height: tinggi / 5,
                    width: lebar,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No. ${responantri.data?.first.nomor ?? "kosong"}",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Nama : ${responantri.data?.first.nama ?? "kosong"}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
          ],
        ),
        bottomNavigationBar: responantri.data != null
            ? null
            : TombolRegister(
                offsetAnimation: _offsetAnimation,
                tinggi: tinggi / 8,
                warna: warna.red,
                onTap: () {
                  createantri();
                },
                lebel: "Create Antrian",
              ));
  }
}
