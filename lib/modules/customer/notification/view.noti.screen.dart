import 'package:dich_vu_it/models/response/noti.model.dart';
import 'package:dich_vu_it/modules/customer/ticket/ui/view.ticket.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewNotiScreen extends StatelessWidget {
  final NotiModel notiModel;
  const ViewNotiScreen({super.key, required this.notiModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(children: [
              FieldTextWidget(
                title: 'Title',
                content: notiModel.title ?? "",
              ),
              FieldTextWidget(
                title: 'Body',
                content: notiModel.body ?? "",
              ),
              FieldTextWidget(
                title: 'Send',
                content: DateFormat("HH:mm  dd/MM/yyyy").format(DateTime.parse(notiModel.createdAt ?? "")),
              ),
            ]),
          )),
    );
  }
}
