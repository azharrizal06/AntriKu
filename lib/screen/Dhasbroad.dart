import 'package:antriku/help/help.dart';
import 'package:antriku/help/localData.dart';
import 'package:antriku/screen/admin.dart';
import 'package:antriku/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model/AuthModel.dart';
import '../bloc/Auth/auth_bloc.dart';
import '../screen/user.dart';
import '../widget/TombolRegister.dart';

class Dhasbroad extends StatefulWidget {
  const Dhasbroad({super.key});

  @override
  State<Dhasbroad> createState() => _DhasbroadState();
}

class _DhasbroadState extends State<Dhasbroad> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _offsetAnimation;
  Auth? role;

  void initState() {
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

    // Start the animation
    _controller?.forward();

    LocalData().GetDataAuth().then((value) {
      if (value != null) {
        role = value;
        print("ini role ${role?.user?.role}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    var controller = context.read<AuthBloc>();
    return Scaffold(
      backgroundColor: warna.primary,
      appBar: AppBar(
        backgroundColor: warna.red,
        title: Text(
          "Dhasbroad",
          style: TextStyle(color: warna.primary),
        ),
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
                  icon: Icon(
                    Icons.logout,
                    color: warna.primary,
                  ));
            },
          )
        ],
      ),
      body: role?.user?.role == "user" ? pengunjung() : Admin(),
      bottomNavigationBar: TombolRegister(
        offsetAnimation: _offsetAnimation,
        tinggi: tinggi,
        warna: warna.red,
        onTap: () {
          print("ceated");
        },
        lebel: "Create Antrian",
      ),
    );
  }
}
