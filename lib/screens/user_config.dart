// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../pages/favoritos.dart';
import '../pages/filtrar_productos.dart';
import '../providers/user_provider.dart';
import '../widgets/BottomNavigationBarPersonalizadoUser.dart';

class UserConfigScreen extends StatelessWidget {
  const UserConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Menú User'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: const _Ofertas(),
      bottomNavigationBar: const BottomNavigationBarPersonalizadoUser(),
    );
  }
}

class _Ofertas extends StatelessWidget {
  const _Ofertas({super.key});

  @override
  Widget build(BuildContext context) {
    final profProvider = Provider.of<UserProvider>(context);
    final currentIndex = profProvider.selectedMenuOpt;
    switch (currentIndex) {
      case 0:
        return const FiltrarProductosPage();
      case 1:
        return const FavoritosPage();
      default:
        return const FiltrarProductosPage();
    }
  }
}
