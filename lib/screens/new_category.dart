// ignore: depend_on_referenced_packages
import 'package:flutter_grupo4/providers/new_category_provider.dart';
import 'package:flutter_grupo4/services/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../ui/input_decorations.dart';

class NewCategoryScreen extends StatefulWidget {
  const NewCategoryScreen({super.key});

  @override
  State<NewCategoryScreen> createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  List<dynamic> listaVacia = [];

  @override
  Widget build(BuildContext context) {
    final newCategoryProvider =
        Provider.of<NewCategoryProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('New Product'))),
      body: Form(
        key: newCategoryProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hinText: 'Category',
                    labelText: 'CategoryName',
                    prefixIcon: Icons.supervised_user_circle),
                onChanged: (value) => newCategoryProvider.nombre = value,
                validator: (value) {
                  return (value != null && value.length >= 3)
                      ? null
                      : 'Category name must have more than 3 characters';
                }),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                decoration: InputDecorations.authInputDecoration(
                    hinText: 'Description',
                    labelText: 'Description',
                    prefixIcon: Icons.supervised_user_circle),
                onChanged: (value) => newCategoryProvider.descripcion = value,
                validator: (value) {
                  return (value != null && value.length >= 3)
                      ? null
                      : 'Category description must have more than 3 characters';
                }),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blueGrey[600],
              onPressed: newCategoryProvider.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final productService =
                          Provider.of<CategoryService>(context, listen: false);
                      if (!newCategoryProvider.isValidForm()) return;
                      productService.createNewCategory(
                          newCategoryProvider.nombre,
                          newCategoryProvider.descripcion,
                          listaVacia);
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
