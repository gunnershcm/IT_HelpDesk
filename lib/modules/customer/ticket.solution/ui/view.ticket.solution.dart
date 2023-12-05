// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/models/response/feedback.model.dart';

import 'package:dich_vu_it/models/response/ticket.solution.model.dart';

import 'package:dich_vu_it/provider/file.provider.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewSolutionDetail extends StatefulWidget {
  final TicketSolutionModel solution;
  final Function callBack;
  const ViewSolutionDetail(
      {super.key, required this.solution, required this.callBack});

  @override
  State<ViewSolutionDetail> createState() => _ViewSolutionDetailState();
}

class _ViewSolutionDetailState extends State<ViewSolutionDetail> {
  TicketSolutionModel solution = TicketSolutionModel();
  FeedbackModel feedback = FeedbackModel();
  @override
  void initState() {
    super.initState();
    solution = widget.solution;
  }

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
                    text: "Feedback",
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
                            content: solution.title ?? "",
                          ),
                          FieldTextWidget(
                            title: 'Content',
                            content: solution.content ?? "",
                          ),
                          FieldTextWidget(
                            title: 'Keyword',
                            content: solution.keyword ?? "",
                          ),
                          FieldTextWidget(
                            title: 'InternalComments',
                            content: solution.internalComments ?? "",
                          ),
                          FieldTextWidget(
                              title: 'Status',
                              content: getApproveStatus(solution.isApproved)),
                          FieldTextWidget(
                              title: 'Visibility',
                              content: getApproveStatus(solution.isPublic)),
                          FieldTextWidget(
                              title: 'Attachment',
                              content: (solution.attachmentUrl != null &&
                                      solution.attachmentUrl != "")
                                  ? "File uploaded"
                                  : "",
                              widget: (solution.attachmentUrl != null &&
                                      solution.attachmentUrl != "")
                                  ? Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: InkWell(
                                        onTap: () async {
                                          downloadFile(context,
                                              solution.attachmentUrl ?? "");
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
                            title: 'Created Date',
                            content: (solution.createdAt != null)
                                ? DateFormat('HH:mm   dd-MM-yyyy')
                                    .format(DateTime.parse(solution.createdAt!))
                                : "",
                          ),
                          FieldTextWidget(
                            title: 'Owner Name',
                            content:
                                "${solution.owner?.lastName ?? " "} ${solution.owner?.firstName ?? " "}",
                          ),
                          FieldTextWidget(
                            title: 'Owner Email',
                            content: solution.owner?.email ?? "",
                          ),
                          FieldTextWidget(
                            title: 'Owner Phone',
                            content: solution.owner?.phoneNumber ?? "",
                            widget: (solution.owner?.phoneNumber != null &&
                                    solution.owner?.phoneNumber != "")
                                ? Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: InkWell(
                                      onTap: () async {
                                        final Uri launchUri = Uri(
                                          scheme: 'tel',
                                          path: solution.owner?.phoneNumber ??
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
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text("aaaa"),
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
