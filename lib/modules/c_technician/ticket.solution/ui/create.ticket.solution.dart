// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/pick.date.dart';
import 'package:dich_vu_it/app/widgets/textfiel.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
import 'package:dich_vu_it/models/request/request.create.solution.model.dart';
import 'package:dich_vu_it/models/response/category.response.model.dart';
import 'package:dich_vu_it/models/response/ticket.solution.model.dart';

import 'package:dich_vu_it/models/response/user.profile.response.model.dart';

import 'package:dich_vu_it/modules/c_technician/ticket.solution/bloc/solution.bloc.dart';
import 'package:dich_vu_it/provider/file.provider.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CreateSolutionScreen extends StatefulWidget {
  final Function callBack;
  const CreateSolutionScreen({super.key, required this.callBack});

  @override
  State<CreateSolutionScreen> createState() => _CreateSolutionScreenState();
}

class _CreateSolutionScreenState extends State<CreateSolutionScreen> {
  var bloc = TicketSolutionBloc();
  RequestCreateSolutionModel requestSolutionModel =
      RequestCreateSolutionModel();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController keyword = TextEditingController();
  TextEditingController internalComments = TextEditingController();
  CategoryResponseModel? selectedItemCategory;
  UserProfileResponseModel? selectedItemOwner;
  //TicketSolutionModel? selectedItemApprove;

  Map<bool, String> listStatus = {
    false: 'Private',
    true: 'Public',
  };
  bool? selectedStatus = false;

  var date1;
  var time1;
  var date2;
  var time2;

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
          "Create Solution",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocConsumer<TicketSolutionBloc, TicketSolutionState>(
        bloc: bloc,
        listener: (context, state) async {
          if (state is TicketSolutionLoading) {
            onLoading(context);
            return;
          } else if (state is CareateSolutionSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            widget.callBack(true);
            showToast(
              context: context,
              msg: "Create a new solution successfully",
              color: Colors.green,
              icon: const Icon(Icons.done),
            );
          } else if (state is TicketSolutionError) {
            Navigator.pop(context);
            showToast(
              context: context,
              msg: state.error,
              color: Colors.orange,
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
                color: const Color.fromARGB(255, 229, 243, 254),
                borderRadius: BorderRadius.circular(10)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFielWidget(
                    title: 'Title',
                    controller: title,
                  ),
                  SizedBox(height: 20),
                  TextFielWidget(
                    title: 'Content',
                    controller: content,
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Category",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownSearch<CategoryResponseModel>(
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
                            TicketProvider.getAllCategory(),
                        itemAsString: (CategoryResponseModel u) => u.name!,
                        selectedItem: selectedItemCategory,
                        onChanged: (value) {
                          setState(() {
                            selectedItemCategory = value!;
                          });
                        },
                      )),
                  SizedBox(height: 20),
                  const Text(
                    "Owner Name",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownSearch<UserProfileResponseModel>(
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
                            TicketProvider.getAllUsers(),
                        itemAsString: (UserProfileResponseModel u) =>
                            (u.lastName! + " " + u.firstName!),
                        selectedItem: selectedItemOwner,
                        onChanged: (value) {
                          requestSolutionModel.ownerId = value?.id;
                        },
                      )),
                  SizedBox(height: 20),
                  TextFielWidget(
                    title: 'Keyword',
                    controller: keyword,
                  ),
                  SizedBox(height: 20),
                  TextFielWidget(
                    title: 'Internal Comments',
                    controller: internalComments,
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Visibility",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: listStatus.entries
                            .map((item) => DropdownMenuItem<bool>(
                                value: item.key, child: Text(item.value)))
                            .toList(),
                        value: selectedStatus,
                        onChanged: (value) {
                          setState(() {
                            selectedStatus = value as bool;
                            requestSolutionModel.isPublic = selectedStatus;
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
                        'Review Date:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      dateDisplay: date1,
                      timeDisplay: time1,
                      selectedDateFunction: (day) {
                        if (day == null) {
                          requestSolutionModel.reviewDate = null;
                        }
                      },
                      selectedTimeFunction: (time) {
                        if (time == null) {
                          requestSolutionModel.reviewDate = null;
                        }
                      },
                      getFullTime: (time) {
                        if (time != "") {
                          requestSolutionModel.reviewDate = time;
                        } else {
                          requestSolutionModel.reviewDate = null;
                        }
                      }),
                  SizedBox(height: 20),
                  DatePickerBox1(
                      requestDayBefore: date1,
                      isTime: true,
                      label: Text(
                        'Expired Date:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      dateDisplay: date2,
                      timeDisplay: time2,
                      selectedDateFunction: (day) {
                        if (day == null) {
                          requestSolutionModel.expiredDate = null;
                        }
                      },
                      selectedTimeFunction: (time) {
                        if (time == null) {
                          requestSolutionModel.expiredDate = null;
                        }
                      },
                      getFullTime: (time) {
                        if (time != "") {
                          requestSolutionModel.expiredDate = time;
                        } else {
                          requestSolutionModel.expiredDate = null;
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
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                (requestSolutionModel.attachmentUrl != null)
                                    ? "File uploaded"
                                    : "Upload file",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                                onTap: () async {
                                  var fileName = await handleUploadFile();
                                  setState(() {
                                    requestSolutionModel.attachmentUrl =
                                        fileName;
                                  });
                                },
                                child: Icon(
                                  Icons.upload,
                                  color: Colors.blue,
                                )),
                            SizedBox(width: 10),
                          ],
                        ),
                      ))
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
                            requestSolutionModel.title = title.text;
                            requestSolutionModel.content = content.text;
                            requestSolutionModel.categoryId =
                                selectedItemCategory?.id;
                            // requestSolutionModel.keyword = keyword.text;
                            // requestSolutionModel.internalComments = internalComments.text;
                            // requestSolutionModel.isPublic = selectedStatus;
                            // requestSolutionModel.ownerId =
                            //     selectedItemOwner?.id;
                            print(requestSolutionModel.toMap());
                            bloc.add(CreateSolutionEvent(
                                requestSolutionModel: requestSolutionModel));
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
