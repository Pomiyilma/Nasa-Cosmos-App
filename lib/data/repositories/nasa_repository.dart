import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/apod_model.dart';

class NasaRepository {
  static const String baseUrl = 'https://api.nasa.gov/planetary/apod';

  // Fetch single APOD (today or by date)
  Future<ApodModel> getApod({String? date}) async {
    final apiKey = dotenv.env['NASA_API_KEY'] ?? '';
    if (apiKey.isEmpty) throw Exception('API Key missing');

    String url = '$baseUrl?api_key=$apiKey';
    if (date != null) url += '&date=$date';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return ApodModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load APOD');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch multiple APODs for Home Screen cards
  Future<List<ApodModel>> getMultipleApods({int count = 6}) async {
    final apiKey = dotenv.env['NASA_API_KEY'] ?? '';
    if (apiKey.isEmpty) throw Exception('API Key missing');

    final url = '$baseUrl?api_key=$apiKey&count=$count';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ApodModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load multiple APODs');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

// class NasaRepository {
//   static const String baseUrl = 'https://api.nasa.gov/planetary/apod';
//
//   Future<ApodModel> getTodayApod() async {
//     final apiKey = dotenv.env['NASA_API_KEY'];
//     if (apiKey == null || apiKey.isEmpty) {
//       throw Exception('NASA API Key is missing!');
//     }
//
//     final url = '$baseUrl?api_key=$apiKey';
//
//     try {
//       final response = await http.get(Uri.parse(url));
//
//       if (response.statusCode == 200) {
//         return ApodModel.fromJson(json.decode(response.body));
//       } else {
//         throw Exception('Failed to load APOD (${response.statusCode})');
//       }
//     } catch (e) {
//       throw Exception('Network error! : $e');
//     }
//   }
// }