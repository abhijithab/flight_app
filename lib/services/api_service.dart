import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/flight_model.dart';

class ApiService {
  static const String _baseUrl = 'http://103.214.233.90/result.json';

  Future<FlightModel> fetchFlightData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return FlightModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load flight data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching flight data: $e');
      throw Exception('Error fetching flight data: $e');
    }
  }
}
