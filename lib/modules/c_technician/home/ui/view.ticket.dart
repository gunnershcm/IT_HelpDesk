// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/modules/c_technician/home/ui/edit.ticket.technician.dart';
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
                                'q':
                                    address // Địa chỉ cụ thể
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
                content: tiket.service?.type ?? "",
              ),
              FieldTextWidget(
                title: 'Priority',
                content: nameFromPriority(tiket.priority ?? -1),
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
                          SizedBox(
                              width:
                                  20), // Adjust the spacing between the images and the upload icon
                          InkWell(
                            onTap: () async {
                              downloadFile(context,
                                  List<String>.from(tiket.attachmentUrls ?? []));
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
                title: 'Impact',
                content: nameImpact(tiket.impact ?? -1),
              ),
              FieldTextWidget(
                title: 'Impact Detail',
                content: tiket.impactDetail ?? "",
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
                          ? DateFormat('HH:mm   dd-MM-yyyy')
                              .format(DateTime.parse(tiket.completedTime!))
                          : "",
                    )
                  : SizedBox.shrink(),
              FieldTextWidget(
                title: 'Requester Name',
                content:
                    "${tiket.requester?.lastName ?? " "} ${tiket.requester?.firstName ?? " "}",
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
