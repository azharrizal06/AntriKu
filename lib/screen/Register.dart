import 'package:antriku/screen/Dhasbroad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Auth/auth_bloc.dart';
import '../help/help.dart';
import '../widget/TextInput.dart';
import '../widget/TombolRegister.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin {
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
    ValueNotifier<String?> selectedRole = ValueNotifier<String?>("user");
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    TextEditingController email =
        TextEditingController(text: "Azregis@gmail.comhar");
    TextEditingController password = TextEditingController(text: "12345678");
    TextEditingController nama = TextEditingController(text: "Azhar");
    return Scaffold(
      backgroundColor: warna.primary,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: lebar,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: tinggi / 7,
              ),
              Text(
                "Register",
                style: TextStyle(
                  fontSize: 70,
                  fontFamily: "Actonia",
                  color: warna.red,
                ),
              ),
              Text(
                "Welcome back, get back to exploring our amazing kicks.",
                style: TextStyle(color: warna.grey),
              ),
              SizedBox(
                height: tinggi / 17,
              ),
              TextInput(controller: nama, label: "nama,", icons: Icons.person),
              TextInput(
                controller: email,
                label: "Email",
                icons: Icons.email,
              ),
              TextInput(
                controller: password,
                icons: Icons.lock,
                label: "Password",
              ),
              ValueListenableBuilder<String?>(
                valueListenable: selectedRole,
                builder: (context, value, child) {
                  return DropdownMenu(
                    inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    width: lebar / 1.5,
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(label: "Admin", value: "admin"),
                      DropdownMenuEntry(label: "User", value: "user"),
                    ],
                    onSelected: (String? selectedValue) {
                      selectedRole.value = selectedValue;
                    },
                    initialSelection: selectedRole.value,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateLogin) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Dhasbroad()),
                (route) => false);
          }
        },
        builder: (context, state) {
          return TombolRegister(
            offsetAnimation: _offsetAnimation,
            tinggi: tinggi,
            warna: warna.red,
            onTap: () {
              context.read<AuthBloc>().add(AuthEventRegister(
                  email: email.text,
                  name: nama.text,
                  password: password.text,
                  role: selectedRole.value!));
            },
            lebel: "Daftar & Login",
          );
        },
      ),
    );
  }
}
