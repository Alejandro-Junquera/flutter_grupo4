import 'package:flutter/material.dart';
import 'package:flutter_grupo4/providers/filtrar_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../screens/screens.dart';
import '../services/products_service.dart';

class GestionarProductosPage extends StatefulWidget {
  const GestionarProductosPage({super.key});

  @override
  State<GestionarProductosPage> createState() => _GestionarProductosPageState();
}

class _GestionarProductosPageState extends State<GestionarProductosPage> {
  List<Products> allProducts = [];
  Future getAllProducts() async {
    setState(() => allProducts.clear());
    final productService = Provider.of<ProductService>(context, listen: false);
    await productService.getProducts();
    setState(() => allProducts = productService.allProducts);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allProducts.clear();
    getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: allProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return Slidable(
                startActionPane:
                    ActionPane(motion: const DrawerMotion(), children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Delete user'),
                          content: const Text('Are you sure?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () async {
                                final productService =
                                    Provider.of<ProductService>(context,
                                        listen: false);
                                productService
                                    .deletProduct(allProducts[index].id!);
                                setState(() {
                                  allProducts.removeAt(index);
                                });
                                customToast(
                                    'Produc deleted correctly', context);
                                Navigator.pop(context);
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        ),
                      );
                    },
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                  ),
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProductScreen(
                                  id: allProducts[index].id!)));
                    },
                    backgroundColor: Colors.blue,
                    icon: Icons.edit,
                  ),
                ]),
                child: Container(
                  color: Colors.blueGrey[300],
                  height: 80,
                  child: ListTile(
                    title: Text(
                      '${allProducts[index].nombre}  ${allProducts[index].precio}€',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(allProducts[index].descripcion.toString()),
                  ),
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
        FloatingActionButton(
          onPressed: (() =>
              Navigator.of(context).pushNamed('admin_newProductScreen')),
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}

void customToast(String message, BuildContext context) {
  showToast(
    message,
    textStyle: const TextStyle(
      fontSize: 14,
      wordSpacing: 0.1,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    textPadding: const EdgeInsets.all(23),
    fullWidth: true,
    toastHorizontalMargin: 25,
    borderRadius: BorderRadius.circular(15),
    backgroundColor: Colors.blueGrey[500],
    alignment: Alignment.topCenter,
    position: StyledToastPosition.bottom,
    duration: const Duration(seconds: 3),
    animation: StyledToastAnimation.slideFromBottom,
    context: context,
  );
}
