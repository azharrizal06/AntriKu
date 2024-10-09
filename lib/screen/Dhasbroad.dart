import 'package:antriku/help/help.dart';
import 'package:antriku/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Auth/auth_bloc.dart';

class Dhasbroad extends StatefulWidget {
  const Dhasbroad({super.key});

  @override
  State<Dhasbroad> createState() => _DhasbroadState();
}

class _DhasbroadState extends State<Dhasbroad> {
  @override
  Widget build(BuildContext context) {
    var controller = context.read<AuthBloc>();
    return Scaffold(
      backgroundColor: warna.primary,
      appBar: AppBar(
        backgroundColor: warna.primary,
        title: Text("Dhasbroad"),
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthStateLogout) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              }
            },
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    controller.add(AuthEventLogout());
                  },
                  icon: Icon(Icons.logout));
            },
          )
        ],
      ),
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
