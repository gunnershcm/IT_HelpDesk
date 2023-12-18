import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationProvider {
  static Future<List<Map<String, dynamic>>> fetchCities() async {
    List<Map<String, dynamic>> cities = [];
    final response =
        await http.get(Uri.parse('https://provinces.open-api.vn/api/?depth=1'));
    if (response.statusCode == 200) {
      cities = List<Map<String, dynamic>>.from(
          json.decode(utf8.decode(response.bodyBytes)));
    }
    return cities;
  }

  // static Future<String> getCityNameById(List<Map<String, dynamic>> cities, int id) {
  //     // Tìm thành phố có id tương ứng trong danh sách

  // }
      // Trả về tên thành phố nếu tìm thấy

  // static Future<List<Map<int, dynamic>>> fetchCities1() async {
  //   List<Map<int, dynamic>> cities = [];
  //   final response =
  //       await http.get(Uri.parse('https://provinces.open-api.vn/api/?depth=1'));
  //   if (response.statusCode == 200) {
  //     cities = List<Map<int, dynamic>>.from(
  //         json.decode(utf8.decode(response.bodyBytes)));
  //   }
  //   return cities;
  // }

  static Future<List<Map<String, dynamic>>> fetchDistricts(
      dynamic cityCode) async {
    List<Map<String, dynamic>> districts = [];
    final response = await http.get(
        Uri.parse('https://provinces.open-api.vn/api/p/$cityCode?depth=2'));
    if (response.statusCode == 200) {
      districts = List<Map<String, dynamic>>.from(
          json.decode(utf8.decode(response.bodyBytes))['districts']);
    }
    return districts;
  }

  // static Future<List<Map<int, dynamic>>> fetchDistricts1(
  //     dynamic cityCode) async {
  //   List<Map<int, dynamic>> districts = [];
  //   final response = await http.get(
  //       Uri.parse('https://provinces.open-api.vn/api/p/$cityCode?depth=2'));
  //   if (response.statusCode == 200) {
  //     districts = List<Map<int, dynamic>>.from(
  //         json.decode(utf8.decode(response.bodyBytes))['districts']);
  //   }
  //   return districts;
  // }

  static Future<List<Map<String, dynamic>>> fetchWards(
      dynamic districtCode) async {
    List<Map<String, dynamic>> wards = [];
    final response = await http.get(
        Uri.parse('https://provinces.open-api.vn/api/d/$districtCode?depth=2'));
    if (response.statusCode == 200) {
      wards = List<Map<String, dynamic>>.from(
          json.decode(utf8.decode(response.bodyBytes))['wards']);
    }
    return wards;
  }
}
