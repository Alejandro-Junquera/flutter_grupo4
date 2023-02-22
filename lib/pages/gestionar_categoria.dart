import 'package:flutter/material.dart';

class GestionarCategoriasPage extends StatefulWidget {
  const GestionarCategoriasPage({super.key});

  @override
  State<GestionarCategoriasPage> createState() =>
      _GestionarCategoriasPageState();
}

class _GestionarCategoriasPageState extends State<GestionarCategoriasPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Hola');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Segunda ventana'),
    );
  }
}
