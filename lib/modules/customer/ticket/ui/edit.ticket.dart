// ignore_for_file: prefer_const_constructors
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
import 'package:dich_vu_it/models/request/request.create.ticket.model.dart';
import 'package:dich_vu_it/models/response/service.response.model.dart';
import 'package:dich_vu_it/modules/customer/ticket/bloc/ticket.bloc.dart';
import 'package:dich_vu_it/provider/file.provider.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTicket extends StatefulWidget {
  final RequestCreateTicketModel request;
  final Function callBack;
  const EditTicket({super.key, required this.callBack, required this.request});

  @override
  State<EditTicket> createState() => _EditTicketState();
}

class _EditTicketState extends State<EditTicket> {
  RequestCreateTicketModel requestCreateTicketModel =
      RequestCreateTicketModel();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController attachmentUrl = TextEditingController();
  ServiceResponseModel? serviceModel;

  Map<int, String> listPriority = {
    0: 'Low',
    1: 'Medium',
    2: 'High',
    3: 'Critical',
  };
  int selectedPriority = 0;
  List<String> listType = ["Offline", "Online"];

  final _bloc = TicketBloc();

  @override
  void initState() {
    super.initState();
    requestCreateTicketModel = widget.request;
    title.text = requestCreateTicketModel.title ?? "";
    description.text = requestCreateTicketModel.description ?? "";
    selectedPriority = requestCreateTicketModel.priority ?? 0;
    //selectedItem = CategoryResponseModel(id: requestCreateTicketModel.categoryId, name: requestCreateTicketModel.categoryName);
    //attachmentUrl.text = requestCreateTicketModel.attachmentUrl ?? "";
    //serviceModel = ServiceResponseModel(id: requestCreateTicketModel.
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
          " Edit Ticket",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocConsumer<TicketBloc, TicketState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is TicketLoading) {
            onLoading(context);
            return;
          } else if (state is UpdateTicketSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            widget.callBack(requestCreateTicketModel);
            showToast(
              context: context,
              msg: "Update ticket successfully",
              color: Colors.green,
              icon: const Icon(Icons.done),
            );
          } else if (state is TicketError) {
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
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 229, 243, 254),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Title",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                const Text(
                  "Service",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownSearch<ServiceResponseModel>(
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
                          TicketProvider.getAllService(),
                      itemAsString: (ServiceResponseModel u) => u.description!,
                      selectedItem: serviceModel,
                      onChanged: (value) {
                        setState(() {
                          serviceModel = value!;
                        });
                      },
                    )),
                SizedBox(height: 20),
                const Text(
                  "Type",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      items: listType.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                              value), // Hiển thị giá trị là văn bản của mục
                        );
                      }).toList(),
                      value: requestCreateTicketModel.type,
                      onChanged: (value) {
                        setState(() {
                          requestCreateTicketModel.type = value as String;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                const Text(
                  "Priority",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      items: listPriority.entries
                          .map((item) => DropdownMenuItem<int>(
                              value: item.key, child: Text(item.value)))
                          .toList(),
                      value: selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          selectedPriority = value as int;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: description,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
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
                              (requestCreateTicketModel.attachmentUrl != null)
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
                                  requestCreateTicketModel.attachmentUrl =
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
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                          requestCreateTicketModel.title = title.text;
                          requestCreateTicketModel.description =
                              description.text;
                          //requestCreateTicketModel.categoryId = selectedItem?.id;
                          requestCreateTicketModel.priority = selectedPriority;
                          _bloc.add(UpdtaeTicketEvent(
                              request: requestCreateTicketModel));
                        },
                        child: Center(
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
