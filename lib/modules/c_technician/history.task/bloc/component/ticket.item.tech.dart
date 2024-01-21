import 'package:dich_vu_it/app/constant/noti.comfirm.dart';
import 'package:dich_vu_it/app/theme/colors.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketItem extends StatefulWidget {
  final TicketResponseModel ticket;
  final Function(TicketResponseModel) onTap;

  const TicketItem({
    Key? key,
    required this.ticket,
    required this.onTap,
  }) : super(key: key);

  @override
  State<TicketItem> createState() => _TicketItemState();
}

class _TicketItemState extends State<TicketItem> {
  TicketResponseModel? ticket;
  Function(TicketResponseModel)? onTap;
  Function? callback;

  @override
  void initState() {
    super.initState();
    ticket = widget.ticket;
    onTap = widget.onTap;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildStatusIcon(),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  ticket!.title ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  ticket!.category?.name ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Created At: ${(ticket!.createdAt != null) ? DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(ticket!.createdAt!).toLocal()) : ""}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          (ticket!.ticketStatus == 2)
              ? ElevatedButton(
                  onPressed: () async {
                    var response = await showNoti(context);
                    if (response) {
                      var check = await TicketProvider.resolvedTicket(
                        ticket!.id ?? -1,
                      );
                      if (check == true) {
                        // Do something when the ticket is closed
                        showToast(
                          context: context,
                          msg: "Update successfully",
                          color: MyColors.success,
                          icon: const Icon(Icons.done),
                        );
                        setState(() {
                          ticket!.ticketStatus = 3;
                        });
                      } else {
                        showToast(
                          context: context,
                          msg:
                              "Cannot resovle ticket if all\nthe tasks are not completed",
                          color: MyColors.error,
                          icon: const Icon(Icons.warning),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: const Text(
                    "Resolved",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : (ticket!.ticketStatus == 3)
                  ? ElevatedButton(
                      onPressed: () async {
                        var response = await showNoti(context);
                        if (response) {
                          var check =
                              await TicketProvider.resolvedTicketToProgress(
                            ticket!.id ?? -1,
                          );
                          if (check == true) {
                            setState(() {
                              ticket!.ticketStatus = 2;
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      child: const Text(
                        "Progress",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : (ticket!.ticketStatus == 1)
                      ? ElevatedButton(
                          onPressed: () async {
                            var response = await showNoti(context);
                            if (response) {
                              var check = await TicketProvider.progressTicket(
                                ticket!.id ?? -1,
                              );
                              if (check == true) {
                                setState(() {
                                  ticket!.ticketStatus = 2;
                                });
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.blue),
                          child: const Text(
                            "Progress",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Container(),
        ],
      ),
    );
  }

  Widget _buildStatusIcon() {
    IconData icon;
    Color color;
    switch (ticket!.ticketStatus) {
      case 0:
        icon = Icons.access_time;
        color = MyColors.open;
        break;
      case 1:
        icon = Icons.assignment_ind;
        color = MyColors.assigned;
        break;
      case 2:
        icon = Icons.hourglass_bottom;
        color = MyColors.inProgress;
        break;
      case 3:
        icon = Icons.check_circle;
        color = MyColors.resolved;
        break;
      case 4:
        icon = Icons.archive;
        color = MyColors.closed;
        break;
      default:
        icon = Icons.cancel;
        color = MyColors.cancelled;
        break;
    }

    return Icon(
      icon,
      color: color,
      size: 24,
    );
  }
}
