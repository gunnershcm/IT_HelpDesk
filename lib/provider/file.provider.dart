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

Future<List<String>?> uploadFiles(List<File> files) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type':
          'multipart/form-data; boundary=<calculated when request is sent>',
    };

    final request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/v1/itsds/storage/upload/multiple-files"),
    );

    request.headers.addAll(headers);

    for (File file in files) {
      var data = await http.MultipartFile.fromPath(
        'files[]', // Use 'files[]' to indicate multiple files
        file.path,
      );
      request.files.add(data);
    }

    var response = await request.send();
    final responseBody = await response.stream.bytesToString();
    var body = json.decode(responseBody);
    print(response.statusCode);
    print(body);
    if (response.statusCode == 200) {
      return List<String>.from(body["result"]);
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
      List<File> files = result.files
          .map((PlatformFile file) => File(file.path ?? ""))
          .toList();
      fileNames = await uploadFiles(files);
    } catch (e) {
      print("Loi: $e");
    }
  }

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
