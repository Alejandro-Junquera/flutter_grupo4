// ignore: depend_on_referenced_packages
import 'package:flutter_grupo4/pages/gestionar_productos.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../pages/gestionar_categoria.dart';
import '../providers/admin_provider.dart';
import '../widgets/BottomNavigationBarPersonalizadoAdmin.dart';

class AdminConfigScreen extends StatelessWidget {
  const AdminConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Menú Admin'),
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
      bottomNavigationBar: const BottomNavigationBarPersonalizadoAdmin(),
    );
  }
}

class _Ofertas extends StatelessWidget {
  const _Ofertas({super.key});

  @override
  Widget build(BuildContext context) {
    final profProvider = Provider.of<AdminProvider>(context);
    final currentIndex = profProvider.selectedMenuOpt;
    switch (currentIndex) {
      case 0:
        return const GestionarProductosPage();
      case 1:
        return const GestionarCategoriasPage();
      default:
        return const GestionarProductosPage();
    }
  }
}
