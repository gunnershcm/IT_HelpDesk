import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dich_vu_it/app/constant/value.dart';
import 'package:dich_vu_it/provider/api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

// // update profile picture of user
// static Future<String> uploadFile(File file) async {

//   //updating image in firestore database
//   me.image = await ref.getDownloadURL();
//   await firestore
//       .collection('users')
//       .doc(user.uid)
//       .update({'image': me.image});
// }
Future<List<String>?> handleUploadFile() async {
  List<String>? fileNames;

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.image,
  );

  if (result != null && result.files.isNotEmpty) {
    fileNames = [];
    try {
      List<File> files =
          result.files.map((file) => File(file.path ?? "")).toList();
      for (var element in files) {
        var ext = element.path.split('.').last;
        var ref = APIs.storage.ref().child('pictures/${generateRandomString()}$ext');
        await ref
            .putFile(element, SettableMetadata(contentType: 'image/$ext'))
            .then((p0) {
          // log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
        });
        var image = await ref.getDownloadURL();
        fileNames.add(image);
      }
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


String generateRandomString() {
  const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  String result = '';

  for (int i = 0; i < 20; i++) {
    result += characters[random.nextInt(characters.length)];
  }

  return result;
}