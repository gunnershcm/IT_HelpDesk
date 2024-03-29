import 'dart:convert';

import 'package:dich_vu_it/app/constant/value.dart';
import 'package:dich_vu_it/models/request/request.create.solution.model.dart';
import 'package:dich_vu_it/models/response/feedback.model.dart';
import 'package:dich_vu_it/models/response/ticket.solution.model.dart';
import 'package:dich_vu_it/models/response/user.profile.response.model.dart';
import 'package:dich_vu_it/provider/session.provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SolutionProvider {
  SolutionProvider._();

  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };
    return header;
  }

  //getFeedback
  static Future<List<FeedbackModel>> getAllTicketSolutionModel(
      int idTicketSolutionModel) async {
    List<FeedbackModel> listData = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url =
          "$baseUrl/v1/itsds/solution/feedback?solutionId=$idTicketSolutionModel&page=1&pageSize=100000";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      String decodedData = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          for (var element in bodyConvert['result']) {
            FeedbackModel item = FeedbackModel.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {
      print("Loi: $e");
    }
    return listData;
  }

  

  static Future<bool> updateTicketSolution(
      TicketSolutionModel solutionModel) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(myToken);
      var url = "$baseUrl/v1/itsds/solution/${solutionModel.id}";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.put(Uri.parse(url.toString()),
          headers: header, body: solutionModel.toJson());
      String decodedData = utf8.decode(response.bodyBytes);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print("Loi: $e");
    }
    return false;
  }

  // static Future<bool> change_public(int? idSolution) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString(myToken);
  //     var url =
  //         "$baseUrl/v1/itsds/solution/change-public?solutionId=$idSolution";
  //     Map<String, String> header = await getHeader();
  //     header.addAll({'Authorization': 'Bearer $token'});
  //     var response = await http.put(Uri.parse(url.toString()), headers: header);
  //     String decodedData = utf8.decode(response.bodyBytes);
  //     print(response.body);
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       var bodyConvert = jsonDecode(decodedData);
  //       if (bodyConvert['isError'] == false) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print("Loi: $e");
  //   }
  //   return false;
  // }

  static Future<bool> change_public(int? idSolution) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    Map<String, String> header = await getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    var url = "$baseUrl/v1/itsds/solution/change-public?solutionId=$idSolution";
    var response = await http.patch(Uri.parse(url.toString()),
        headers: header);
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
  static Future<FeedbackModel?> sendFeedback(
      int idTicketSolutionModel, String comment) async {
    FeedbackModel? feedbackModel;

    var body = {
      "solutionId": idTicketSolutionModel,
      "comment": comment,
      "isPublic": true
    };
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    Map<String, String> header = await getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    var url = "$baseUrl/v1/itsds/solution/feedback";
    var response = await http.post(Uri.parse(url.toString()),
        headers: header, body: json.encode(body));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var bodyConvert = jsonDecode(response.body);
      if (bodyConvert['isError'] == false) {
        FeedbackModel feedbackModel =
            FeedbackModel.fromMap(bodyConvert['result']['data']);
        return feedbackModel;
      }
    }
    return feedbackModel;
  }

   static Future<bool> submit_approval(int? idSolution,int? idManager) async {
    var body ={
      "managerId" : idManager,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    Map<String, String> header = await getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    var url = "$baseUrl/v1/itsds/solution/submit-approval?solutionId=$idSolution";
    var response = await http.patch(Uri.parse(url.toString()),
        headers: header, body: json.encode(body));
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

    static Future<List<UserProfileResponseModel>> getListManager() async {
    List<UserProfileResponseModel> listData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/user/list/managers";

      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      String decodedData = utf8.decode(response.bodyBytes);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          for (var element in bodyConvert['result']) {
            UserProfileResponseModel item = UserProfileResponseModel.fromMap(element);
            listData.add(item);
            print(listData);
          }
        }
      }
    } catch (e) {
      print("Loi: $e");
    }
    return listData;
  }



  static Future<List<TicketSolutionModel>> getAllListSolution() async {
    List<TicketSolutionModel> listData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/solution/all";

      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      String decodedData = utf8.decode(response.bodyBytes);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          for (var element in bodyConvert['result']) {
            TicketSolutionModel item = TicketSolutionModel.fromMap(element);
            listData.add(item);
            print(listData);
          }
        }
      }
    } catch (e) {
      print("Loi: $e");
    }
    return listData;
  }

  static Future<bool> createSolution(
      RequestCreateSolutionModel requestCreateSolutionModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    Map<String, String> header = await getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    var url = "$baseUrl/v1/itsds/solution/new";
    var response = await http.post(Uri.parse(url.toString()),
        headers: header, body: requestCreateSolutionModel.toJson());
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

  static Future<List<TicketSolutionModel>> getAllListSolutionFillter() async {
    List<TicketSolutionModel> listData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/solution/all";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      String decodedData = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          for (var element in bodyConvert['result']) {
            TicketSolutionModel item = TicketSolutionModel.fromMap(element);
            listData.add(item);
            print(listData);
          }
        }
      }
    } catch (e) {}
    // listData = listDataHistoryFake;
    listData.insert(0, TicketSolutionModel(title: "All solutions"));
    return listData;
  }

  static Future<List<FeedbackModel>> getFeedbackBySolutionId(
      int? idSolution) async {
    List<FeedbackModel> listData = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(myToken);
      var url = "$baseUrl/v1/itsds/solution/feedback?solutionId=$idSolution";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      String decodedData = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          for (var element in bodyConvert['result']) {
            FeedbackModel item = FeedbackModel.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {}
    return listData;
  }

  static Future<bool> dislikeSolution(int idSolution, bool isLiked) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(myToken);
      var uri = "$baseUrl/v1/itsds/solution/$idSolution/dislike";
      final url = Uri.parse(uri); // Thay thế bằng URL của API POST
      final Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      // Thực hiện gửi yêu cầu POST
      final response = await http.post(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        // Xử lý kết quả sau khi gửi yêu cầu thành công (nếu cần)
        print('Dislike thành công!');
        return isLiked = !isLiked;
      } else {
        // Xử lý khi gặp lỗi từ server
        print('Lỗi khi dislike bài viết $isLiked');
        return isLiked;
      }
    } catch (e) {
      // Xử lý nếu có lỗi khi gửi yêu cầu
      print('Lỗi: $e');
      return isLiked;
    }
  }

  static Future<bool> likeSolution(int idSolution, bool isLiked) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(myToken);
      var uri = "$baseUrl/v1/itsds/solution/$idSolution/like";
      final url = Uri.parse(uri); // Thay thế bằng URL của API POST
      final Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      // Thực hiện gửi yêu cầu POST
      final response = await http.post(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        // Xử lý kết quả sau khi gửi yêu cầu thành công (nếu cần)
        print('like thành công!');
        return isLiked = !isLiked;
      } else {
        // Xử lý khi gặp lỗi từ server
        print('Lỗi khi like bài viết $isLiked');
        return isLiked;
      }
    } catch (e) {
      // Xử lý nếu có lỗi khi gửi yêu cầu
      print('Lỗi: $e');
      return isLiked;
    }
  }
}
