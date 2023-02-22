import 'package:flutter/material.dart';

class GestionarProductosPage extends StatefulWidget {
  const GestionarProductosPage({super.key});

  @override
  State<GestionarProductosPage> createState() => _GestionarProductosPageState();
}

class _GestionarProductosPageState extends State<GestionarProductosPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Adios');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Primera ventana'),
    );
  }
}
