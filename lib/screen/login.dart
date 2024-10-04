import 'package:antriku/help/help.dart';
import 'package:antriku/screen/Dhasbroad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Auth/auth_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

bool _isPositioned = false;

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _offsetAnimation;
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
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    var controller = context.read<AuthBloc>();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: tinggi / 7,
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 70,
                          fontFamily: "Actonia",
                          color: warna.Red,
                        ),
                      ),
                      Text(
                        "Welcome back, get back to exploring our amazing kicks.",
                        style: TextStyle(color: warna.grey),
                      ),
                      SizedBox(
                        height: tinggi / 17,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                              hintText: "Email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              prefixIcon: Icon(Icons.email)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          controller: password,
                          decoration: InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              prefixIcon: Icon(Icons.lock)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(warna.secondary),
                            foregroundColor:
                                WidgetStateProperty.all(warna.primary),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.facebook,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Continue with Facebook",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(warna.primary),
                            foregroundColor: WidgetStateProperty.all(warna.Red),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/Google.png",
                                width: 20,
                                height: 20,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Continue with Facebook",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthStateLogin) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dhasbroad()),
                      );
                    } else if (state is AuthStateError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Login Gagal"),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthStateLoading) {
                      return CircularProgressIndicator();
                    }
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SlideTransition(
                          position: _offsetAnimation!,
                          child: InkWell(
                            onTap: () {
                              controller.add(AuthEventLogin(
                                  email: email.text, password: password.text));
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(
                                color: Colors
                                    .red, // Ganti dengan warna yang sesuai
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(60),
                                ),
                              ),
                              width: double.infinity,
                              height: tinggi / 5,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: warna.primary,
                                      fontSize: 20,
                                      fontWeight:
                                          FontWeight.bold), // Warna teks
                                ),
                              ),
                            ),
                          ),
                        ),
                        SlideTransition(
                          position: _offsetAnimation!,
                          child: InkWell(
                            onTap: () {
                              print("Register");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: warna
                                    .primary, // Ganti dengan warna yang sesuai
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(60),
                                ),
                              ),
                              width: double.infinity,
                              height: tinggi / 8.5,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Let’s Get Kicking!",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
