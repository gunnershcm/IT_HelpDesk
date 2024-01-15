// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:dich_vu_it/app/constant/enum.dart';

import 'package:dich_vu_it/models/response/ticket.solution.model.dart';
import 'package:dich_vu_it/models/response/user.login.response.model.dart';
import 'package:dich_vu_it/models/response/user.login.response.model.dart';
import 'package:dich_vu_it/models/response/user.profile.response.model.dart';
import 'package:dich_vu_it/modules/c_technician/ticket.solution/comment/comment.solution.dart';
import 'package:dich_vu_it/provider/file.provider.dart';
import 'package:dich_vu_it/provider/solution.provider.dart';
import 'package:dich_vu_it/repository/authentication.repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dich_vu_it/modules/c_technician/ticket.solution/ui/edit.solution.screen.dart';

class ViewSolutionDetail extends StatefulWidget {
  final TicketSolutionModel solution;
  final int? id;
  const ViewSolutionDetail(
      {super.key, required this.solution, required this.id});

  @override
  State<ViewSolutionDetail> createState() => _ViewSolutionDetailState();
}

class _ViewSolutionDetailState extends State<ViewSolutionDetail> {
  TicketSolutionModel solution = TicketSolutionModel();
  UserProfileResponseModel? selectedManager;
  int? id;
  @override
  void initState() {
    super.initState();
    solution = widget.solution;
    id = widget.id;
  }

  // var bloc = HomeBloc();
  // TaskModel taskModel = TaskModel();
// TextEditingController title = TextEditingController();
  // TextEditingController moTa = TextEditingController();
  // TextEditingController note = TextEditingController();

  // var date1;
  // var time1;
  // var date2;
  // var time2;async {
  // @override
  // void initState() {
  //   super.initState();
  //   //taskModel = widget.taskModel;
  //   title.text = taskModel.title ?? "";
  //   moTa.text = taskModel.description ?? "";
  //   note.text = taskModel.note ?? "";
  //   date1 = DateFormat('dd-MM-yyyy')
  //       .format(DateTime.parse(taskModel.scheduledStartTime ?? ""));
  //   time1 = DateFormat('HH:mm')
  //       .format(DateTime.parse(taskModel.scheduledStartTime ?? ""));
  //   date2 = DateFormat('dd-MM-yyyy')
  //       .format(DateTime.parse(taskModel.scheduledEndTime ?? ""));
  //   time2 = DateFormat('HH:mm')
  //       .format(DateTime.parse(taskModel.scheduledEndTime ?? ""));
  //   taskModel.progress ??= 0;
  //}
  void _showPopup(BuildContext context) {
    int? idManager;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Manager'),
          content: DropdownSearch<UserProfileResponseModel>(
            popupProps: PopupPropsMultiSelection.menu(
              showSearchBox: false,
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
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
            asyncItems: (String? filter) => SolutionProvider.getListManager(),
            itemAsString: (UserProfileResponseModel u) =>
                (u.lastName! + " " + u.firstName!),
            selectedItem: selectedManager,
            onChanged: (value) {
              idManager = value?.id;
              print("$idManager test idManager");
              print(solution.id);
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () async {
                await SolutionProvider.submit_approval(solution.id, idManager);
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("$id aaaa");
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 254, 255, 255),
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
              title: const Text(
                "Solution details",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              actions: [
                Visibility(
                  visible: solution.createdById == id,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditSolutionScreen(
                              solution: solution,
                              callBack: (value) {
                                if (value != null) {
                                  setState(() {
                                    solution = value;
                                  });
                                }
                              },
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.edit,
                        size: 28,
                        color: Colors.white,
                      )),
                ),
                SizedBox(width: 15),
                Visibility(
                  visible: solution.createdById == id &&
                      solution.isApproved == false,
                  child: InkWell(
                      onTap: () {
                        _showPopup(context);
                      },
                      child: Icon(
                        Icons.upload_file,
                        size: 28,
                        color: Colors.white,
                      )),
                ),
                SizedBox(width: 15),
              ],
            ),
            body: Column(
              children: [
                TabBar(tabs: const [
                  Tab(
                    text: "Details",
                  ),
                  Tab(
                    text: "Feedback",
                  ),
                ]),
                Expanded(
                    child: TabBarView(children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          FieldTextWidget(
                            title: 'Title',
                            content: solution.title ?? "",
                          ),
                          FieldTextWidget(
                            title: 'Content',
                            content: solution.content ?? "",
                          ),
                          FieldTextWidget(
                            title: 'Keyword',
                            content: solution.keyword ?? "",
                          ),
                          FieldTextWidget(
                              title: 'Status',
                              content: getApproveStatus(solution.isApproved)),
                          // FieldTextWidget(
                          //     title: 'Visibility',
                          //     content: getPublicStatus(solution.isPublic),
                          // ),
                          // AppButton(
                          //   text: "Change Public",
                          //   onTap: (){
                          //      SolutionProvider.change_public(solution.id);
                          //   },
                          // ),
                          FieldTextWidget(
                              title: 'Attachment',
                              content: (solution.attachmentUrls != null &&
                                      solution.attachmentUrls != "")
                                  ? "File uploaded"
                                  : "",
                              widget: (solution.attachmentUrls != null &&
                                      solution.attachmentUrls != "")
                                  ? Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: InkWell(
                                        onTap: () async {
                                          downloadFile(
                                              context,
                                              List<String>.from(
                                                  solution.attachmentUrls ??
                                                      []));
                                        },
                                        child: Icon(
                                          Icons.download,
                                          size: 25,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink()),
                          FieldTextWidget(
                            title: 'Created Date',
                            content: (solution.createdAt != null)
                                ? DateFormat('HH:mm   dd-MM-yyyy')
                                    .format(DateTime.parse(solution.createdAt!))
                                : "",
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Created By",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FieldTextWidget(
                                        title: 'Name',
                                        content:
                                            "${solution.createdBy?.lastName ?? " "} ${solution.createdBy?.firstName ?? " "}",
                                      ),
                                      FieldTextWidget(
                                        title: 'Email',
                                        content:
                                            solution.createdBy?.email ?? "",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FieldTextWidget(
                            title: 'Phone',
                            content: solution.createdBy?.phoneNumber ?? "",
                            widget: (solution.createdBy?.phoneNumber != null &&
                                    solution.createdBy?.phoneNumber != "")
                                ? Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: InkWell(
                                      onTap: () async {
                                        final Uri launchUri = Uri(
                                          scheme: 'tel',
                                          path:
                                              solution.createdBy?.phoneNumber ??
                                                  "0987654321",
                                        );
                                        await launchUrl(launchUri);
                                      },
                                      child: Icon(
                                        Icons.phone,
                                        size: 25,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Commentslotion(
                    solution: solution,
                  ),
                ]))
              ],
            )));
  }
}

class FieldTextWidget extends StatelessWidget {
  final String title;
  final String content;
  final Widget? widget;
  const FieldTextWidget(
      {super.key, required this.title, required this.content, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 1,
        color: const Color(0xFFF0F0F0),
      ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF909090),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      content,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                  (widget != null) ? widget! : SizedBox.shrink(),
                ],
              )),
        ],
      ),
    );
  }
}
