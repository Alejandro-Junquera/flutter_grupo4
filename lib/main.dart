// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_grupo4/screens/screens.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    /*return MultiProvider(
      providers: [],
      child: const MyApp(),
    );*/
    return const MyApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'grupo4',
        initialRoute: 'login',
        routes: {
          'login': (_) => const LoginScreen(),
          'register': (_) => const RegisterScreen(),
          //'admin': (_) => AdminScreen(),
          //'user': (_) => UserScreen(),
        },
        theme: ThemeData.light()
            .copyWith(scaffoldBackgroundColor: Colors.grey[300]));
  }
}
