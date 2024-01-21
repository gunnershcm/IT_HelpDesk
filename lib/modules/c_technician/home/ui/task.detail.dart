// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, must_be_immutable

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/models/response/task.model.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/modules/c_technician/home/ui/edit.ticket.technician.dart';
import 'package:dich_vu_it/modules/c_technician/home/ui/infor.task.screen.dart';
import 'package:dich_vu_it/provider/file.provider.dart';
import 'package:dich_vu_it/provider/location.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewTaskScreen extends StatefulWidget {
  final TaskModel task;
  final Function callBack;
  ViewTaskScreen({super.key, required this.task, required this.callBack});

  @override
  State<ViewTaskScreen> createState() => _ViewTaskScreenState();
}

class _ViewTaskScreenState extends State<ViewTaskScreen> {
  TaskModel task = TaskModel();
  
  // List<Map<String, dynamic>> cities = [];
  // List<Map<String, dynamic>> districts = [];
  // List<Map<String, dynamic>> wards = [];
  //String? citiess;
  // String? districts;
  // String? wards;

  @override
  void initState() {
    super.initState();
    task = widget.task;
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
            widget.callBack(task);          
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Detailed Task",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => InforTaskScreen(
                      taskModel: task,
                      callBack: (value) {
                        if (value != null) {
                          setState(() {
                            task = value;
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
              Text(
                task.title ?? "",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // FieldTextWidget(
              //   title: 'Title',
              //   content: task.ticket?.title ?? "",
              // ),
              SizedBox(width: 15),
              FieldTextWidget(
                title: 'Task status',
                content: nameTaskStatus(task.taskStatus ?? -1),
              ),
              FieldTextWidget(
                title: 'Progress',
                content: (task.progress != null) ? "${task.progress} %" : '0 %',
              ),
              FieldTextWidget(
                title: 'Ticket Title',
                content: task.ticket?.title ?? "",
              ),
              FieldTextWidget(
                title: 'Description',
                content: task.description ?? "",
              ),
              FieldTextWidget(
                title: 'Notes',
                content: (task.note != null) ? task.note.toString() : '',
              ),
              FieldTextWidget(
                title: 'Priority',
                content: nameFromPriority(task.priority ?? -1),
              ),
              FieldTextWidget(
                title: 'Schedule Start Date',
                content: (task.scheduledStartTime != null)
                    ? DateFormat('HH:mm   dd-MM-yyyy')
                        .format(DateTime.parse(task.scheduledStartTime!))
                    : "",
              ),
              FieldTextWidget(
                title: 'Schedule End Date',
                content: (task.scheduledEndTime != null)
                    ? DateFormat('HH:mm   dd-MM-yyyy')
                        .format(DateTime.parse(task.scheduledEndTime!))
                    : "",
              ),
              // FieldTextWidget(
              //   title: 'Actual Start Date',
              //   content: (task.actualStartTime != null)
              //       ? DateFormat('HH:mm   dd-MM-yyyy')
              //           .format(DateTime.parse(task.actualStartTime!))
              //       : "",
              // ),
              // FieldTextWidget(
              //   title: 'Actual End Date',
              //   content: (task.actualEndTime != null)
              //       ? DateFormat('HH:mm   dd-MM-yyyy')
              //           .format(DateTime.parse(task.actualEndTime!))
              //       : "",
              // ),
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
                                if (task.attachmentUrls != null)
                                  for (var url in task.attachmentUrls!)
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
                          if (task.attachmentUrls != null &&
                              task.attachmentUrls!.isNotEmpty)
                            SizedBox(
                              width:
                                  20, // Adjust the spacing between the images and the upload icon
                            ),
                          if (task.attachmentUrls != null &&
                              task.attachmentUrls!.isNotEmpty)
                            InkWell(
                              onTap: () async {
                                downloadFile(
                                    context,
                                    List<String>.from(
                                        task.attachmentUrls ?? []));
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
