// ignore: depend_on_referenced_packages
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../screens/edit_category.dart';
import '../services/services.dart';

class GestionarCategoriasPage extends StatefulWidget {
  const GestionarCategoriasPage({super.key});

  @override
  State<GestionarCategoriasPage> createState() =>
      _GestionarCategoriasPageState();
}

class _GestionarCategoriasPageState extends State<GestionarCategoriasPage> {
  List<Categories> allCategories = [];
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
    allCategories.clear();
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: allCategories.length,
            itemBuilder: (BuildContext context, int index) {
              return Slidable(
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (BuildContext context) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Delete category'),
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
                                  final categoryService =
                                      Provider.of<CategoryService>(context,
                                          listen: false);
                                  categoryService
                                      .deletCategory(allCategories[index].id!);
                                  setState(() {
                                    allCategories.removeAt(index);
                                  });
                                  customToast(
                                      'Category deleted correctly', context);
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
                                builder: (context) => EditCategoryScreen(
                                    id: allCategories[index].id!)));
                      },
                      backgroundColor: Colors.blue,
                      icon: Icons.edit,
                    ),
                  ],
                ),
                endActionPane:
                    ActionPane(motion: const DrawerMotion(), children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text(
                              'Delete all products from this category?'),
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
                                final categoryService =
                                    Provider.of<CategoryService>(context,
                                        listen: false);
                                categoryService.deletAllProductsFromCategory(
                                    allCategories[index].id!);
                                customToast(
                                    'Products from this category deleted correctly',
                                    context);
                                Navigator.pop(context);
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        ),
                      );
                    },
                    backgroundColor: Colors.red,
                    icon: Icons.delete_sweep_sharp,
                  ),
                ]),
                child: Container(
                  color: Colors.blueGrey[300],
                  height: 80,
                  child: ListTile(
                    title: Text(
                      '${allCategories[index].nombre}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      allCategories[index].descripcion.toString(),
                    ),
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
              Navigator.of(context).pushNamed('admin_newCategoryScreen')),
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
