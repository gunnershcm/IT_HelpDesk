// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks
import 'package:dich_vu_it/app/constant/enum.dart';
//import 'package:dich_vu_it/models/response/log.model.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/modules/customer/ticket/ui/log.ticket.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewTicketScreen extends StatelessWidget {
  final TicketResponseModel ticket;
  //final LogModel log;
  //final int? ticketId;
  const ViewTicketScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
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
                "Ticket details",
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
                            content: ticket.title ?? "",
                          ),
                          FieldTextWidget(
                            title: 'Ticket status',
                            content:
                                getNameTicketStatus(ticket.ticketStatus ?? -1),
                          ),
                          FieldTextWidget(
                            title: 'Category',
                            content: ticket.category?.name ?? "",
                          ),
                          FieldTextWidget(
                            title: 'Mode',
                            content: ticket.mode?.name ?? "",
                          ),
                          FieldTextWidget(
                            title: 'Service',
                            content: ticket.service?.type ?? "",
                          ),
                          FieldTextWidget(
                            title: 'Priority',
                            content: nameFromPriority(ticket.priority ?? -1),
                          ),
                          FieldTextWidget(
                            title: 'Impact',
                            content: nameImpact(ticket.impact ?? -1),
                          ),
                          FieldTextWidget(
                            title: 'Impact Detail',
                            content: ticket.impactDetail ?? "",
                          ),
                          FieldTextWidget(
                            title: 'Urgency',
                            content: nameUrgency(ticket.urgency ?? -1),
                          ),
                          FieldTextWidget(
                            title: 'Description',
                            content: ticket.description ?? "",
                          ),
                          FieldTextWidget(
                            title: 'Created Date',
                            content: (ticket.createdAt != null)
                                ? DateFormat('HH:mm   dd-MM-yyyy')
                                    .format(DateTime.parse(ticket.createdAt!))
                                : "",
                          ),
                          (ticket.ticketStatus == 4 || ticket.ticketStatus == 5)
                              ? FieldTextWidget(
                                  title: 'Complete Date',
                                  content: (ticket.completedTime != null)
                                      ? DateFormat('HH:mm   dd-MM-yyyy').format(
                                          DateTime.parse(ticket.completedTime!))
                                      : "",
                                )
                              : SizedBox.shrink(),
                          FieldTextWidget(
                            title: 'Technician Namee',
                            content:
                                ticket.assignment?.technicianFullName ?? "",
                          ),
                          FieldTextWidget(
                            title: 'Technician Email',
                            content: ticket.assignment?.technicianEmail ?? "",
                          ),
                          FieldTextWidget(
                            title: 'Technician Phone',
                            content: ticket.assignment?.technicianPhone ?? "",
                            widget: (ticket.assignment?.technicianPhone != null)
                                ? Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: InkWell(
                                      onTap: () async {
                                        final Uri launchUri = Uri(
                                          scheme: 'tel',
                                          path: ticket.assignment
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
                            content: ticket.assignment?.teamName ?? "",
                          ),
                        ],
                      ),
                    ),
                  ),
                  LogTicket(
                    ticket: ticket,
                  ),
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
