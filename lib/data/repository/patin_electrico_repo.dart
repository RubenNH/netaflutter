import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/patin_electrico_model.dart';

class PatinElectricoRepository {
  final String apiUrl;

  PatinElectricoRepository({required this.apiUrl});

    Future<List<PatinElectricoModel>> fetchPatinElectricos() async {
        final response = await http.get(Uri.parse(apiUrl + '/Prod/scooters'));
        if (response.statusCode == 200) {
            return List<PatinElectricoModel>.from(json.decode(response.body).map((x) => PatinElectricoModel.fromJson(x)));
        } else {
            throw Exception('Failed to load patin electricos');
        }
    }

    Future<PatinElectricoModel> fetchPatinElectrico(String id) async {
        final response = await http.get(Uri.parse(apiUrl + '/Prod/scooters/' + id));
        if (response.statusCode == 200) {
            return PatinElectricoModel.fromJson(json.decode(response.body));
        } else {
            throw Exception('Failed to load patin electrico');
        }
    }

    Future<void> createPatinElectrico(PatinElectricoModel patinElectrico) async {
        final response = await http.post(
            Uri.parse(apiUrl + '/Prod/scooters'),
            headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(patinElectrico.toJson()..remove('id')),
        );
        if (response.statusCode != 201) {
            throw Exception('Failed to create patin electrico');
        }
    }

    Future<void> updatePatinElectrico(PatinElectricoModel patinElectrico) async {
        final response = await http.put(
            Uri.parse('${apiUrl}/Prod/scooters/${patinElectrico.id}'),
            headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(patinElectrico.toJson()),
        );
        if (response.statusCode != 200) {
            throw Exception('Failed to update patin electrico');
        }
    }

    Future<void> deletePatinElectrico(String id) async {
        final response = await http.delete(Uri.parse(apiUrl + '/Prod/scooters/' + id));
        if (response.statusCode != 200) {
        throw Exception('Failed to delete patin electrico');
        }
    }
}