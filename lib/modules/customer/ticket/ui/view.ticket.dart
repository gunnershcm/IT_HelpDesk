// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks
import 'package:dich_vu_it/app/constant/enum.dart';
//import 'package:dich_vu_it/models/response/log.model.dart';
import 'package:dich_vu_it/models/response/tiket.response.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewTicketScreen extends StatelessWidget {
  final TicketResponseModel tiket;
  //final LogModel log;
  final int? tiketId;
  const ViewTicketScreen({super.key, required this.tiket, required this.tiketId});


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
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
                "Solution details",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
            body: Column(
              children: [
                TabBar(tabs: const [
                  Tab(
                    text: "Details",
                  ),
                  Tab(
                    text: "Log",
                  ),
                ]),
                Expanded(
                    child: TabBarView(children: [
                  Container(
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
                            content:
                                getNameTicketStatus(tiket.ticketStatus ?? -1),
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
                            content: (tiket.createdAt != null)
                                ? DateFormat('HH:mm   dd-MM-yyyy')
                                    .format(DateTime.parse(tiket.createdAt!))
                                : "",
                          ),
                          (tiket.ticketStatus == 4 || tiket.ticketStatus == 5)
                              ? FieldTextWidget(
                                  title: 'Complete Date',
                                  content: (tiket.completedTime != null)
                                      ? DateFormat('HH:mm   dd-MM-yyyy').format(
                                          DateTime.parse(tiket.completedTime!))
                                      : "",
                                )
                              : SizedBox.shrink(),
                          FieldTextWidget(
                            title: 'Technician Namee',
                            content: tiket.assignment?.technicianFullName ?? "",
                          ),
                          FieldTextWidget(
                            title: 'Technician Email',
                            content: tiket.assignment?.technicianEmail ?? "",
                          ),
                          FieldTextWidget(
                            title: 'Technician Phone',
                            content: tiket.assignment?.technicianPhone ?? "",
                            widget: (tiket.assignment?.technicianPhone != null)
                                ? Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: InkWell(
                                      onTap: () async {
                                        final Uri launchUri = Uri(
                                          scheme: 'tel',
                                          path: tiket.assignment
                                                  ?.technicianPhone ??
                                              "0987654321",
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
                  Container(
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceAround, // Để căn giữa cột
                      children: const [
                        // Username
                        Column(
                          children: [
                            Text(
                              "Username",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            
                          ],
                        ),
                        // Action
                        Column(
                          children: [
                            Text(
                              "Action",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),                           // Nội dung của action
                          ],
                        ),
                        // Timestamp
                        Column(
                          children: [
                            Text(
                              "Timestamp",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // Nội dung của timestamp
                          ],
                        ),
                        // Message
                        Column(
                          children: [
                            Text(
                              "Message",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // Nội dung của message
                          ],
                        ),
                      ],
                    ),
                  )
                ]))
              ],
            )));
  }
}

class FieldTextWidget extends StatelessWidget {
  final String title;
  final String content;
  final Widget? widget;
  const FieldTextWidget(
      {super.key, required this.title, required this.content, this.widget});

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
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
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
