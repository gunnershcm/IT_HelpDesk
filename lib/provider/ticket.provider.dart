// ignore_for_file: depend_on_referenced_packages, empty_catches
import 'dart:convert';
import 'package:dich_vu_it/app/constant/value.dart';
import 'package:dich_vu_it/models/request/request.create.tikcket.model.dart';
import 'package:dich_vu_it/models/request/request.task.model.dart';
import 'package:dich_vu_it/models/response/category.response.model.dart';
import 'package:dich_vu_it/models/response/task.model.dart';
import 'package:dich_vu_it/models/response/tiket.response.model.dart';
import 'package:dich_vu_it/provider/session.provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TicketProvider {
  TicketProvider._();

  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  // <<<< Get all ticket at screen ticket >>>>
  static Future<List<TicketResponseModel>> getAllListTicket() async {
    List<TicketResponseModel> listData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/ticket/user/available";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      String decodedData = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          for (var element in bodyConvert['result']) {
            TicketResponseModel item = TicketResponseModel.fromMap(element);
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

  // <<<< Get all ticket at screen history >>>>
  static Future<List<TicketResponseModel>> getAllListTicketHistory() async {
    List<TicketResponseModel> listData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/ticket/user/history";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      String decodedData = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          for (var element in bodyConvert['result']) {
            TicketResponseModel item = TicketResponseModel.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {}
    // listData = listDataHistoryFake;
    return listData;
  }

  // <<<< Get all category >>>>
  static Future<List<CategoryResponseModel>> getAllCategory() async {
    List<CategoryResponseModel> listData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/category";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      String decodedData = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          for (var element in bodyConvert['result']) {
            var item = CategoryResponseModel.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {
      print("loi :$e");
    }
    // listData = listCategory;
    return listData;
  }

//creat ticket
  static Future<bool> createTicket(RequestCreateTicketModel requestCreateTicketModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    Map<String, String> header = await getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    var url = "$baseUrl/v1/itsds/ticket/customer/new";
    var response = await http.post(Uri.parse(url.toString()), headers: header, body: requestCreateTicketModel.toJson());
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

  //update ticket
  static Future<bool> updateTicket(RequestCreateTicketModel requestCreateTicketModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    Map<String, String> header = await getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    var url = "$baseUrl/v1/itsds/ticket/customer/${requestCreateTicketModel.id}";
    var response = await http.put(Uri.parse(url.toString()), headers: header, body: requestCreateTicketModel.toJson());
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

  //cancel ticket
  static Future<bool> cancelTicket(int idTicket) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    Map<String, String> header = await getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    var url = "$baseUrl/v1/itsds/ticket/cancel?ticketId=$idTicket";
    var response = await http.patch(
      Uri.parse(url.toString()),
      headers: header,
    );
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

  //close ticket
  static Future<bool> closeTicket(int idTicket) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    Map<String, String> header = await getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    var url = "$baseUrl/v1/itsds/ticket/close?ticketId=$idTicket";
    var response = await http.patch(
      Uri.parse(url.toString()),
      headers: header,
    );
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

  //cancel ticket
  static Future<bool> resolvedTicket(int idTicket) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    Map<String, String> header = await getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    var url = "$baseUrl/v1/itsds/ticket/modify-status?ticketId=$idTicket&newStatus=3";
    var response = await http.patch(
      Uri.parse(url.toString()),
      headers: header,
    );
    if (response.statusCode == 200) {
      var bodyConvert = jsonDecode(response.body);
      if (bodyConvert['isError'] == false) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  //danh gia  ticket
  static Future<bool> patchTechnicianTicket({required int idTicket, required int impact, required String impactDetail, required int urgency}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    Map<String, String> header = await getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    var url = "$baseUrl/v1/itsds/ticket/technician/$idTicket";
    //
    var body = {"impact": impact, "impactDetail": impactDetail, "urgency": urgency};
    var response = await http.patch(
      Uri.parse(url.toString()),
      headers: header,
      body: json.encode(body),
    );
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

  // <<<< Get all ticket assign >>>>
  static Future<List<TicketResponseModel>> getAllListTicketAssign() async {
    List<TicketResponseModel> listData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/ticket/assign/available";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);

      String decodedData = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          for (var element in bodyConvert['result']) {
            TicketResponseModel item = TicketResponseModel.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {
      print("Loi: $e");
    }
    // listData = listDataHistoryFake;
    return listData;
  }

  // <<<< Get all ticket assign filtter >>>>
  static Future<List<TicketResponseModel>> getAllListTicketAssignFillter() async {
    List<TicketResponseModel> listData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/ticket/assign/available";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      String decodedData = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          for (var element in bodyConvert['result']) {
            TicketResponseModel item = TicketResponseModel.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {}
    // listData = listDataHistoryFake;
    listData.insert(0, TicketResponseModel(title: "All tickets"));
    return listData;
  }

  // <<<< Get all ticket assign done filtter >>>>
  static Future<List<TicketResponseModel>> getAllListTicketAssignDoneFillter() async {
    List<TicketResponseModel> listData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/itsds/ticket/assign/done";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      String decodedData = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          for (var element in bodyConvert['result']) {
            TicketResponseModel item = TicketResponseModel.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {}
    // listData = listDataHistoryFake;
    listData.insert(0, TicketResponseModel(title: "All tickets"));
    return listData;
  }

//create a new ticket task
  static Future<bool> createTicketTask(RequestTaskModel requestTaskModel) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(myToken);
      var url = "$baseUrl/v1/itsds/ticket/task/new";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.post(Uri.parse(url.toString()), headers: header, body: requestTaskModel.toJson());
      String decodedData = utf8.decode(response.bodyBytes);
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
    }
    return false;
  }

//edit ticket task
  static Future<bool> updateTicketTask(TaskModel taskModel) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(myToken);
      var url = "$baseUrl/v1/itsds/ticket/task/${taskModel.id}";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.put(Uri.parse(url.toString()), headers: header, body: taskModel.toJson());
      String decodedData = utf8.decode(response.bodyBytes);
      print(response.body);
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

  //Get list task for ticket(1-4)
  static Future<List<TaskModel>> getLitsTaskForTicketAcctive({int? idTicket}) async {
    List<TaskModel> listData = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(myToken);
      var url = "";
      if (idTicket == null) {
        url = "$baseUrl/v1/itsds/ticket/task/active";
      } else {
        url = "$baseUrl/v1/itsds/ticket/task/active?ticketId=$idTicket";
      }
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      String decodedData = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          for (var element in bodyConvert['result']) {
            TaskModel item = TaskModel.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {}
    return listData;
  }

  //Get list task for ticket(1-4)
  static Future<List<TaskModel>> getLitsTaskForTicketInacctive({int? idTicket}) async {
    List<TaskModel> listData = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(myToken);
      var url = "";
      if (idTicket == null) {
        url = "$baseUrl/v1/itsds/ticket/task/inactive";
      } else {
        url = "$baseUrl/v1/itsds/ticket/task/inactive?ticketId=$idTicket";
      }
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      String decodedData = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(decodedData);
        if (bodyConvert['isError'] == false) {
          for (var element in bodyConvert['result']) {
            TaskModel item = TaskModel.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {}
    return listData;
  }
}
