import 'package:antriku/help/help.dart';
import 'package:antriku/help/localData.dart';
import 'package:antriku/screen/admin.dart';
import 'package:antriku/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model/AuthModel.dart';
import '../bloc/AntrainBloc/atrian_bloc_bloc.dart';
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

    getRole();
  }

  Future getRole() async {
    var value = await LocalData().GetDataAuth();
    setState(() {
      role = value;
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
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
        bottomNavigationBar: role?.user?.role == "user"
            ? Container(height: 1)
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  TombolRegister(
                    offsetAnimation: _offsetAnimation,
                    tinggi: tinggi / 8,
                    warna: warna.red,
                    onTap: () {
                      context
                          .read<AtrianBlocBloc>()
                          .add(AtrianEventBlocStateantrinext());
                    },
                    lebel: "Antrian Selanjutnya",
                  ),
                  TombolRegister(
                    offsetAnimation: _offsetAnimation,
                    tinggi: tinggi / 16,
                    warna: warna.primary,
                    onTap: () {
                      print("ceated");
                    },
                    lebel: "Pending Antrian",
                  ),
                ],
              ));
  }
}
