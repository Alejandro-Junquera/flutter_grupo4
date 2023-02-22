// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/admin_provider.dart';

class BottomNavigationBarPersonalizadoAdmin extends StatelessWidget {
  const BottomNavigationBarPersonalizadoAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);
    final currentIndex = adminProvider.selectedMenuOpt;
    return BottomNavigationBar(
      onTap: (int i) => adminProvider.selectedMenuOpt = i,
      elevation: 0,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.content_paste_go), label: '')
      ],
    );
  }
}
