// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../providers/filtrar_provider.dart';
import '../providers/new_product_provider.dart';
import '../services/services.dart';
import '../ui/input_decorations.dart';

class EditProductScreen extends StatefulWidget {
  final int id;

  const EditProductScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  List<Categories> allCategories = [];
  Products product = Products();
  Future getAllCategories() async {
    setState(() => allCategories.clear());
    final categoryService =
        Provider.of<CategoryService>(context, listen: false);
    await categoryService.getCategories();
    setState(() => allCategories = categoryService.allCategories);
  }

  Future getProduct() async {
    final productService = Provider.of<ProductService>(context, listen: false);
    await productService.getProductById(widget.id);
    setState(() {
      product = productService.product!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategories();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    final newProductProvider =
        Provider.of<NewProductProvider>(context, listen: false);
    if (product.id == null) return const CircularProgressIndicator();
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Update Product'))),
      body: Form(
        key: newProductProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
                initialValue: product.nombre,
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hinText: 'Product',
                    labelText: 'ProductName',
                    prefixIcon: Icons.supervised_user_circle),
                onChanged: (value) => newProductProvider.nombre = value,
                validator: (value) {
                  return (value != null && value.length >= 3)
                      ? null
                      : 'Product name must have more than 3 characters';
                }),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
                initialValue: product.descripcion,
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                decoration: InputDecorations.authInputDecoration(
                    hinText: 'Description',
                    labelText: 'Description',
                    prefixIcon: Icons.supervised_user_circle),
                onChanged: (value) => newProductProvider.descripcion = value,
                validator: (value) {
                  return (value != null && value.length >= 3)
                      ? null
                      : 'Product description must have more than 3 characters';
                }),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
                initialValue: product.precio.toString(),
                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hinText: 'Price',
                    labelText: 'Price',
                    prefixIcon: Icons.supervised_user_circle),
                onChanged: (value) =>
                    newProductProvider.precio = double.parse(value),
                validator: (value) {
                  return (value != null && value != '0' && value.isNotEmpty)
                      ? null
                      : 'Product price cant not be 0';
                }),
            const SizedBox(
              height: 15,
            ),
            DropdownButtonFormField(
                value: product.categoriaId,
                hint: const Text('Select a Category'),
                items: allCategories.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.nombre.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  newProductProvider.categoriaId = value!;
                },
                validator: (value) {
                  return (value != null && value != '0')
                      ? null
                      : 'Select category';
                }),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blueGrey[600],
              onPressed: newProductProvider.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final productService =
                          Provider.of<ProductService>(context, listen: false);
                      if (!newProductProvider.isValidForm()) return;
                      productService.updateProduct(
                          product.id!,
                          newProductProvider.nombre,
                          newProductProvider.descripcion,
                          newProductProvider.precio,
                          newProductProvider.categoriaId);
                      Navigator.pop(context);
                    },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: const Text(
                  'Create',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
