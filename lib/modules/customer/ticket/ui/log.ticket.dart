// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:dich_vu_it/models/response/log.model.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogTicket extends StatefulWidget {
  final TicketResponseModel ticket;
  const LogTicket({super.key, required this.ticket});

  @override
  State<LogTicket> createState() => _LogTicketState();
}

class _LogTicketState extends State<LogTicket> {
  List<LogModel> listdata = [];

  void getData() async {
    var listdataNew =
        await TicketProvider.getLogByTicketId(widget.ticket.id ?? 0);
    if (mounted) {
      setState(() {
        listdata = listdataNew;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Expanded(
                child: Text(
                  "Username",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Action",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Text(
                  "Timestamp",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Text(
                  "Message",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Text(
                              element.username ?? "",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              element.action ?? "",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: Text(
                              DateFormat('HH:mm dd-MM-yyyy').format(
                                DateTime.parse(
                                  element.timestamp ?? "",
                                ),
                              ),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var elementMess in element.entries)
                                  Text(
                                    (elementMess.message != null)
                                        ? "* ${elementMess.message}"
                                        : "",
                                    style: TextStyle(fontSize: 12),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
