import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/AntrainBloc/atrian_bloc_bloc.dart';
import 'bloc/Auth/auth_bloc.dart';
import 'bloc/user/user_bloc_bloc.dart';
import 'screen/sples.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
          BlocProvider(
            create: (context) => AtrianBlocBloc(),
          ),
          BlocProvider(
            create: (context) => UserBlocBloc(),
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            // home: Register()));
            home: Sples()));
  }
}
