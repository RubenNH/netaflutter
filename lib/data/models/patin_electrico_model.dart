class PatinElectricoModel{
  final String? id;
  final String marca;
  final String modelo;
  final int velocidadMaxima;
  final int autonomia;

  //constructor
  PatinElectricoModel({
    this.id,
    required this.marca,
    required this.modelo,
    required this.velocidadMaxima,
    required this.autonomia
  });

  //json a CarModel
  factory PatinElectricoModel.fromJson(Map<String, dynamic> json){
    return PatinElectricoModel(
      id: json['id'],
      marca: json['marca'],
      modelo: json['modelo'],
      velocidadMaxima: json['velocidadMaxima'],
      autonomia: json['autonomia']
    );
  }

  //CarModel a json
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'velocidadMaxima': velocidadMaxima,
      'autonomia': autonomia
    };
  }

}