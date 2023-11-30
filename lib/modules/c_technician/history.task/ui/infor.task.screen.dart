// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/app/widgets/textfiel.dart';
import 'package:dich_vu_it/models/response/task.model.dart';
import 'package:dich_vu_it/modules/c_technician/home/bloc/home.bloc.dart';
import 'package:dich_vu_it/provider/file.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InforTaskScreen extends StatefulWidget {
  final TaskModel taskModel;
  final Function callBack;
  const InforTaskScreen({super.key, required this.taskModel, required this.callBack});

  @override
  State<InforTaskScreen> createState() => _InforTaskScreenState();
}

class _InforTaskScreenState extends State<InforTaskScreen> {
  var bloc = HomeBloc();
  TaskModel taskModel = TaskModel();
  @override
  void initState() {
    super.initState();
    taskModel = widget.taskModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: const Center(
            child: Text(
              "Information task",
              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: const Color.fromARGB(255, 229, 243, 254), borderRadius: BorderRadius.circular(10)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFielWidget(
                  title: 'Ticket',
                  controller: TextEditingController(text: taskModel.ticket?.title ?? ""),
                  enabled: false,
                ),
                SizedBox(height: 20),
                TextFielWidget(
                  title: "Task status",
                  controller: TextEditingController(text: nameTaskStatus(taskModel.taskStatus ?? -1)),
                  enabled: false,
                ),
                SizedBox(height: 20),
                TextFielWidget(
                  title: "Progress",
                  controller: TextEditingController(text: "${taskModel.progress ?? 0} %"),
                  enabled: false,
                ),
                SizedBox(height: 20),
                TextFielWidget(
                  title: 'Title',
                  controller: TextEditingController(text: taskModel.title ?? ""),
                  enabled: false,
                ),
                SizedBox(height: 20),
                TextFielWidget(
                  title: 'Description',
                  controller: TextEditingController(text: taskModel.description ?? ""),
                  enabled: false,
                ),
                SizedBox(height: 20),
                TextFielWidget(
                  title: 'Notes',
                  controller: TextEditingController(text: taskModel.note ?? ""),
                  enabled: false,
                ),
                SizedBox(height: 20),
                TextFielWidget(
                  title: 'Priority',
                  controller: TextEditingController(text: nameFromPriority(taskModel.priority ?? -1)),
                  enabled: false,
                ),
                SizedBox(height: 20),
                TextFielWidget(
                  title: 'Scheduled Start Time',
                  controller: TextEditingController(text: (taskModel.scheduledStartTime != null) ? DateFormat('HH:mm  dd-MM-yyyy').format(DateTime.parse(taskModel.scheduledStartTime ?? "")) : ""),
                  enabled: false,
                ),
                SizedBox(height: 20),
                TextFielWidget(
                  title: 'Scheduled End Time',
                  controller: TextEditingController(text: (taskModel.scheduledEndTime != null) ? DateFormat('HH:mm  dd-MM-yyyy').format(DateTime.parse(taskModel.scheduledEndTime ?? "")) : ""),
                  enabled: false,
                ),
                SizedBox(height: 20),
                TextFielWidget(
                  title: 'Actual Start Time',
                  controller: TextEditingController(text: (taskModel.actualStartTime != null) ? DateFormat('HH:mm  dd-MM-yyyy').format(DateTime.parse(taskModel.actualStartTime ?? "")) : ""),
                  enabled: false,
                ),
                SizedBox(height: 20),
                TextFielWidget(
                  title: 'Actual End Time',
                  controller: TextEditingController(text: (taskModel.actualStartTime != null) ? DateFormat('HH:mm  dd-MM-yyyy').format(DateTime.parse(taskModel.actualEndTime ?? "")) : ""),
                  enabled: false,
                ),
                SizedBox(height: 20),
                const Text(
                  "Attachment",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              (taskModel.attachmentUrl != null) ? "File uploaded" : "Upload file",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                              onTap: () async {
                                downloadFile(context, taskModel.attachmentUrl ?? "");
                              },
                              child: Icon(
                                Icons.download,
                                color: Colors.blue,
                              )),
                          SizedBox(width: 10),
                        ],
                      ),
                    ))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
