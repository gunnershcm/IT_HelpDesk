// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/models/chat/chat_user.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/modules/c_technician/home/ui/edit.ticket.technician.dart';
import 'package:dich_vu_it/modules/chat/chat.card/chat.screen.dart';
import 'package:dich_vu_it/provider/api.dart';
import 'package:dich_vu_it/provider/file.provider.dart';
import 'package:dich_vu_it/provider/location.provider.dart';
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
  late ChatUser user;
  // List<Map<String, dynamic>> cities = [];
  // List<Map<String, dynamic>> districts = [];
  // List<Map<String, dynamic>> wards = [];
  //String? citiess;
  // String? districts;
  // String? wards;

  bool _deleteIconVisible = false;

  @override
  void initState() {
    super.initState();
    tiket = widget.tiket;
    // getUserChat();
  }

  // void getUserChat() {
  //   String? email = tiket.requester?.email?.toString();
  //   // Get the user by ID using the stream
  //   if (email != null) {
  //     APIs.GetUserByEmail(email)
  //         .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
  //       if (snapshot.docs.isNotEmpty) {
  //         // If there's at least one document in the snapshot
  //         Map<String, dynamic>? userData = snapshot.docs.first.data();

  //         // Map the data to ChatUser
  //         user = ChatUser.fromJson(userData);
  //         // Now, `user` contains the ChatUser object
  //       } else {
  //         // Handle the case where no user is found
  //         print('No user found with Email: $email');
  //       }
  //     });
  //   } else {
  //     // Handle the case where technicianId is null
  //     print('ID is null');
  //   }
  // }

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
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        EditTicketTechnicianScreen(
                      ticket: tiket,
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                title: 'Type',
                content: tiket.type ?? "",
                widget: (tiket.type == "Offline")
                    ? Container(
                        margin: EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () async {
                            // Lấy vị trí từ đối tượng tiket hoặc từ dữ liệu khác
                            // String street = tiket.street ?? "";
                            // String? city = await _loadCityName();
                            // String? district = await _loadDistrictName(city);
                            // String? ward = await _loadWardName(district);
                            String address = tiket.address ?? "";
                            final Uri mapsUri = Uri(
                              scheme: 'https',
                              host: 'www.google.com',
                              path: '/maps',
                              queryParameters: {
                                'q': address // Địa chỉ cụ thể
                              },
                            );
                            // Mở Google Maps bằng cách mở URL
                            await launchUrl(mapsUri);
                          },
                          child: Icon(
                            Icons.map,
                            size: 25,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
              FieldTextWidget(
                title: 'Mode',
                content: tiket.mode?.name ?? "",
              ),
              FieldTextWidget(
                title: 'Service',
                content: tiket.service?.description ?? "",
              ),
              FieldTextWidget(
                title: 'Priority',
                content: nameFromPriority(tiket.priority ?? -1),
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
                      height: 80, // Adjust the overall height of the container
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Wrap(
                              spacing:
                                  16.0, // Adjust the spacing between images
                              runSpacing: 8.0,
                              children: [
                                if (tiket.attachmentUrls != null)
                                  for (var url in tiket.attachmentUrls!)
                                    Container(
                                      height:
                                          60, // Adjust the height of the image container
                                      width:
                                          60, // Adjust the width of the image container
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: url,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              ],
                            ),
                          ),
                          if (tiket.attachmentUrls != null &&
                              tiket.attachmentUrls!.isNotEmpty)
                            SizedBox(
                              width:
                                  20, // Adjust the spacing between the images and the upload icon
                            ),
                          if (tiket.attachmentUrls != null &&
                              tiket.attachmentUrls!.isNotEmpty)
                            InkWell(
                              onTap: () async {
                                downloadFile(
                                    context,
                                    List<String>.from(
                                        tiket.attachmentUrls ?? []));
                              },
                              child: Icon(
                                Icons.download,
                                size: 40, // Adjust the size of the upload icon
                                color: Colors.blue,
                              ),
                            ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              FieldTextWidget(
                title: 'Description',
                content: tiket.description ?? "",
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
                title: 'Start Date',
                content: (tiket.scheduledStartTime != null)
                    ? DateFormat('HH:mm   dd-MM-yyyy')
                        .format(DateTime.parse(tiket.scheduledStartTime!))
                    : "",
              ),
              FieldTextWidget(
                title: 'End Date',
                content: (tiket.scheduledEndTime != null)
                    ? DateFormat('HH:mm   dd-MM-yyyy')
                        .format(DateTime.parse(tiket.scheduledEndTime!))
                    : "",
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
                          ? DateFormat('HH:mm   dd-MM-yyyy')
                              .format(DateTime.parse(tiket.completedTime!))
                          : "",
                    )
                  : SizedBox.shrink(),
              FieldTextWidget(
                title: 'Requester Name',
                content:
                    "${tiket.requester?.lastName ?? " "} ${tiket.requester?.firstName ?? " "}",
                widget: (tiket.requesterId != null)
                    ? Container(
                        margin: EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ChatScreen(
                                          user: user,
                                        )));
                          },
                          child: Icon(
                            Icons.chat,
                            size: 25,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
              FieldTextWidget(
                title: 'Requester Email',
                content: tiket.requester?.email ?? "",
              ),
              FieldTextWidget(
                title: 'Requester Phone',
                content: tiket.requester?.phoneNumber ?? "",
                widget: (tiket.requester?.phoneNumber != null &&
                        tiket.requester?.phoneNumber != "")
                    ? Container(
                        margin: EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () async {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path:
                                  tiket.requester?.phoneNumber ?? "0987654321",
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
                title: 'Company Address',
                content: tiket.address ?? "",
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
