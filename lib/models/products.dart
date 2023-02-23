class Products {
  int? id;
  String? nombre;
  String? descripcion;
  double? precio;
  int? categoriaId;

  Products(
      {this.id, this.nombre, this.descripcion, this.precio, this.categoriaId});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
    precio = json['precio'];
    categoriaId = json['categoriaId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['descripcion'] = descripcion;
    data['precio'] = precio;
    data['categoriaId'] = categoriaId;
    return data;
  }
}
