import 'package:flutter/material.dart';
import 'package:flutter_grupo4/models/category.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../providers/new_category_provider.dart';
import '../services/services.dart';
import '../ui/input_decorations.dart';

class EditCategoryScreen extends StatefulWidget {
  final int id;
  const EditCategoryScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  Categories category = Categories();
  Future getProduct() async {
    final categoryService =
        Provider.of<CategoryService>(context, listen: false);
    await categoryService.getCategoryById(widget.id);
    setState(() {
      category = categoryService.category!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    final newCategoryProvider =
        Provider.of<NewCategoryProvider>(context, listen: false);
    if (category.id == null) return const CircularProgressIndicator();
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Edit Product'))),
      body: Form(
        key: newCategoryProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
                initialValue: category.nombre,
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
                initialValue: category.descripcion,
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
                      productService.updateCategory(
                        category.id!,
                        newCategoryProvider.nombre,
                        newCategoryProvider.descripcion,
                      );
                      Navigator.pop(context);
                    },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: const Text(
                  'Update',
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
