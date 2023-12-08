// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/app/constant/noti.comfirm.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/models/request/request.create.tikcket.model.dart';
import 'package:dich_vu_it/models/response/tiket.response.model.dart';
import 'package:dich_vu_it/modules/customer/notification/notification.page.dart';
import 'package:dich_vu_it/modules/customer/ticket/bloc/ticket.bloc.dart';
import 'package:dich_vu_it/modules/customer/ticket/ui/edit.ticket.dart';
import 'package:dich_vu_it/modules/customer/ticket/ui/view.ticket.dart';
import 'package:dich_vu_it/provider/noti.provider.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:animation_list/animation_list.dart';
import 'create.ticket.dart';

class TicketCustomerScreen extends StatefulWidget {
  const TicketCustomerScreen({super.key});

  @override
  State<TicketCustomerScreen> createState() => _TicketCustomerScreenState();
}

class _TicketCustomerScreenState extends State<TicketCustomerScreen> {
  final _bloc = TicketBloc();
  List<TicketResponseModel> listTicket = [];
  TicketResponseModel? selectedTicket;
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
    getNoti();
    _bloc.add(GetAllListTicket());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 243, 254),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Icon(
          Icons.person,
          size: 30,
          color: Colors.white,
        ),
        title: Text(
          "IT_HelpDesk",
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const NotificationPage(),
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
                    decoration: BoxDecoration(color: const Color.fromARGB(255, 248, 88, 77), borderRadius: BorderRadius.circular(10)),
                  ),
              ],
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
      body: BlocConsumer<TicketBloc, TicketState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is TicketLoading) {
            onLoading(context);
            return;
          } else if (state is TicketSuccessState) {
            Navigator.pop(context);
            listTicket = state.list;
          } else if (state is TicketError) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        height: 40,
                        child: DropdownSearch<TicketResponseModel>(
                          popupProps: PopupPropsMultiSelection.menu(
                            showSearchBox: true,
                          ),
                          dropdownButtonProps: DropdownButtonProps(
                            icon: Icon(Icons.search),
                          ),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              constraints: const BoxConstraints.tightFor(
                                width: 300,
                                height: 40,
                              ),
                              contentPadding: const EdgeInsets.only(left: 14, bottom: 14),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                                borderSide: BorderSide(color: Colors.white, width: 0),
                              ),
                              hintText: "",
                              hintMaxLines: 1,
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(color: Colors.white, width: 0),
                              ),
                            ),
                          ),
                          asyncItems: (String? filter) => TicketProvider.getAllListTicket(),
                          itemAsString: (TicketResponseModel u) => "${u.title!} (${(u.createdAt != null) ? DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(u.createdAt!).toLocal()) : ""})",
                          // selectedItem: selectedTicket,
                          onChanged: (value) {
                            setState(() {
                              // selectedTicket = value!;
                              if (value?.ticketStatus == 0) {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => EditTickket(
                                      callBack: (value) {
                                        if (value != null) {
                                          setState(() {
                                            value?.title = value.title;
                                            value?.categoryId = value.categoryId;
                                            value?.category?.name = value.categoryName;
                                            value?.attachmentUrl = value.attachmentUrl;
                                            value?.priority = value.priority;
                                            value?.description = value.description;
                                          });
                                        }
                                      },
                                      request: RequestCreateTicketModel(id: value?.id, title: value?.title, categoryId: value?.categoryId, categoryName: value?.category?.name, attachmentUrl: value?.attachmentUrl, priority: value?.priority, description: value?.description),
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => ViewTicketScreen(
                                      tiket: value!
                                    ),
                                  ),
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => CreateTickket(
                                callBack: (value) {
                                  if (value == true) {
                                    _bloc.add(GetAllListTicket());
                                  }
                                },
                              ),
                            ),
                          );
                        },
                        child: Center(
                            child: Text(
                          "Add a Ticket",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                    child: Center(
                  child: AnimationList(
                      children: listTicket.map((element) {
                    return Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/background_ticket.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          element.title ?? "",
                                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          element.category?.name ?? "",
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Create : ${(element.createdAt != null) ? DateFormat('HH:mm   dd-MM-yyyy').format(DateTime.parse(element.createdAt!).toLocal()) : ""}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(""),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Text(
                                  getNameTicketStatus(element.ticketStatus ?? -1),
                                  style: TextStyle(
                                      color: (element.ticketStatus == 0)
                                          ? Colors.grey
                                          : (element.ticketStatus == 1)
                                              ? Color.fromARGB(255, 154, 255, 223)
                                              : (element.ticketStatus == 2)
                                                  ? Color.fromARGB(255, 154, 209, 255)
                                                  : (element.ticketStatus == 3)
                                                      ? const Color.fromARGB(255, 2, 47, 84)
                                                      : (element.ticketStatus == 4)
                                                          ? Colors.blue
                                                          : Colors.red),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      if (element.ticketStatus == 0) {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) => EditTickket(
                                              callBack: (value) {
                                                if (value != null) {
                                                  setState(() {
                                                    element.title = value.title;
                                                    element.categoryId = value.categoryId;
                                                    element.category?.name = value.categoryName;
                                                    element.attachmentUrl = value.attachmentUrl;
                                                    element.priority = value.priority;
                                                    element.description = value.description;
                                                  });
                                                }
                                              },
                                              request: RequestCreateTicketModel(id: element.id, title: element.title, categoryId: element.categoryId, categoryName: element.category?.name, attachmentUrl: element.attachmentUrl, priority: element.priority, description: element.description),
                                            ),
                                          ),
                                        );
                                      } else {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) => ViewTicketScreen(
                                              tiket: element
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        "View",
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                (element.ticketStatus == 0)
                                    ? Expanded(
                                        child: ElevatedButton(
                                        onPressed: () async {
                                          var response = await showNoti(context);
                                          if (response) {
                                            var check = await TicketProvider.cancelTicket(element.id ?? -1);
                                            if (check == true) {
                                              setState(() {
                                                listTicket.remove(element);
                                              });
                                            }
                                          }
                                        },
                                        child: Text("Cancel"),
                                      ))
                                    : (element.ticketStatus == 3)
                                        ? Expanded(
                                            child: ElevatedButton(
                                            onPressed: () async {
                                              var response = await showNoti(context);
                                              if (response) {
                                                var check = await TicketProvider.closeTicket(element.id ?? -1);
                                                if (check == true) {
                                                  setState(() {
                                                    listTicket.remove(element);
                                                  });
                                                }
                                              }
                                            },
                                            child: Text("Close"),
                                          ))
                                        : Container()
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList()),
                  // duration: 1000,
                  // reBounceDepth: 10.0,
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}
