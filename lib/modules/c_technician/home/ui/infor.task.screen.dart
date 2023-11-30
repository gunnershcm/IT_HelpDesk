// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/pick.date.dart';
import 'package:dich_vu_it/app/widgets/textfiel.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
import 'package:dich_vu_it/models/response/task.model.dart';
import 'package:dich_vu_it/modules/c_technician/home/bloc/home.bloc.dart';
import 'package:dich_vu_it/provider/file.provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

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
  TextEditingController title = TextEditingController();
  TextEditingController moTa = TextEditingController();
  TextEditingController note = TextEditingController();
  Map<int, String> listPriority = {
    0: 'Low',
    1: 'Medium',
    2: 'High',
    3: 'Critical',
  };
  int selectedPriority = 0;
  var date1;
  var time1;
  var date2;
  var time2;
  @override
  void initState() {
    super.initState();
    taskModel = widget.taskModel;
    title.text = taskModel.title ?? "";
    moTa.text = taskModel.description ?? "";
    note.text = taskModel.note ?? "";
    date1 = DateFormat('dd-MM-yyyy').format(DateTime.parse(taskModel.scheduledStartTime ?? ""));
    time1 = DateFormat('HH:mm').format(DateTime.parse(taskModel.scheduledStartTime ?? ""));
    date2 = DateFormat('dd-MM-yyyy').format(DateTime.parse(taskModel.scheduledEndTime ?? ""));
    time2 = DateFormat('HH:mm').format(DateTime.parse(taskModel.scheduledEndTime ?? ""));
    taskModel.progress ??= 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            print(widget.taskModel.toMap());
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
        actions: [
          IconButton(
              onPressed: () {
                taskModel.title = title.text;
                taskModel.description = moTa.text;
                taskModel.note = note.text;
                bloc.add(UpdateTaskTicketEvent(taskModel: taskModel));
              },
              icon: Icon(
                Icons.done,
                color: Colors.white,
                size: 30,
              ))
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: bloc,
        listener: (context, state) async {
          if (state is HomeLoading) {
            onLoading(context);
            return;
          } else if (state is EditTaskSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            widget.callBack(taskModel);
            showToast(
              context: context,
              msg: "Edit task successfully",
              color: Colors.green,
              icon: const Icon(Icons.done),
            );
          } else if (state is HomeError) {
            Navigator.pop(context);
            showToast(
              context: context,
              msg: state.error,
              color: Colors.orange,
              icon: const Icon(Icons.warning),
            );
          }
        },
        builder: (context, state) {
          return Container(
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
                  const Text(
                    "Task status",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: taskStatus.entries.map((item) => DropdownMenuItem<int>(value: item.key, child: Text(item.value))).toList(),
                        value: taskModel.taskStatus,
                        onChanged: (value) {
                          setState(() {
                            taskModel.taskStatus = value as int;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Progress",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SfSlider(
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    min: 0.0,
                    max: 100.0,
                    value: taskModel.progress,
                    interval: 20,
                    showTicks: true,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 1,
                    onChanged: (dynamic value) {
                      int valueConvert = value.round();
                      setState(() {
                        taskModel.progress = valueConvert;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFielWidget(
                    title: 'Title',
                    controller: title,
                  ),
                  SizedBox(height: 20),
                  TextFielWidget(
                    title: 'Description',
                    controller: moTa,
                  ),
                  SizedBox(height: 20),
                  TextFielWidget(
                    title: 'Notes',
                    controller: note,
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Priority",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: listPriority.entries.map((item) => DropdownMenuItem<int>(value: item.key, child: Text(item.value))).toList(),
                        value: taskModel.priority,
                        onChanged: (value) {
                          setState(() {
                            taskModel.priority = value as int;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  DatePickerBox1(
                      requestDayBefore: date2,
                      isTime: true,
                      label: Text(
                        'Scheduled Start Time:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      dateDisplay: date1,
                      timeDisplay: time1,
                      selectedDateFunction: (day) {
                        if (day == null) {
                          taskModel.scheduledStartTime = null;
                        }
                      },
                      selectedTimeFunction: (time) {
                        if (time == null) {
                          taskModel.scheduledStartTime = null;
                        }
                      },
                      getFullTime: (time) {
                        if (time != "") {
                          taskModel.scheduledStartTime = time;
                        } else {
                          taskModel.scheduledStartTime = null;
                        }
                      }),
                  SizedBox(height: 20),
                  DatePickerBox1(
                      requestDayBefore: date1,
                      isTime: true,
                      label: Text(
                        'Scheduled End Time:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      dateDisplay: date2,
                      timeDisplay: time2,
                      selectedDateFunction: (day) {
                        if (day == null) {
                          taskModel.scheduledEndTime = null;
                        }
                      },
                      selectedTimeFunction: (time) {
                        if (time == null) {
                          taskModel.scheduledEndTime = null;
                        }
                      },
                      getFullTime: (time) {
                        if (time != "") {
                          taskModel.scheduledEndTime = time;
                        } else {
                          taskModel.scheduledEndTime = null;
                        }
                      }),
                  SizedBox(height: 20),
                  TextFielWidget(
                    title: 'Actual Start Time',
                    controller: TextEditingController(text: (taskModel.actualStartTime != null) ? DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(taskModel.actualStartTime ?? "")) : ""),
                    enabled: false,
                  ),
                  SizedBox(height: 20),
                  TextFielWidget(
                    title: 'Actual End Time',
                    controller: TextEditingController(text: (taskModel.actualStartTime != null) ? DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(taskModel.actualEndTime ?? "")) : ""),
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
                                  var fileName = await handleUploadFile();
                                  setState(() {
                                    taskModel.attachmentUrl = fileName;
                                  });
                                },
                                child: Icon(
                                  Icons.upload,
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
          );
        },
      ),
    );
  }
}
