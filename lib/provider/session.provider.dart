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
  static Future<UserLoginResponseModel?> login({required String email, required String password}) async {
    UserLoginResponseModel? userLoginResponseModel;
    try {
      var url = "$baseUrl/v1/itsds/auth/login";
      Map<String, String> header = await getHeader();
      var responseBody = {'username': email, 'password': password};
      var body = json.encode(responseBody);
      var response = await http.post(Uri.parse(url.toString()), headers: header, body: body);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['isError'] == false) {
          return userLoginResponseModel = UserLoginResponseModel.fromMap(bodyConvert['result']);
        }
      }
    } catch (e) {
      print("Loi: $e");
    }
    // userLoginResponseModel = UserLoginResponseModel(role: 1, accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6InRoYW5obGNoIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE2OTY4NDExNjAsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcwNDMiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo1MDAwIn0.o6AGUDUmxHmUxIwSkF0XNF1i83E60qAdyAx8Zq-3ENw");
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
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          return userProfileResponseModel = UserProfileResponseModel.fromMap(bodyConvert['result']);
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
      var response = await http.patch(Uri.parse(url.toString()), headers: header, body: jsonEncode(body));
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

  static Future<bool> updateProfile(UserProfileResponseModel responseModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/user/update-profile";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var body = json.encode(responseModel.toMap());
      var response = await http.patch(Uri.parse(url.toString()), headers: header, body: body);
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
  
  static Future<bool> changePassword({required String currentPass, required String newPass, required String confirmPass}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/auth/change-password";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var body = {"currentPassword": currentPass, "newPassword": newPass, "confirmNewPassword": confirmPass};
      var bodyConvert = json.encode(body);
      var response = await http.patch(Uri.parse(url.toString()), headers: header, body: bodyConvert);
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
      var response = await http.patch(Uri.parse(url.toString()), headers: header, body: bodyConvert);
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
}
