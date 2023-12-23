// ignore_for_file: prefer_const_constructors

import 'package:animation_list/animation_list.dart';
import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/models/response/task.model.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/modules/c_technician/home/bloc/home.bloc.dart';
import 'package:dich_vu_it/modules/c_technician/home/ui/add.task.screen.dart';
import 'package:dich_vu_it/modules/customer/notification/notification.page.dart';
import 'package:dich_vu_it/provider/noti.provider.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'infor.task.screen.dart';
import 'list.ticket.assign.dart';

class HomeTechiacaPage extends StatefulWidget {
  const HomeTechiacaPage({super.key});

  @override
  State<HomeTechiacaPage> createState() => _HomeTechiacaPageState();
}

class _HomeTechiacaPageState extends State<HomeTechiacaPage> {
  var bloc = HomeBloc();
  List<TicketResponseModel> listTiketAssign = [];
  List<TaskModel> listTask = [];
  TicketResponseModel? selectedTicket =
      TicketResponseModel(title: "All tickets");
  int countNoti = 0;
  void getNoti() async {
    var noti = await NotiProvider.getCountNoti();
    setState(() {
      countNoti = noti;
    });
  }

  @override
  void initState() {
    super.initState();
    bloc.add(GetListTicketAssignEvent());
    getNoti();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is HomeLoading) {
          onLoading(context);
          return;
        } else if (state is GetListTicketAssignSuccessState) {
          listTiketAssign = state.list;
          Navigator.pop(context);
          bloc.add(GetAllListTaskActiveEvent());
        } else if (state is GetListTaskActiveSuccessState) {
          Navigator.pop(context);
          listTask = state.list;
        } else if (state is HomeError) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 229, 243, 254),
          appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),
            title: Center(
              child: Text(
                "IT_HelpDesk",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
            actions: [
              InkWell(
                onTap: () async {
                  await Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const NotificationPage(),
                    ),
                  );
                  getNoti();
                },
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.white,
                    ),
                    if (countNoti > 0)
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 248, 88, 77),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                  ],
                ),
              ),
              SizedBox(width: 10)
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(15),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 8,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "You currently have ${listTiketAssign.length} assigned tickets",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        width: 70,
                        decoration: BoxDecoration(
                            border: Border(
                                left:
                                    BorderSide(width: 1, color: Colors.grey))),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      ListTicketAssign(
                                    listTiket: listTiketAssign,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "View",
                              style: TextStyle(fontSize: 17),
                            )),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        height: 40,
                        child: DropdownSearch<TicketResponseModel>(
                          popupProps: PopupPropsMultiSelection.menu(
                            showSearchBox: true,
                            searchDelay: const Duration(milliseconds: 500),
                          ),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              constraints: const BoxConstraints.tightFor(
                                width: 300,
                                height: 30,
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
                              hintMaxLines: 1,
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
                              TicketProvider.getAllListTicketAssignFillter(),
                          itemAsString: (TicketResponseModel u) =>
                              "${u.title!} ${u.createdAt != null ? "(${(u.createdAt != null) ? DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(u.createdAt!).toLocal()) : ""})" : ""}",
                          selectedItem: selectedTicket,
                          onChanged: (value) {
                            setState(() {
                              selectedTicket = value!;
                              bloc.add(GetAllListTaskActiveEvent(
                                  idTicket: selectedTicket?.id));
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => AddTaskScreen(
                                callBack: (value) {
                                  if (value == true) {
                                    bloc.add(GetAllListTaskActiveEvent(
                                        idTicket: selectedTicket?.id));
                                  }
                                },
                              ),
                            ),
                          );
                        },
                        child: Center(
                            child: Text(
                          "Add a Task",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                    child: AnimationList(
                  children: (listTask.isNotEmpty)
                      ? listTask.map((element) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 130,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 8,
                                  offset: Offset(3, 3),
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                //
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        InforTaskScreen(
                                      taskModel: element,
                                      callBack: (value) {
                                        if (value != null) {
                                          setState(() {
                                            element = value;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          element.title ?? "",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: colorTaskStatus(
                                                element.taskStatus ?? 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Ticket: ${element.ticket?.title ?? ""}",
                                    style: TextStyle(),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Priority: ${nameFromPriority(element.priority ?? 0)}",
                                          style: TextStyle(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Progress: ${element.progress ?? 0} %",
                                          style: TextStyle(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Scheduled: ${DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(element.scheduledStartTime ?? ""))} >> ${DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(element.scheduledEndTime ?? ""))}",
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList()
                      : [],
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
