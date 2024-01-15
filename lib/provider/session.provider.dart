// ignore_for_file: depend_on_referenced_packages, empty_catches
import 'dart:convert';
import 'package:dich_vu_it/app/constant/value.dart';
import 'package:dich_vu_it/models/response/user.login.response.model.dart';
import 'package:dich_vu_it/models/response/user.profile.response.model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = "https://dichvuit-be.hisoft.vn";

class SessionProvider {
  SessionProvider._();

  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  // <<<< Login >>>>
static Future<UserLoginResponseModel?> login(
  {required String email, required String password}
) async {
  UserLoginResponseModel? userLoginResponseModel;
  try {
    var url = "$baseUrl/v1/itsds/auth/login";
    Map<String, String> header = await getHeader();
    var responseBody = {'username': email, 'password': password};
    var body = json.encode(responseBody);
    var response = await http.post(Uri.parse(url.toString()), headers: header, body: body);
    print(response.body);
    if (response.statusCode == 200) {
      var bodyConvert = jsonDecode(response.body);
      if (bodyConvert['isError'] == false) {
        userLoginResponseModel = UserLoginResponseModel.fromMap(bodyConvert['result']);
        // Lưu thông tin vào SharedPreferences
         SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('idUser',userLoginResponseModel.id!);
        
      }
      return userLoginResponseModel;
    }
  } catch (e) {
    print("Loi: $e");
  }
  return userLoginResponseModel;
}

 

  // <<<< Get profile >>>>
  static Future<UserProfileResponseModel?> getProfile() async {
    UserProfileResponseModel? userProfileResponseModel;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/user/profile";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      String decodedData = utf8.decode(response.bodyBytes);
      // print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          return userProfileResponseModel =
              UserProfileResponseModel.fromMap(bodyConvert['result']);
        }
      }
    } catch (e) {
      print("Loi: $e");
    }
    return userProfileResponseModel;
  }

  static Future<bool> updateAvatar(String urlImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/user/uploadAvatarByUrl";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var body = {"avatarUrl": urlImage};
      var response = await http.patch(Uri.parse(url.toString()),
          headers: header, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['isError'] == false) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  static Future<bool> updateProfile(
      UserProfileResponseModel responseModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/user/update-profile";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var body = json.encode(responseModel.toMap());
      var response = await http.patch(Uri.parse(url.toString()),
          headers: header, body: body);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['isError'] == false) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print("Loi: $e");
      return false;
    }
    return false;
  }

  static Future<bool> changePassword(
      {required String currentPass,
      required String newPass,
      required String confirmPass}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/auth/change-password";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var body = {
        "currentPassword": currentPass,
        "newPassword": newPass,
        "confirmNewPassword": confirmPass
      };
      var bodyConvert = json.encode(body);
      var response = await http.patch(Uri.parse(url.toString()),
          headers: header, body: bodyConvert);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['isError'] == false) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print("Loi: $e");
      return false;
    }
    return false;
  }

  static Future<bool> postToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    String? tokenfirebase = prefs.getString("tokenfirebase");
    print("tokenfirebase:  $tokenfirebase");
    try {
      var url = "$baseUrl/v1/itsds/notification";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var body = {"token": tokenfirebase ?? ""};
      var bodyConvert = json.encode(body);
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: bodyConvert);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['isError'] == false) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print("Loi: $e");
      return false;
    }
    return false;
  }

  static Future<bool> reset_password(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    Map<String, String> header = await getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    var url = "$baseUrl/v1/itsds/auth/reset-password?email=$email";
    var response = await http.post(Uri.parse(url.toString()), headers: header);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var bodyConvert = jsonDecode(response.body);
      if (bodyConvert['isError'] == false) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}
