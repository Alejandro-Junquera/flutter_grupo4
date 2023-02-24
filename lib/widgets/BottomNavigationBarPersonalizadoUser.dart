// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../providers/user_provider.dart';

class BottomNavigationBarPersonalizadoUser extends StatelessWidget {
  const BottomNavigationBarPersonalizadoUser({super.key});

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<UserProvider>(context);
    final currentIndex = adminProvider.selectedMenuOpt;
    return BottomNavigationBar(
      onTap: (int i) => adminProvider.selectedMenuOpt = i,
      elevation: 0,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '')
      ],
    );
  }
}
