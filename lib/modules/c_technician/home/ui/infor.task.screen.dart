// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/app/widgets/WAColors.dart';
import 'package:dich_vu_it/app/widgets/WAWidgets.dart';
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

import '../../../../app/theme/colors.dart';

class InforTaskScreen extends StatefulWidget {
  final TaskModel taskModel;
  final Function callBack;
  const InforTaskScreen(
      {super.key, required this.taskModel, required this.callBack});

  @override
  State<InforTaskScreen> createState() => _InforTaskScreenState();
}

class _InforTaskScreenState extends State<InforTaskScreen> {
  var bloc = HomeBloc();
  TaskModel taskModel = TaskModel();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController note = TextEditingController();
  bool _deleteIconVisible = false;
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
    description.text = taskModel.description ?? "";
    note.text = taskModel.note ?? "";
    date1 = DateFormat('dd-MM-yyyy')
        .format(DateTime.parse(taskModel.scheduledStartTime ?? ""));
    time1 = DateFormat('HH:mm')
        .format(DateTime.parse(taskModel.scheduledStartTime ?? ""));
    date2 = DateFormat('dd-MM-yyyy')
        .format(DateTime.parse(taskModel.scheduledEndTime ?? ""));
    time2 = DateFormat('HH:mm')
        .format(DateTime.parse(taskModel.scheduledEndTime ?? ""));
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
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                taskModel.title = title.text;
                taskModel.description = description.text;
                taskModel.note = note.text;
                if(taskModel.taskStatus == 2){
                  setState(() {
                    taskModel.progress = 100;
                  });
                }              
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
              color: MyColors.success,
              icon: const Icon(Icons.done),
            );
          } else if (state is HomeError) {
            Navigator.pop(context);
            showToast(
              context: context,
              msg: state.error,
              color: MyColors.error,
              icon: const Icon(Icons.warning),
            );
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ticket",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      maxLines: null,
                      controller: TextEditingController(
                          text: taskModel.ticket?.title ?? ""),
                      decoration: waInputDecoration(hint: ''),
                      readOnly: true,
                    ),
                  ),

                  SizedBox(height: 20),
                  const Text(
                    "Task status",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 225, 224, 224)),
                        borderRadius: BorderRadius.circular(12),
                        color: WAPrimaryColor.withOpacity(0.07)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: taskStatus.entries
                            .map((item) => DropdownMenuItem<int>(
                                value: item.key, child: Text(item.value)))
                            .toList(),
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
                  const Text(
                    "Title",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      maxLines: null,
                      controller: title,
                      decoration: waInputDecoration(hint: ''),
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      maxLines: null,
                      controller: description,
                      decoration: waInputDecoration(hint: ''),
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Note",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      maxLines: null,
                      controller: note,
                      decoration: waInputDecoration(hint: ''),
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Priority",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 225, 224, 224)),
                        borderRadius: BorderRadius.circular(12),
                        color: WAPrimaryColor.withOpacity(0.07)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: listPriority.entries
                            .map((item) => DropdownMenuItem<int>(
                                value: item.key, child: Text(item.value)))
                            .toList(),
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
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
                  // SizedBox(height: 20),
                  // TextFielWidget(
                  //   title: 'Actual Start Time',
                  //   controller: TextEditingController(text: (taskModel.actualStartTime != null) ? DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(taskModel.actualStartTime ?? "")) : ""),
                  //   enabled: false,
                  // ),
                  // SizedBox(height: 20),
                  // TextFielWidget(
                  //   title: 'Actual End Time',
                  //   controller: TextEditingController(text: (taskModel.actualStartTime != null) ? DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(taskModel.actualEndTime ?? "")) : ""),
                  //   enabled: false,
                  // ),
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
                                          if (taskModel.attachmentUrls != null)
                                            for (int index = 0;
                                                index <
                                                    taskModel
                                                        .attachmentUrls!.length;
                                                index++)
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl: taskModel
                                                              .attachmentUrls![
                                                          index],
                                                      placeholder: (context,
                                                              url) =>
                                                          CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          taskModel
                                                              .attachmentUrls!
                                                              .removeAt(index);
                                                        });
                                                        if (taskModel
                                                            .attachmentUrls!
                                                            .isEmpty) {
                                                          setState(() {
                                                            _deleteIconVisible =
                                                                false;
                                                          });
                                                        }
                                                      },
                                                      child: AnimatedOpacity(
                                                        opacity:
                                                            _deleteIconVisible
                                                                ? 1.0
                                                                : 0.0,
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          color: Colors.red,
                                                          child: Icon(
                                                            Icons.close,
                                                            color: Colors.white,
                                                            size: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        ],
                                      ),
                                    ),
                                    if (taskModel.attachmentUrls == null ||
                                        taskModel.attachmentUrls!.isEmpty)
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: InkWell(
                                            onTap: () async {
                                              var fileNames =
                                                  await handleUploadFile();
                                              print(fileNames);
                                              if (fileNames != null) {
                                                setState(() {
                                                  _deleteIconVisible = true;
                                                  taskModel.attachmentUrls =
                                                      fileNames;
                                                });
                                                print("a");
                                                print(fileNames);
                                                print(
                                                    "Test taskModel ${taskModel.attachmentUrls}");
                                                print("b");
                                              } else {
                                                // Handle the case where fileNames is null (upload failed)
                                                print("File upload failed");
                                              }
                                            },
                                            child: Icon(
                                              Icons.upload,
                                              size: 30,
                                              color: Colors.blue,
                                            ),
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
