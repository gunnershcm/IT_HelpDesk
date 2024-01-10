// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, must_be_immutable

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
  TaskModel task;
  ViewTaskScreen({super.key, required this.task});

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
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Task details",
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
              FieldTextWidget(
                  title: 'Attachment',
                  content:
                      (task.attachmentUrl != null && task.attachmentUrl != "")
                          ? "File uploaded"
                          : "",
                  widget:
                      (task.attachmentUrl != null && task.attachmentUrl != "")
                          ? Container(
                              margin: EdgeInsets.only(left: 10),
                              child: InkWell(
                                onTap: () async {
                                  downloadFile(context, List<String>.from(task.attachmentUrl ?? []));
                                },
                                child: Icon(
                                  Icons.download,
                                  size: 25,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          : SizedBox.shrink()),
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
