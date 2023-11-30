// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, must_be_immutable

import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/models/response/tiket.response.model.dart';
import 'package:dich_vu_it/modules/c_technician/home/ui/edit.ticket.technician.dart';
import 'package:dich_vu_it/provider/file.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewTicketAssigScreen extends StatefulWidget {
  TicketResponseModel tiket;
  ViewTicketAssigScreen({super.key, required this.tiket});

  @override
  State<ViewTicketAssigScreen> createState() => _ViewTicketAssigScreenState();
}

class _ViewTicketAssigScreenState extends State<ViewTicketAssigScreen> {
  TicketResponseModel tiket = TicketResponseModel();
  @override
  void initState() {
    super.initState();
    tiket = widget.tiket;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 255, 255),
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
          "Ticket details",
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => EditTicketTechnicianScreen(
                      tiket: tiket,
                      callBack: (value) {
                        if (value != null) {
                          setState(() {
                            tiket = value;
                          });
                        }
                      },
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.edit,
                size: 28,
                color: Colors.white,
              )),
          SizedBox(width: 15)
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FieldTextWidget(
                title: 'Title',
                content: tiket.title ?? "",
              ),
              FieldTextWidget(
                title: 'Ticket status',
                content: getNameTicketStatus(tiket.ticketStatus ?? -1),
              ),
              FieldTextWidget(
                title: 'Category',
                content: tiket.category?.name ?? "",
              ),
              FieldTextWidget(
                title: 'Mode',
                content: tiket.mode?.name ?? "",
              ),
              FieldTextWidget(
                title: 'Service',
                content: tiket.service?.type ?? "",
              ),
              FieldTextWidget(
                title: 'Priority',
                content: nameFromPriority(tiket.priority ?? -1),
              ),
              FieldTextWidget(
                  title: 'Attachment',
                  content: (tiket.attachmentUrl != null && tiket.attachmentUrl != "") ? "File uploaded" : "",
                  widget: (tiket.attachmentUrl != null && tiket.attachmentUrl != "")
                      ? Container(
                          margin: EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () async {
                              downloadFile(context, tiket.attachmentUrl??"");
                            },
                            child: Icon(
                              Icons.download,
                              size: 25,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      : SizedBox.shrink()),
              FieldTextWidget(
                title: 'Impact',
                content: nameImpact(tiket.impact ?? -1),
              ),
              FieldTextWidget(
                title: 'Impact Detail',
                content: tiket.impactDetail ?? "",
              ),
              FieldTextWidget(
                title: 'Urgency',
                content: nameUrgency(tiket.urgency ?? -1),
              ),
              FieldTextWidget(
                title: 'Description',
                content: tiket.description ?? "",
              ),
              FieldTextWidget(
                title: 'Created Date',
                content: (tiket.createdAt != null) ? DateFormat('HH:mm   dd-MM-yyyy').format(DateTime.parse(tiket.createdAt!)) : "",
              ),
              (tiket.ticketStatus == 4 || tiket.ticketStatus == 5)
                  ? FieldTextWidget(
                      title: 'Complete Date',
                      content: (tiket.completedTime != null) ? DateFormat('HH:mm   dd-MM-yyyy').format(DateTime.parse(tiket.completedTime!)) : "",
                    )
                  : SizedBox.shrink(),
              FieldTextWidget(
                title: 'Requester Name',
                content: "${tiket.requester?.lastName ?? " "} ${tiket.requester?.firstName ?? " "}",
              ),
              FieldTextWidget(
                title: 'Requester Email',
                content: tiket.requester?.email ?? "",
              ),
              FieldTextWidget(
                title: 'Requester Phone',
                content: tiket.requester?.phoneNumber ?? "",
                widget: (tiket.requester?.phoneNumber != null && tiket.requester?.phoneNumber != "")
                    ? Container(
                        margin: EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () async {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: tiket.requester?.phoneNumber ?? "0987654321",
                            );
                            await launchUrl(launchUri);
                          },
                          child: Icon(
                            Icons.phone,
                            size: 25,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
              FieldTextWidget(
                title: 'Team Assignment',
                content: tiket.assignment?.teamName ?? "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FieldTextWidget extends StatelessWidget {
  final String title;
  final String content;
  final Widget? widget;
  const FieldTextWidget({super.key, required this.title, required this.content, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 1,
        color: const Color(0xFFF0F0F0),
      ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF909090),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      content,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                  (widget != null) ? widget! : SizedBox.shrink(),
                ],
              )),
        ],
      ),
    );
  }
}
