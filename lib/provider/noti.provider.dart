import 'dart:convert';

import 'package:dich_vu_it/app/constant/value.dart';
import 'package:dich_vu_it/models/response/noti.model.dart';
import 'package:dich_vu_it/provider/session.provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotiProvider {
  NotiProvider._();
  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  // <<<< Get all ticket at screen ticket >>>>
  static Future<List<NotiModel>> getAllListNoti() async {
    List<NotiModel> listData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/notification";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      String decodedData = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          for (var element in bodyConvert['result']) {
            NotiModel item = NotiModel.fromMap(element);

            listData.add(item);
          }
        }
      }
    } catch (e) {
      print("Loi: $e");
    }
    // listData = listDataFake;
    return listData;
  }

  // <<<< Read id >>>>
  static Future<void> readNoti(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/notification/$id";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.patch(Uri.parse(url.toString()), headers: header);
      print("object ${response.statusCode}");
    } catch (e) {
      print("Loi: $e");
    }
    // listData = listDataFake;
  }

  // <<<< Read all >>>>
  static Future<void> readAllNoti() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/notification/read-all";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.patch(Uri.parse(url.toString()), headers: header);
      print("object ${response.statusCode}");
    } catch (e) {
      print("Loi: $e");
    }
    // listData = listDataFake;
  }

  // <<<< Get all ticket at screen ticket >>>>
  static Future<int> getCountNoti() async {
    int count = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/notification";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      String decodedData = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          for (var element in bodyConvert['result']) {
            NotiModel item = NotiModel.fromMap(element);
            if (item.isRead == false) {
              count += 1;
            }
          }
        }
      }
    } catch (e) {
      print("Loi: $e");
    }
    return count;
  }
}
