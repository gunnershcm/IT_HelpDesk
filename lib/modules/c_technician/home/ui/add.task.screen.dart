// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dich_vu_it/app/widgets/WAColors.dart';
import 'package:dich_vu_it/app/widgets/WAWidgets.dart';
import 'package:dich_vu_it/app/widgets/drop.search.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/pick.date.dart';
import 'package:dich_vu_it/app/widgets/textfiel.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
import 'package:dich_vu_it/models/request/request.task.model.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/modules/c_technician/home/bloc/home.bloc.dart';
import 'package:dich_vu_it/provider/file.provider.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/colors.dart';

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
  TextEditingController description = TextEditingController();
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
    requestTaskModel.priority = 0;
  }

  Future<List<TicketResponseModel>> getTicketAvailable() async {
    var filterTicket;
    filterTicket = await TicketProvider.getAllListTicketAssignFillter();
    filterTicket = filterTicket
        .where((element) =>
            element.ticketStatus == 1 ||
            element.ticketStatus == 2 ||
            element.ticketStatus == 3)
        .toList();

    return filterTicket; // Add this line to return the filtered list
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
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
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
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 225, 224, 224)),
                          borderRadius: BorderRadius.circular(12),
                          color: WAPrimaryColor.withOpacity(0.07)),
                      child: DropdownSearch<TicketResponseModel>(
                        popupProps: PopupPropsMultiSelection.menu(
                            //showSearchBox: true,
                            ),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration:
                              // waInputDecoration(hint: ''),
                              InputDecoration(
                            constraints: const BoxConstraints.tightFor(
                              width: 300,
                              height: 50,
                            ),
                            contentPadding:
                                const EdgeInsets.only(left: 14, bottom: 14),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(0),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0),
                            ),
                            hintText: "",
                            hintMaxLines: null,
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0),
                            ),
                          ),
                        ),
                        asyncItems: (String? filter) =>
                            getTicketAvailable(),
                        itemAsString: (TicketResponseModel u) => u.title ?? "",
                        onChanged: (value) {
                          requestTaskModel.ticketId = value?.id;
                        },
                      )),
                  // Container(
                  //    width: MediaQuery.of(context).size.width,
                  //       height: 55,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(
                  //           color: Color.fromARGB(255, 225, 224, 224)),
                  //       borderRadius: BorderRadius.circular(12),
                  //       color: WAPrimaryColor.withOpacity(0.07)),
                  //   child: DropSearchWidget<TicketResponseModel>(
                  //     getList: TicketProvider.getAllListTicketAssign(),
                  //     title: (TicketResponseModel u) => u.title ?? "",
                  //     onChange: (value) {
                  //       requestTaskModel.ticketId = value?.id;
                  //     },
                  //   ),
                  // ),
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
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
                          height: 80,
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Wrap(
                                  spacing: 16.0,
                                  runSpacing: 8.0,
                                  children: [
                                    if (requestTaskModel.attachmentUrls != null)
                                      for (int index = 0;
                                          index <
                                              requestTaskModel
                                                  .attachmentUrls!.length;
                                          index++)
                                        Stack(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: requestTaskModel
                                                    .attachmentUrls![index],
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
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
                                                    requestTaskModel
                                                        .attachmentUrls!
                                                        .removeAt(index);
                                                  });
                                                  if (requestTaskModel
                                                      .attachmentUrls!
                                                      .isEmpty) {
                                                    setState(() {
                                                      _deleteIconVisible =
                                                          false;
                                                    });
                                                  }
                                                },
                                                child: AnimatedOpacity(
                                                  opacity: _deleteIconVisible
                                                      ? 1.0
                                                      : 0.0,
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  child: Container(
                                                    padding: EdgeInsets.all(4),
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
                              if (requestTaskModel.attachmentUrls == null ||
                                  requestTaskModel.attachmentUrls!.isEmpty)
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
                                            requestTaskModel.attachmentUrls =
                                                fileNames;
                                          });
                                          print("a");
                                          print(fileNames);
                                          print(
                                              "Test requestTaskModel ${requestTaskModel.attachmentUrls}");
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.orange),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              "Cancel",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        child: InkWell(
                          onTap: () {
                            requestTaskModel.title = title.text;
                            requestTaskModel.description = description.text;
                            print(requestTaskModel.toMap());
                            bloc.add(CreateTaskCustomer(
                                requestTaskModel: requestTaskModel));
                          },
                          child: Center(
                            child: Text(
                              "Create",
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
