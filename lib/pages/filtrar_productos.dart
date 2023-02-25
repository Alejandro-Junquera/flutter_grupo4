// ignore: depend_on_referenced_packages
import 'package:flutter_grupo4/providers/filtrar_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/services.dart';

class FiltrarProductosPage extends StatefulWidget {
  const FiltrarProductosPage({super.key});

  @override
  State<FiltrarProductosPage> createState() => _FiltrarProductosPageState();
}

class _FiltrarProductosPageState extends State<FiltrarProductosPage> {
  List<Products> allProducts = [];
  List<Categories> allCategories = [];
  Future getAllProducts() async {
    setState(() => allProducts.clear());
    final productService = Provider.of<ProductService>(context, listen: false);
    await productService.getProducts();
    setState(() => allProducts = productService.allProducts);
  }

  Future getAllCategories() async {
    setState(() => allCategories.clear());
    final categoryService =
        Provider.of<CategoryService>(context, listen: false);
    await categoryService.getCategories();
    setState(() => allCategories = categoryService.allCategories);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProducts();
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    final filtrarProvider =
        Provider.of<FiltarFormProvider>(context, listen: false);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.50,
              child: Form(
                key: filtrarProvider.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text('Select a Category'),
                    items: allCategories.map((e) {
                      return DropdownMenuItem(
                        value: e.id,
                        child: Text(e.nombre.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      filtrarProvider.id = value!;
                    },
                    validator: (value) {
                      return (value != null && value != 0) ? null : '';
                    }),
              ),
            ),
            MaterialButton(
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blueGrey[600],
              onPressed: () async {
                FocusScope.of(context).unfocus();
                final productService =
                    Provider.of<ProductService>(context, listen: false);
                if (!filtrarProvider.isValidForm()) return;
                await productService.filterByCategory(filtrarProvider.id);
                setState(() {
                  allProducts = productService.allProducts;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.15,
                    vertical: 20),
                child: const Text(
                  'Filter',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            itemCount: allProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.grey[500],
                height: 80,
                child: ListTile(
                  title: Text(
                      '${allProducts[index].nombre}  ${allProducts[index].precio}€'),
                  subtitle: Text(allProducts[index].descripcion.toString()),
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
