class Categories {
  int? id;
  String? nombre;
  String? descripcion;

  Categories({this.id, this.nombre, this.descripcion});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['descripcion'] = this.descripcion;
    return data;
  }
}
