// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:dich_vu_it/app/widgets/drop.search.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/pick.date.dart';
import 'package:dich_vu_it/app/widgets/textfiel.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
import 'package:dich_vu_it/models/request/request.task.model.dart';
import 'package:dich_vu_it/models/response/tiket.response.model.dart';
import 'package:dich_vu_it/modules/c_technician/home/bloc/home.bloc.dart';
import 'package:dich_vu_it/provider/file.provider.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskScreen extends StatefulWidget {
  final Function callBack;
  const AddTaskScreen({super.key, required this.callBack});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var bloc = HomeBloc();
  RequestTaskModel requestTaskModel = RequestTaskModel(taskStatus: 0);
  TextEditingController title = TextEditingController();
  TextEditingController moTa = TextEditingController();
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
    requestTaskModel.priority = 0;
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
        title: Text(
          "Create task",
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: bloc,
        listener: (context, state) async {
          if (state is HomeLoading) {
            onLoading(context);
            return;
          } else if (state is CareatedTaskSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            widget.callBack(true);
            showToast(
              context: context,
              msg: "Create a new task successfully",
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
                  const Text(
                    "Ticket",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  DropSearchWidget<TicketResponseModel>(
                    getList: TicketProvider.getAllListTicketAssign(),
                    title: (TicketResponseModel u) => u.title ?? "",
                    onChange: (value) {
                      requestTaskModel.ticketId = value?.id;
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
                        value: selectedPriority,
                        onChanged: (value) {
                          setState(() {
                            selectedPriority = value as int;
                            requestTaskModel.priority = selectedPriority;
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
                          requestTaskModel.scheduledStartTime = null;
                        }
                      },
                      selectedTimeFunction: (time) {
                        if (time == null) {
                          requestTaskModel.scheduledStartTime = null;
                        }
                      },
                      getFullTime: (time) {
                        if (time != "") {
                          requestTaskModel.scheduledStartTime = time;
                        } else {
                          requestTaskModel.scheduledStartTime = null;
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
                          requestTaskModel.scheduledEndTime = null;
                        }
                      },
                      selectedTimeFunction: (time) {
                        if (time == null) {
                          requestTaskModel.scheduledEndTime = null;
                        }
                      },
                      getFullTime: (time) {
                        if (time != "") {
                          requestTaskModel.scheduledEndTime = time;
                        } else {
                          requestTaskModel.scheduledEndTime = null;
                        }
                      }),
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
                                (requestTaskModel.attachmentUrl != null) ? "File uploaded" : "Upload file",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                                onTap: () async {
                                  var fileName = await handleUploadFile();
                                  setState(() {
                                    requestTaskModel.attachmentUrl = fileName;
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.orange),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
                        child: InkWell(
                          onTap: () {
                            requestTaskModel.title = title.text;
                            requestTaskModel.description = moTa.text;
                            print(requestTaskModel.toMap());
                            bloc.add(CreateTaskCustomer(requestTaskModel: requestTaskModel));
                          },
                          child: Center(
                            child: Text(
                              "Create",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
