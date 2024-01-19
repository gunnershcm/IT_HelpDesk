// ignore_for_file: prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dich_vu_it/app/widgets/WAColors.dart';
import 'package:dich_vu_it/app/widgets/WAWidgets.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/pick.date.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
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
import 'package:intl/intl.dart';

import '../../../../app/theme/colors.dart';

class EditSolutionScreen extends StatefulWidget {
  final TicketSolutionModel solution;
  final Function callBack;
  const EditSolutionScreen(
      {super.key, required this.callBack, required this.solution});

  @override
  State<EditSolutionScreen> createState() => _EditSolutionScreenState();
}

class _EditSolutionScreenState extends State<EditSolutionScreen> {
  TicketSolutionModel solutionModel = TicketSolutionModel();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController keyword = TextEditingController();
  TextEditingController internalComments = TextEditingController();
  CategoryResponseModel? selectedItemCategory;
  UserProfileResponseModel? selectedItemOwner;
  bool _deleteIconVisible = false;

  Map<bool, String> listStatus = {
    false: 'Private',
    true: 'Public',
  };

  bool? selectedStatus = false;

  var date1;
  var time1;
  var date2;
  var time2;

  final _bloc = TicketSolutionBloc();

  @override
  void initState() {
    super.initState();
    solutionModel = widget.solution;
    title.text = solutionModel.title ?? "";
    content.text = solutionModel.content ?? "";
    keyword.text = solutionModel.keyword ?? "";
    TicketProvider.getAllCategory().then((categories) {
      // Find the category with the name from solutionModel
      selectedItemCategory = categories.firstWhere(
        (category) =>
            category.name ==
            solutionModel
                .category?.name, // Handle the case when category is not found
      );

      // Set the state to trigger a rebuild
      setState(() {});
    });
    TicketProvider.getAllUsers().then((owners) {
      // Find the category with the name from solutionModel
      selectedItemOwner = owners.firstWhere(
        (owner) =>
            owner.lastName == solutionModel.owner?.lastName &&
            owner.firstName == solutionModel.owner?.firstName,
        // Handle the case when category is not found
      );

      // Set the state to trigger a rebuild
      setState(() {});
    });
    // date2 = DateFormat('dd-MM-yyyy')
    //     .format(DateTime.parse(solutionModel.expiredDate ?? ""));
    // time2 = DateFormat('HH:mm')
    //     .format(DateTime.parse(solutionModel.expiredDate ?? ""));
    date2 = solutionModel.expiredDate != null
        ? DateFormat('dd-MM-yyyy')
            .format(DateTime.parse(solutionModel.expiredDate!))
        : "";
    time2 = solutionModel.expiredDate != null
        ? DateFormat('HH:mm').format(DateTime.parse(solutionModel.expiredDate!))
        : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          "Update Solution",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocConsumer<TicketSolutionBloc, TicketSolutionState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is TicketSolutionLoading) {
            onLoading(context);
            return;
          } else if (state is EditSolutionSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            widget.callBack(solutionModel);
            showToast(
              context: context,
              msg: "Update solution successfully",
              color: MyColors.success,
              icon: const Icon(Icons.done),
            );
          } else if (state is TicketSolutionError) {
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
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Title",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                      "Content",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        maxLines: null,
                        controller: content,
                        decoration: waInputDecoration(hint: ''),
                      ),
                    ),
                    SizedBox(height: 20),
                    const Text(
                      "Category",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 225, 224, 224)),
                            borderRadius: BorderRadius.circular(12),
                            color: WAPrimaryColor.withOpacity(0.07)),
                        child: DropdownSearch<CategoryResponseModel>(
                          popupProps: PopupPropsMultiSelection.menu(
                              //showSearchBox: true,
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 225, 224, 224)),
                            borderRadius: BorderRadius.circular(12),
                            color: WAPrimaryColor.withOpacity(0.07)),
                        child: DropdownSearch<UserProfileResponseModel>(
                          popupProps: PopupPropsMultiSelection.menu(
                              //showSearchBox: true,
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
                            solutionModel.ownerId = value?.id;
                          },
                        )),
                    SizedBox(height: 20),
                    const Text(
                      "Keyword",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        maxLines: null,
                        controller: keyword,
                        decoration: waInputDecoration(hint: ''),
                      ),
                    ),
                    SizedBox(height: 20),
                    // const Text(
                    //   "Internal Comment",
                    //   style:
                    //       TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: TextFormField(
                    //     controller: internalComments,
                    //     decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //       contentPadding: EdgeInsets.all(10),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // const Text(
                    //   "Visibility",
                    //   style:
                    //       TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton2(
                    //       items: listStatus.entries
                    //           .map((item) => DropdownMenuItem<bool>(
                    //               value: item.key, child: Text(item.value)))
                    //           .toList(),
                    //       value: selectedStatus,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           selectedStatus = value as bool;
                    //           solutionModel.isPublic = selectedStatus;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // DatePickerBox1(
                    //     requestDayBefore: date2,
                    //     isTime: true,
                    //     label: Text(
                    //       'Review Date:',
                    //       style: TextStyle(
                    //           fontSize: 18, fontWeight: FontWeight.w500),
                    //     ),
                    //     dateDisplay: date1,
                    //     timeDisplay: time1,
                    //     selectedDateFunction: (day) {
                    //       if (day == null) {
                    //         solutionModel.reviewDate = null;
                    //       }
                    //     },
                    //     selectedTimeFunction: (time) {
                    //       if (time == null) {
                    //         solutionModel.reviewDate = null;
                    //       }
                    //     },
                    //     getFullTime: (time) {
                    //       if (time != "") {
                    //         solutionModel.reviewDate = time;
                    //       } else {
                    //         solutionModel.reviewDate = null;
                    //       }
                    //     }),
                    // SizedBox(height: 20),
                    // DatePickerBox1(
                    //   requestDayBefore: date2,
                    //   isTime: true,
                    //   label: Text(
                    //     'Expired Date:',
                    //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    //   ),
                    //   dateDisplay: date2,
                    //   timeDisplay: time2,
                    //   selectedDateFunction: (day) {
                    //     if (day == null) {
                    //       solutionModel.expiredDate = null;
                    //     }
                    //   },
                    //   selectedTimeFunction: (time) {
                    //     if (time == null) {
                    //       solutionModel.expiredDate = null;
                    //     }
                    //   },
                    //   getFullTime: (time) {
                    //     if (time != "") {
                    //       solutionModel.expiredDate = time;
                    //     } else {
                    //       solutionModel.expiredDate = null;
                    //     }
                    //   }),
                    const Text(
                      "Attachment",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                                            if (solutionModel.attachmentUrls !=
                                                null)
                                              for (int index = 0;
                                                  index <
                                                      solutionModel
                                                          .attachmentUrls!
                                                          .length;
                                                  index++)
                                                Stack(
                                                  children: [
                                                    Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl: solutionModel
                                                                .attachmentUrls![
                                                            index],
                                                        placeholder: (context,
                                                                url) =>
                                                            CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
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
                                                            solutionModel
                                                                .attachmentUrls!
                                                                .removeAt(
                                                                    index);
                                                          });
                                                          if (solutionModel
                                                              .attachmentUrls!
                                                              .isEmpty) {
                                                            setState(() {
                                                              _deleteIconVisible =
                                                                  false;
                                                            });
                                                          }
                                                        },
                                                        child: AnimatedOpacity(
                                                          opacity:
                                                              _deleteIconVisible
                                                                  ? 1.0
                                                                  : 0.0,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  300),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4),
                                                            color: Colors.red,
                                                            child: Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.white,
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
                                      if (solutionModel.attachmentUrls ==
                                              null ||
                                          solutionModel.attachmentUrls!.isEmpty)
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
                                                    solutionModel
                                                            .attachmentUrls =
                                                        fileNames;
                                                  });
                                                  print("a");
                                                  print(fileNames);
                                                  print(
                                                      "abcxyz ${solutionModel.attachmentUrls}");
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
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
                              solutionModel.title = title.text;
                              solutionModel.content = content.text;
                              solutionModel.categoryId =
                                  selectedItemCategory?.id;
                              _bloc.add(UpdateSolutionTicketEvent(
                                  solutionModel: solutionModel));
                            },
                            child: Center(
                              child: Text(
                                "Update",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
