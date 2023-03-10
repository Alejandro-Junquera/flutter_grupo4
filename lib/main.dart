// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_grupo4/providers/admin_provider.dart';
import 'package:flutter_grupo4/providers/filtrar_provider.dart';
import 'package:flutter_grupo4/providers/new_category_provider.dart';
import 'package:flutter_grupo4/providers/new_product_provider.dart';
import 'package:flutter_grupo4/providers/user_provider.dart';
import 'package:flutter_grupo4/screens/screens.dart';
import 'package:flutter_grupo4/services/services.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AdminProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductService(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryService(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewCategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FiltarFormProvider(),
        )
      ],
      child: const MyApp(),
    );
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
          'admin': (_) => const AdminConfigScreen(),
          'admin_newProductScreen': (_) => const NewProductScreen(),
          'admin_newCategoryScreen': (_) => const NewCategoryScreen(),
          'user': (_) => const UserConfigScreen(),
        },
        theme: ThemeData.light()
            .copyWith(scaffoldBackgroundColor: Colors.grey[300]));
  }
}
