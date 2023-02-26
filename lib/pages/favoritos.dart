// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/services.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({super.key});

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  List<Products> allFavourites = [];
  Future getAllFavourites() async {
    setState(() => allFavourites.clear());
    final productService = Provider.of<ProductService>(context, listen: false);
    await productService.allFavouriteProducts();
    setState(() => allFavourites = productService.allFavourites);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: allFavourites.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.grey[500],
                height: 80,
                child: ListTile(
                  title: Text(
                      '${allFavourites[index].nombre}  ${allFavourites[index].precio}€'),
                  subtitle: Text(allFavourites[index].descripcion.toString()),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 2,
              );
            },
          ),
        ),
      ],
    );
  }
}
