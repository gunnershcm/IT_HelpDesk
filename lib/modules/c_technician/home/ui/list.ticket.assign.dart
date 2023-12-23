// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:animation_list/animation_list.dart';
import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/app/constant/noti.comfirm.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/modules/c_technician/home/ui/view.ticket.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListTicketAssign extends StatefulWidget {
  final List<TicketResponseModel> listTiket;
  const ListTicketAssign({super.key, required this.listTiket});

  @override
  State<ListTicketAssign> createState() => _ListTicketAssignState();
}

class _ListTicketAssignState extends State<ListTicketAssign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 243, 254),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Center(
          child: Text(
            "List of assigned tickets       ",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: AnimationList(
            children: widget.listTiket.map((element) {
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
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w500),
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
                                "Create : ${(element.createdAt != null) ? DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(element.createdAt!)) : ""}",
                                style: const TextStyle(fontSize: 12),
                              ),
                              const Text(""),
                            ],
                          )
                        ],
                      ),
                    )),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text(getNameTicketStatus(element.ticketStatus ?? -1),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: (element.ticketStatus == 0)
                                  ? Colors.grey
                                  : (element.ticketStatus == 1)
                                      ? Color.fromARGB(255, 154, 255, 223)
                                      : (element.ticketStatus == 2)
                                          ? Color.fromARGB(255, 154, 209, 255)
                                          : (element.ticketStatus == 3)
                                              ? const Color.fromARGB(
                                                  255, 2, 47, 84)
                                              : (element.ticketStatus == 4)
                                                  ? Colors.blue
                                                  : Colors.red)),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      ViewTicketAssigScreen(
                                    tiket: element,
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Center(
                            child: Text(
                              "View",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      if (element.ticketStatus != 3)
                        Expanded(
                            child: Row(
                          children: [
                            SizedBox(width: 2),
                            ElevatedButton(
                              onPressed: () async {
                                var response = await showNoti(context);
                                if (response) {
                                  var check =
                                      await TicketProvider.resolvedTicket(
                                          element.id ?? -1);
                                  if (check) {
                                    showToast(
                                      context: context,
                                      msg: "Update successfully",
                                      color: Colors.green,
                                      icon: const Icon(Icons.done),
                                    );
                                    setState(() {
                                      widget.listTiket.remove(element);
                                    });
                                  } else {
                                    showToast(
                                      context: context,
                                      msg:
                                          "Cannot resovle ticket if all\nthe tasks are not completed",
                                      color: Colors.orange,
                                      icon: const Icon(Icons.warning),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                "Resolved",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ))
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList()),
      ),
    );
  }
}
