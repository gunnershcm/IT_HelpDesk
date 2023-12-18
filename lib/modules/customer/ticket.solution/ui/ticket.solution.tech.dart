// ignore_for_file: prefer_const_constructors

import 'package:animation_list/animation_list.dart';
import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/app/widgets/dislike_button.dart';
import 'package:dich_vu_it/app/widgets/dislike_button_setting.dart';
import 'package:dich_vu_it/app/widgets/like_button.dart';
import 'package:dich_vu_it/app/widgets/like_button_setting.dart';
//import 'package:dich_vu_it/app/widgets/like_button.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/models/response/ticket.solution.model.dart';
import 'package:dich_vu_it/modules/customer/ticket.solution/bloc/solution.bloc.dart';
import 'package:dich_vu_it/modules/customer/ticket.solution/ui/view.ticket.solution.dart';
import 'package:dich_vu_it/provider/solution.provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// import '../bloc/history.bloc.dart';
// import 'infor.task.screen.dart';

class TicketSolutionPage extends StatefulWidget {
  const TicketSolutionPage({super.key});

  @override
  State<TicketSolutionPage> createState() => _TicketSolutionPageState();
}

class _TicketSolutionPageState extends State<TicketSolutionPage> {
  var bloc = TicketSolutionBloc();
  List<TicketSolutionModel> listSolution = [];
  TicketSolutionModel? selectedSolution =
      TicketSolutionModel(title: "All solutions");
  // bool isLiked = false;
  // int likeCount = 20;
  // double size = 20;

  @override
  void initState() {
    super.initState();
    bloc.add(GetAllSolutionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicketSolutionBloc, TicketSolutionState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is TicketSolutionLoading) {
          onLoading(context);
          return;
        } else if (state is GetListSolutionState) {
          listSolution = state.list;
          Navigator.pop(context);
        } else if (state is TicketSolutionError) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 229, 243, 254),
          appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: Row(),
            title: Center(
              child: Text(
                "Solution ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        height: 40,
                        child: DropdownSearch<TicketSolutionModel>(
                          popupProps: PopupPropsMultiSelection.menu(
                            showSearchBox: true,
                          ),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              constraints: const BoxConstraints.tightFor(
                                width: 300,
                                height: 40,
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
                              SolutionProvider.getAllListSolutionFillter(),
                          itemAsString: (TicketSolutionModel u) =>
                              "${u.title!} ${u.createdAt != null ? "(${(u.createdAt != null) ? DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(u.createdAt!).toLocal()) : ""})" : ""}",
                          selectedItem: selectedSolution,
                          onChanged: (value) {
                            setState(() {
                              selectedSolution = value!;
                              if (selectedSolution?.id != null && selectedSolution!.id! > 0) {
                                bloc.add(FixListEvent(ticketSolutionModel: selectedSolution!));
                              } else {
                                bloc.add(GetAllSolutionEvent());
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                    child: AnimationList(
                  children: listSolution.isNotEmpty
                      ? listSolution.map((element) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 135,
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
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        ViewSolutionDetail(
                                      solution: element,
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
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        //decoration: BoxDecoration(color: colorTaskStatus(element.taskStatus ?? 1), borderRadius: BorderRadius.circular(10)),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Status: ",
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                        ),
                                        TextSpan(
                                          text:
                                              "${getApproveStatus(element.isApproved)}",
                                          style: element.isApproved == true
                                              ? TextStyle(color: Colors.green)
                                              : TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Visibility: ",
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                        ),
                                        TextSpan(
                                          text:
                                              "${getPublicStatus(element.isPublic)}",
                                          style: element.isPublic == true
                                              ? TextStyle(color: Colors.green)
                                              : TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //SizedBox(height: 5),
                                  // Text(
                                  //   "Scheduled: ${DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(element.reviewDate ?? ""))} >> ${DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(element.expiredDate ?? ""))}",
                                  //   style: TextStyle(),
                                  // ),
                                  SizedBox(height: 5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      LikeButtonWidget(
                                        isLike(element.currentReactionUser),
                                        element.countLike!,
                                        element.id!,                                      
                                      ),
                                      SizedBox(width: 20.0),
                                      DisLikeButtonWidget(
                                        isDislike(element.currentReactionUser),
                                        element.countDislike!,
                                        element.id!
                                      ),
                                      // DisLikeButton(
                                      //   size: size,
                                      //   isLiked: isLiked,
                                      //   likeCount: likeCount,
                                      // ),
                                    ],
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
