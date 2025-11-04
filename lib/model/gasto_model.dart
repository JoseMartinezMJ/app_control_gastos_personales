class GastoModel {
  final int? id;
  final double monto;
  final String categoria;
  final String descripcion;
  final String fecha;

  //Contructor de la clase
  GastoModel({this.id, required this.monto, required this.categoria, required this.descripcion, required this.fecha});

  //Convertir el objeto a un Map
  Map<String,dynamic>toMap(){
    return {
      'id': id,
      'monto': monto,
      'categoria': categoria,
      'descripcion': descripcion,
      'fecha': fecha,
    };
  }
  
  //Map de la base de datos
  factory GastoModel.fromMap(Map<String,dynamic>map){
    return GastoModel(
      id: map['id'] as int,
      monto: map['monto'] as double,
      categoria: map['categoria'] as String,
      descripcion: map['descripcion'] as String,
      fecha: map['fecha'] as String,
    );
  }

}