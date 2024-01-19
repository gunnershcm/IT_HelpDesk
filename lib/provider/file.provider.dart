import 'dart:convert';
import 'dart:io';
import 'package:dich_vu_it/app/constant/value.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'session.provider.dart';

Future<List<String>?> uploadFile(List<File> files) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/v1/itsds/storage/upload/multiple-files"),
    );

    request.headers.addAll(headers);

    for (int i = 0; i < files.length; i++) {
      var stream = http.ByteStream(files[i].openRead());
      var length = await files[i].length();

      var multipartFile = http.MultipartFile(
        'files', // Use the correct key based on server expectations
        stream,
        length,
        filename: files[i].path.split('/').last,
      );

      request.files.add(multipartFile);
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
    print("Error during upload: $e");
    return null;
  }
  
}


Future<List<String>?> handleUploadFile() async {
  List<String>? fileNames;

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.image,
  );

  if (result != null && result.files.isNotEmpty) {
    try {
      List<File> files =
          result.files.map((file) => File(file.path ?? "")).toList();
      print(files);
      fileNames = await uploadFile(files);
      print(fileNames);
    } catch (e) {
      print("Error handling file upload: $e");
    }
  }

  return fileNames;
}


Future<void> downloadFile(BuildContext context, List<String> urls) async {
  try {
    for (String url in urls) {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var fileName = const Uuid().v4();
        final documentsDirectory = await getExternalStorageDirectory();
        final filePath = '${documentsDirectory?.path}/$fileName.jpg';
        final file = File(filePath);
        var a = await file.writeAsBytes(response.bodyBytes);
        print(a);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã tải file về: $filePath'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  } catch (e) {
    print("error: $e");
  }
}