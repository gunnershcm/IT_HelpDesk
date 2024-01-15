// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/models/request/request.create.ticket.model.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/modules/customer/ticket/ui/edit.ticket.dart';
import 'package:dich_vu_it/modules/customer/ticket/ui/log.ticket.dart';
import 'package:dich_vu_it/provider/file.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewTicketScreen extends StatefulWidget {
  final TicketResponseModel ticket;

  const ViewTicketScreen({Key? key, required this.ticket}) : super(key: key);

  @override
  State<ViewTicketScreen> createState() => _ViewTicketScreenState();
}

class _ViewTicketScreenState extends State<ViewTicketScreen> {
  TicketResponseModel ticket = TicketResponseModel();
  @override
  void initState() {
    super.initState();
    ticket = widget.ticket;
  }

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
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Visibility(
              visible: ticket.ticketStatus == 1,
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => EditTicket(
                          request: ticket,
                          callBack: (value) {
                            if (value != null) {
                              setState(() {
                                ticket = value;
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
            ),
            SizedBox(width: 15)
          ],
        ),
        body: Column(
          children: [
            TabBar(
              tabs: const [
                Tab(
                  text: "Details",
                ),
                Tab(
                  text: "Log",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('HH:mm dd-MM-yyyy')
                                    .format(DateTime.parse(ticket.createdAt!)),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 116, 116, 116),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${ticket.requester?.firstName} ${ticket.requester?.lastName}",
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.chat,
                                      size: 25,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          8.height,
                          Text(
                            ticket.title ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          8.height,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Ticket Status and Mode
                              Row(
                                children: [
                                  Expanded(
                                    child: FieldTextWidget(
                                      title: 'Ticket status',
                                      content: getNameTicketStatus(
                                          ticket.ticketStatus ?? -1),
                                    ),
                                  ),
                                  Expanded(
                                    child: FieldTextWidget(
                                      title: 'Mode',
                                      content:
                                          ticket.mode?.name ?? "Not Assigned",
                                    ),
                                  ),
                                ],
                              ),

                              // Priority and Urgency
                              Row(
                                children: [
                                  Expanded(
                                    child: FieldTextWidget(
                                      title: 'Priority',
                                      content: nameFromPriority(
                                          ticket.priority ?? -1),
                                    ),
                                  ),
                                ],
                              ),

                              // Other Fields
                              FieldTextWidget(
                                title: 'Description',
                                content: ticket.description ?? "Not Assigned",
                              ),
                              FieldTextWidget(
                                title: 'Category',
                                content:
                                    ticket.category?.name ?? "Not Assigned",
                              ),
                              FieldTextWidget(
                                title: 'Service',
                                content: ticket.service?.description ??
                                    "Not Assigned",
                              ),

                              // Additional Fields
                              FieldTextWidget(
                                title: 'Impact',
                                content: nameImpact(ticket.impact ?? -1),
                              ),
                              FieldTextWidget(
                                title: 'Impact Detail',
                                content: ticket.impactDetail ?? "Not Assigned",
                              ),
                              FieldTextWidget(
                                title: 'Complete Date',
                                content: (ticket.completedTime != null)
                                    ? DateFormat('HH:mm   dd-MM-yyyy').format(
                                        DateTime.parse(ticket.completedTime!))
                                    : "Not Assigned",
                              ),
                              const Text(
                                "Attachment",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF909090),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 80,
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Wrap(
                                              spacing: 16.0,
                                              runSpacing: 8.0,
                                              children: [
                                                if (ticket.attachmentUrls !=
                                                    null)
                                                  for (var url
                                                      in ticket.attachmentUrls!)
                                                    Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl: url,
                                                        placeholder: (context,
                                                                url) =>
                                                            CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Visibility(
                                            visible:
                                                ticket.attachmentUrls != null &&
                                                    ticket.attachmentUrls!
                                                        .isNotEmpty,
                                            child: InkWell(
                                              onTap: () async {
                                                downloadFile(
                                                  context,
                                                  List<String>.from(
                                                      ticket.attachmentUrls ??
                                                          []),
                                                );
                                              },
                                              child: Icon(
                                                Icons.download,
                                                size: 40,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Technician Info
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Technician Info",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Table with 2 rows and 2 columns
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FieldTextWidget(
                                            title: 'Technician Name',
                                            content: ticket.assignment
                                                    ?.technicianFullName ??
                                                "Not Assigned",
                                          ),
                                          SizedBox(height: 10),
                                          FieldTextWidget(
                                            title: 'Technician Email',
                                            content: ticket.assignment
                                                    ?.technicianEmail ??
                                                "Not Assigned",
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FieldTextWidget(
                                            title: 'Technician Phone',
                                            content: ticket.assignment
                                                    ?.technicianPhoneNumber ??
                                                "Not Assigned",
                                            widget: (ticket.assignment
                                                        ?.technicianPhoneNumber !=
                                                    null)
                                                ? Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        final Uri launchUri =
                                                            Uri(
                                                          scheme: 'tel',
                                                          path: ticket
                                                                  .assignment
                                                                  ?.technicianPhoneNumber ??
                                                              "0987654321",
                                                        );
                                                        await launchUrl(
                                                            launchUri);
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
                                          SizedBox(height: 10),
                                          FieldTextWidget(
                                            title: 'Team Assignment',
                                            content:
                                                ticket.assignment?.teamName ??
                                                    "Not Assigned",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  LogTicket(
                    ticket: ticket,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FieldTextWidget extends StatelessWidget {
  final String title;
  final String content;
  final Widget? widget;

  const FieldTextWidget({
    Key? key,
    required this.title,
    required this.content,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF909090),
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: Text(
                content,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            if (widget != null) widget!,
          ],
        ),
        Container(
          height: 1,
          color: const Color(0xFFF0F0F0),
          margin: const EdgeInsets.symmetric(vertical: 10),
        ),
      ],
    );
  }
}
