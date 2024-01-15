// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, must_be_immutable

import 'package:dich_vu_it/app/widgets/WAColors.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/pick.date.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/modules/c_technician/home/bloc/home.bloc.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/colors.dart';

class EditTicketTechnicianScreen extends StatefulWidget {
  Function callBack;
  final TicketResponseModel ticket;
  EditTicketTechnicianScreen(
      {super.key, required this.ticket, required this.callBack});

  @override
  State<EditTicketTechnicianScreen> createState() =>
      _EditTicketTechnicianScreenState();
}

class _EditTicketTechnicianScreenState
    extends State<EditTicketTechnicianScreen> {
  var bloc = HomeBloc();
  TicketResponseModel ticket = TicketResponseModel();
  TextEditingController description = TextEditingController();
  Map<int, String> listImpact = {
    0: 'Low',
    1: 'Medium',
    2: 'High',
  };
  int? selectedImpact;
  Map<int, String> listPriority = {
    0: 'Low',
    1: 'Medium',
    2: 'High',
    3: 'Critical',
  };
  int selectedPriority = 0;

  List<String> listType = ["Offline", "Online"];
  String? selectedType = "";

  var date1;
  var time1;
  var date2;
  var time2;
  @override
  void initState() {
    super.initState();
    ticket = widget.ticket;
    selectedImpact = widget.ticket.impact;
    description.text = widget.ticket.impactDetail ?? "";
    selectedPriority = widget.ticket.priority ?? 0;
    // date1 = ticket.scheduledStartTime != null
    // ? DateFormat('dd-MM-yyyy').format(DateTime.parse(ticket.scheduledStartTime!))
    // : "";
    // time1 = ticket.scheduledStartTime != null
    // ? DateFormat('HH:mm').format(DateTime.parse(ticket.scheduledStartTime!))
    // : "";
    // date2 = ticket.scheduledEndTime != null
    // ? DateFormat('dd-MM-yyyy').format(DateTime.parse(ticket.scheduledEndTime!))
    // : "";
    // time2 = ticket.scheduledEndTime != null
    // ? DateFormat('HH:mm').format(DateTime.parse(ticket.scheduledEndTime!))
    // : "";
    //selectedType = widget.ticket.type ?? "";
    // date1 = DateFormat('dd-MM-yyyy')
    //     .format(DateTime.parse(ticket.scheduledStartTime ?? ""));
    // time1 = DateFormat('HH:mm')
    //     .format(DateTime.parse(ticket.scheduledStartTime ?? ""));
    // date2 = DateFormat('dd-MM-yyyy')
    //     .format(DateTime.parse(ticket.scheduledEndTime ?? ""));
    // time2 = DateFormat('HH:mm')
    //     .format(DateTime.parse(ticket.scheduledEndTime ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            print(widget.ticket.toMap());
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Center(
          child: Text(
            "Evaluate ticket",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         taskModel.title = title.text;
        //         taskModel.description = moTa.text;
        //         taskModel.note = note.text;
        //         bloc.add(UpdateTaskTicketEvent(taskModel: taskModel));
        //       },
        //       icon: Icon(
        //         Icons.done,
        //         color: Colors.white,
        //         size: 30,
        //       ))
        // ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: bloc,
        listener: (context, state) async {
          if (state is HomeLoading) {
            onLoading(context);
            return;
          } else if (state is EditTicketSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            widget.callBack(ticket);
            showToast(
              context: context,
              msg: "Edit ticket successfully",
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
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 229, 243, 254),
                borderRadius: BorderRadius.circular(10)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Impact",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: listImpact.entries
                            .map((item) => DropdownMenuItem<int>(
                                value: item.key, child: Text(item.value)))
                            .toList(),
                        value: selectedImpact,
                        onChanged: (value) {
                          setState(() {
                            selectedImpact = value as int;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Impact Detail",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: description,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                      ),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: listPriority.entries
                            .map((item) => DropdownMenuItem<int>(
                                value: item.key, child: Text(item.value)))
                            .toList(),
                        value: selectedPriority,
                        onChanged: (value) {
                          setState(() {
                            selectedPriority = value as int;
                            //tiket.priority = selectedPriority;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Type",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: listType.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                                value), // Hiển thị giá trị là văn bản của mục
                          );
                        }).toList(),
                        value: ticket.type,
                        onChanged: (value) {
                          setState(() {
                            ticket.type = value as String;
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
                      'Start Time:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    dateDisplay: date1,
                    timeDisplay: time1,
                    selectedDateFunction: (day) {
                      if (day == null) {
                        ticket.scheduledStartTime = null;
                      }
                    },
                    selectedTimeFunction: (time) {
                      if (time == null) {
                        ticket.scheduledStartTime = null;
                      } else {
                        ticket.scheduledStartTime = time;
                      }
                    },
                    getFullTime: (time) {
                      if (time != null && time.isNotEmpty) {
                        ticket.scheduledStartTime = time;
                      } else {
                        ticket.scheduledStartTime = null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  DatePickerBox1(
                      requestDayBefore: date1,
                      isTime: true,
                      label: Text(
                        'End Time:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      dateDisplay: date2,
                      timeDisplay: time2,
                      selectedDateFunction: (day) {
                        if (day == null) {
                          ticket.scheduledEndTime = null;
                        }
                      },
                      selectedTimeFunction: (time) {
                        if (time == null) {
                          ticket.scheduledEndTime = null;
                        }
                      },
                      getFullTime: (time) {
                        if (time != "") {
                          ticket.scheduledEndTime = time;
                        } else {
                          ticket.scheduledEndTime = null;
                        }
                      }),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        child: InkWell(
                          onTap: () async {
                            ticket.impact = selectedImpact;
                            ticket.impactDetail = description.text;
                            bloc.add(
                                UpdateTicketEvent(ticketResponseModel: ticket));
                          },
                          child: Center(
                            child: Text(
                              "OK",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
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
