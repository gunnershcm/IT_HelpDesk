// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:dich_vu_it/models/response/log.model.dart';
import 'package:dich_vu_it/models/response/tiket.response.model.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogTicket extends StatefulWidget {
  final TicketResponseModel tiket;
  const LogTicket({super.key, required this.tiket});

  @override
  State<LogTicket> createState() => _LogTicketState();
}

class _LogTicketState extends State<LogTicket> {
  List<LogModel> listdata = [];
  void getData() async {
    var listdataNew = await TicketProvider.getLogByTicketId(widget.tiket.id ?? 0);
    setState(() {
      listdata = listdataNew;
      print(listdata);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Để căn giữa cột
            children: const [
              // Username
              Expanded(
                child: Text(
                  "Username",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
              // Action
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  "Action",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ), // Nội dung của action
              // Timestamp
              SizedBox(width: 5),
              Expanded(
                flex: 2,
                child: Text(
                  "Timestamp",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
              // Message
              SizedBox(width: 5),
              Expanded(
                flex: 2,
                child: Text(
                  "Message",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var element in listdata)
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 5, bottom: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Text(
                                  element.username ?? "",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              // Action
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  element.action ?? "",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ), // Nội dung của action
                              // Timestamp
                              SizedBox(width: 5),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  DateFormat('HH:mm dd-MM-yyyy').format(
                                    DateTime.parse(
                                      element.timestamp ?? "",
                                    ),
                                  ),
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              // Message
                              SizedBox(width: 5),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var elementMess in element.entries)
                                      Text(
                                        (elementMess.message != null) ? "* ${elementMess.message}" : "",
                                        style: TextStyle(fontSize: 10),
                                      )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
