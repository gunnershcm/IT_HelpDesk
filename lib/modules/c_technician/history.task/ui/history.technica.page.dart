// // ignore_for_file: prefer_const_constructors

// import 'package:animation_list/animation_list.dart';
// import 'package:dich_vu_it/app/constant/enum.dart';
// import 'package:dich_vu_it/app/widgets/loading.dart';
// import 'package:dich_vu_it/models/response/task.model.dart';
// import 'package:dich_vu_it/models/response/ticket.response.model.dart';
// import 'package:dich_vu_it/provider/ticket.provider.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';

// import '../bloc/history.bloc.dart';
// import 'infor.task.screen.dart';

// class HistoryTaskPage extends StatefulWidget {
//   const HistoryTaskPage({super.key});

//   @override
//   State<HistoryTaskPage> createState() => _HistoryTaskPageState();
// }

// class _HistoryTaskPageState extends State<HistoryTaskPage> {
//   var bloc = HistoryTaskBloc();
//   List<TaskModel> listTask = [];
//   TicketResponseModel? selectedTicket =
//       TicketResponseModel(title: "All tickets");

//   @override
//   void initState() {
//     super.initState();
//     bloc.add(GetAllListTaskInactiveEvent());
//   }

//   @override
// void dispose() {
//   // Dispose of your AnimationController and other resources here
//   super.dispose();
// }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HistoryTaskBloc, HistoryTaskState>(
//       bloc: bloc,
//       listener: (context, state) {
//         if (state is HistoryTaskLoading) {
//           onLoading(context);
//           return;
//         } else if (state is GetListTaskInactiveSuccessState) {
//           listTask = state.list;
//           Navigator.pop(context);
//         } else if (state is HistoryTaskError) {
//           Navigator.pop(context);
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: Color.fromARGB(255, 229, 243, 254),
//           appBar: AppBar(
//             backgroundColor: Colors.blue,
//             leading: Row(),
//             title: Center(
//               child: Text(
//                 "Task history",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 25,
//                     fontWeight: FontWeight.w600),
//               ),
//             ),
//           ),
//           body: Container(
//             padding: EdgeInsets.all(15),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10)),
//                         height: 40,
//                         child: DropdownSearch<TicketResponseModel>(
//                           popupProps: PopupPropsMultiSelection.menu(
//                             showSearchBox: true,
//                           ),
//                           dropdownDecoratorProps: DropDownDecoratorProps(
//                             dropdownSearchDecoration: InputDecoration(
//                               constraints: const BoxConstraints.tightFor(
//                                 width: 300,
//                                 height: 40,
//                               ),
//                               contentPadding:
//                                   const EdgeInsets.only(left: 14, bottom: 14),
//                               focusedBorder: const OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(0),
//                                 ),
//                                 borderSide:
//                                     BorderSide(color: Colors.white, width: 0),
//                               ),
//                               hintText: "",
//                               hintMaxLines: 1,
//                               enabledBorder: const OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(10),
//                                 ),
//                                 borderSide:
//                                     BorderSide(color: Colors.white, width: 0),
//                               ),
//                             ),
//                           ),
//                           asyncItems: (String? filter) => TicketProvider
//                               .getAllListTicketAssignDoneFillter(),
//                           itemAsString: (TicketResponseModel u) =>
//                               "${u.title!} ${u.createdAt != null ? "(${(u.createdAt != null) ? DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(u.createdAt!).toLocal()) : ""})" : ""}",
//                           selectedItem: selectedTicket,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedTicket = value!;
//                               bloc.add(GetAllListTaskInactiveEvent(
//                                   idTicket: selectedTicket?.id));
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Expanded(
//                     child: AnimationList(
//                   children: listTask.isNotEmpty
//                       ? listTask.map((element) {
//                           return Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: 130,
//                             padding: EdgeInsets.all(10),
//                             margin: EdgeInsets.only(bottom: 15),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   blurRadius: 8,
//                                   offset: Offset(3, 3),
//                                 ),
//                               ],
//                             ),
//                             child: InkWell(
//                               onTap: () {
//                                 //
//                                 Navigator.push<void>(
//                                   context,
//                                   MaterialPageRoute<void>(
//                                     builder: (BuildContext context) =>
//                                         InforTaskScreen(
//                                       taskModel: element,
//                                       callBack: (value) {
//                                         if (value != null) {
//                                           setState(() {
//                                             element = value;
//                                           });
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Expanded(
//                                         child: Text(
//                                           element.title ?? "",
//                                           style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 20),
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Container(
//                                         width: 20,
//                                         height: 20,
//                                         decoration: BoxDecoration(
//                                             color: colorTaskStatus(
//                                                 element.taskStatus ?? 1),
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                       )
//                                     ],
//                                   ),
//                                   SizedBox(height: 5),
//                                   Text(
//                                     "Ticket: ${element.ticket?.title ?? ""}",
//                                     style: TextStyle(),
//                                   ),
//                                   SizedBox(height: 5),
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Text(
//                                           "Priority: ${nameFromPriority(element.priority ?? 0)}",
//                                           style: TextStyle(),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           "Progress: ${element.progress ?? 0} %",
//                                           style: TextStyle(),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 5),
//                                   Text(
//                                     "Scheduled: ${DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(element.scheduledStartTime ?? ""))} >> ${DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(element.scheduledEndTime ?? ""))}",
//                                     style: TextStyle(),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }).toList()
//                       : [],
//                 ))
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
