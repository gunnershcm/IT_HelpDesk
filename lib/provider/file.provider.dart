import 'dart:convert';
import 'dart:io';
import 'package:dich_vu_it/app/constant/value.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'session.provider.dart';

Future<String?> uploadFile(File file) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data; boundary=<calculated when request is sent>',
    };
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/v1/itsds/storage/Upload"),
    );
    request.headers.addAll(headers);
    var data = await http.MultipartFile.fromPath(
      'file',
      file.path,
    );
    request.files.add(data);
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      var body = json.decode(responseBody);
      return body["result"];
    } else {
      return null;
    }
  } catch (e) {
    print("Loiloi: $e");
    return null;
  }
}

Future<List<String>?> handleUploadFile() async {
  List<String>? fileNames = [];
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: true,
  );
  if (result != null) {
    try {
      for (PlatformFile file in result.files) {
      String path = file.path ?? "";
      String? fileName = await uploadFile(File(path));
      fileNames.add(fileName!);
      }
    } catch (e) {
      print("Loi: $e");
    }
  } else {}

  return fileNames;
}

Future<void> downloadFile(BuildContext context, String url) async {
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var fileName = const Uuid().v4();
      final documentsDirectory = await getExternalStorageDirectory();
      final filePath = '${documentsDirectory?.path}/$fileName.jpg';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã tải file về: $filePath'),
          duration: const Duration(seconds: 3), // Adjust the duration as needed
        ),
      );
    }
  } catch (e) {
    print("error: $e");
  }
}
