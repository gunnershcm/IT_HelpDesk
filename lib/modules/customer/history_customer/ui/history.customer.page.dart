// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/modules/customer/history_customer/bloc/history.customer.bloc.dart';
import 'package:dich_vu_it/modules/customer/notification/notification.page.dart';
import 'package:dich_vu_it/provider/noti.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'view.details.ticket.dart';

class HistoryCustomerScreen extends StatefulWidget {
  const HistoryCustomerScreen({super.key});

  @override
  State<HistoryCustomerScreen> createState() => _HistoryCustomerScreenState();
}

class _HistoryCustomerScreenState extends State<HistoryCustomerScreen> {
  final ScrollController _scrollController = ScrollController();
  final _bloc = HistoryCustomerBloc();
  int numberPage = 1;
  List<TicketResponseModel> listTicket = [];
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
    _bloc.add(GetAllListHistoryCustomer(page: numberPage, pageSize: 20));
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
          "History",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
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
      body: BlocConsumer<HistoryCustomerBloc, HistoryCustomerState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is HistoryCustomerLoading) {
            onLoading(context);
            return;
          } else if (state is HistoryCustomerSuccessState) {
            listTicket = state.list;
            Navigator.pop(context);
          } else if (state is HistoryCustomerError) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollEndNotification &&
                  _scrollController.position.extentAfter == 0) {
                numberPage += 1;
                _bloc.add((GetAllListHistoryCustomer(
                    page: numberPage, pageSize: 20)));
              } else if (scrollNotification is ScrollEndNotification &&
                  _scrollController.position.extentBefore == 0) {
                // setState(() {
                //   listTicket = [];
                //   numberPage = 1;
                // });
                // _bloc.add((GetAllListHistoryCustomer(page: numberPage, pageSize: 20)));
              }
              return true;
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: listTicket.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(10),
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
                                      listTicket[index].title ?? "",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      listTicket[index].category?.name ?? "",
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
//<<<<<<< HEAD
                                      "Complete : ${(listTicket[index].completedTime != null) ? DateFormat('HH:mm  dd-MM-yyyy').format(DateTime.parse(listTicket[index].completedTime!)) : ""}",
                                      style: TextStyle(fontSize: 12),
//=======
                                      // "Create : ${(listTicket[index].createdAt != null) ? DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(listTicket[index].createdAt!)) : ""}",
                                      // style: TextStyle(fontSize: 10),
//>>>>>>> 7513f188110bc95233e8488079e497af43086c08
                                    ),
                                    (listTicket[index].completedTime != null &&
                                            listTicket[index].ticketStatus ==
                                                TicketStatus.closed.value)
                                        ? Text(
                                            "Finished :${DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(listTicket[index].completedTime!))}    ",
                                            style: TextStyle(fontSize: 10),
                                          )
                                        : Text(""),
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
                              getNameTicketStatus(
                                  listTicket[index].ticketStatus ?? -1),
                              style: TextStyle(
                                  color: listTicket[index].ticketStatus ==
                                          TicketStatus.cancelled.value
                                      ? Colors.red
                                      : Colors.blue),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          ViewDetailsTicketScreen(
                                        tiket: listTicket[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    "View",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
