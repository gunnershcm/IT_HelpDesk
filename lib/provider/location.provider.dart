import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationProvider {

  static Future<void> getchCities() async {
    List<Map<String, dynamic>> cities = [];
    final response =
        await http.get(Uri.parse('https://provinces.open-api.vn/api/?depth=1'));
    if (response.statusCode == 200) {
      cities = List<Map<String, dynamic>>.from(
          json.decode(utf8.decode(response.bodyBytes)));
    }
  }

  static Future<void> fetchDistricts(
      dynamic cityCode) async {
    List<Map<String, dynamic>> districts = [];
    final response = await http.get(
        Uri.parse('https://provinces.open-api.vn/api/p/$cityCode?depth=2'));
    if (response.statusCode == 200) {
      districts = List<Map<String, dynamic>>.from(
          json.decode(utf8.decode(response.bodyBytes))['districts']);
    }
  }

  static Future<void> fetchWards(
      dynamic districtCode) async {
    List<Map<String, dynamic>> wards = [];
    final response = await http.get(
        Uri.parse('https://provinces.open-api.vn/api/d/$districtCode?depth=2'));
    if (response.statusCode == 200) {
      wards = List<Map<String, dynamic>>.from(
            json.decode(utf8.decode(response.bodyBytes))['wards']);
    }
  }

}
