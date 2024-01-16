// ignore_for_file: prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dich_vu_it/app/widgets/WAColors.dart';
import 'package:dich_vu_it/app/widgets/WAWidgets.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
import 'package:dich_vu_it/models/request/request.create.ticket.model.dart';
import 'package:dich_vu_it/models/response/service.response.model.dart';
import 'package:dich_vu_it/modules/customer/ticket/bloc/ticket.bloc.dart';
import 'package:dich_vu_it/provider/file.provider.dart';
import 'package:dich_vu_it/provider/location.provider.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/colors.dart';

class CreateTickket extends StatefulWidget {
  //final Function callBack;
  const CreateTickket({super.key});

  @override
  State<CreateTickket> createState() => _CreateTickketState();
}

class _CreateTickketState extends State<CreateTickket> {
  RequestCreateTicketModel requestCreateTicketModel =
      RequestCreateTicketModel();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController attachmentUrl = TextEditingController();
  TextEditingController street = TextEditingController();
  //CategoryResponseModel? selectedItem;
  ServiceResponseModel? serviceModel;

  Map<int, String> listPriority = {
    0: 'Low',
    1: 'Medium',
    2: 'High',
    3: 'Critical',
  };

  List<String> listType = ["Offline", "Online"];
  String? selectedType = "";

  bool _deleteIconVisible = false;
  int selectedPriority = 0;
  List<Map<String, dynamic>> cities = [];
  List<Map<String, dynamic>> districts = [];
  List<Map<String, dynamic>> wards = [];
  int? selectedCity;
  int? selectedDistrict;
  int? selectedWard;

  final _bloc = TicketBloc();

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    List<Map<String, dynamic>> fetchedCities =
        await LocationProvider.fetchCities();
    setState(() {
      cities = fetchedCities; // Cập nhật dữ liệu thành phố trong CreateTicket
    });
  }

  Future<void> _loadDistricts(dynamic cityCode) async {
    List<Map<String, dynamic>> fetchedDistrictes =
        await LocationProvider.fetchDistricts(cityCode);
    setState(() {
      districts =
          fetchedDistrictes; // Cập nhật dữ liệu thành phố trong CreateTicket
    });
  }

  Future<void> _loadWards(dynamic districtCode) async {
    List<Map<String, dynamic>> fetchedWards =
        await LocationProvider.fetchWards(districtCode);
    setState(() {
      wards = fetchedWards; // Cập nhật dữ liệu thành phố trong CreateTicket
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Row(),
        title: Center(
          child: Text(
            "Create Ticket",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: BlocConsumer<TicketBloc, TicketState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is TicketLoading) {
            //onLoading(context);
            return;
          } else if (state is CareateTicketSuccessState) {
            //Navigator.pop(context);
            // Navigator.pop(context);
            //widget.callBack(true);
            //onLoading(context);
            showToast(
              context: context,
              msg: "Create a new ticket successfully",
              color: MyColors.success,
              icon: const Icon(Icons.done),
            );
          } else if (state is TicketError) {
            //Navigator.pop(context);
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
                      // decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        maxLines: null,
                        controller: title,
                        decoration: waInputDecoration(hint: ''),
                      ),
                    ),
                    SizedBox(height: 10),
                    const Text(
                      "Service",
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
                        child: DropdownSearch<ServiceResponseModel>(
                          popupProps: PopupPropsMultiSelection.menu(
                            showSearchBox: true,
                          ),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration:
                                // waInputDecoration(hint: ''),
                                InputDecoration(
                              constraints: const BoxConstraints.tightFor(
                                width: 300,
                                height: 50,
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
                              hintMaxLines: null,
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
                              TicketProvider.getUserActiveService(),
                          itemAsString: (ServiceResponseModel u) =>
                              u.description!,
                          selectedItem: serviceModel,
                          onChanged: (value) {
                            setState(() {
                              serviceModel = value!;
                            });
                          },
                        )),
                    // SizedBox(height: 20),
                    // const Text(
                    //   "Type",
                    //   style:
                    //       TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   // decoration: BoxDecoration(
                    //   //     color: Colors.white,
                    //   //     borderRadius: BorderRadius.circular(10)),
                    //    decoration: BoxDecoration(
                    //           border: Border.all(
                    //               color: Color.fromARGB(255, 225, 224, 224)),
                    //           borderRadius: BorderRadius.circular(12),
                    //           color: WAPrimaryColor.withOpacity(0.07)),
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton2(
                    //       items: listType.map((String value) {
                    //         return DropdownMenuItem<String>(
                    //           value: value,
                    //           child: Text(
                    //               value), // Hiển thị giá trị là văn bản của mục
                    //         );
                    //       }).toList(),
                    //       //value: requestCreateTicketModel.type,
                    //       onChanged: (value) {
                    //         // setState(() {
                    //         //   requestCreateTicketModel.type = value as String;
                    //         // });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    // const Text(
                    //   "Priority",
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
                    //       items: listPriority.entries
                    //           .map((item) => DropdownMenuItem<int>(
                    //               value: item.key, child: Text(item.value)))
                    //           .toList(),
                    //       value: selectedPriority,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           selectedPriority = value as int;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    const Text(
                      "Description",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        maxLines: null,
                        controller: description,
                        decoration: waInputDecoration(hint: ''),
                      ),
                    ),
                    // SizedBox(height: 20),
                    // const Text(
                    //   "Tỉnh/Thành",
                    //   style:
                    //       TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton<int>(
                    //       value: selectedCity,
                    //       hint: Text('Chọn tỉnh/thành'),
                    //       onChanged: (int? newValue) async {
                    //         setState(() {
                    //           selectedCity = newValue;
                    //           selectedDistrict = null;
                    //           selectedWard = null;
                    //           _loadDistricts(newValue!);
                    //           cities;
                    //         });
                    //         await LocationProvider.fetchDistricts(newValue!);
                    //       },
                    //       items: cities.map((city) {
                    //         return DropdownMenuItem<int>(
                    //           value: city['code'],
                    //           child: Text(city['name']),
                    //         );
                    //       }).toList(),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // const Text(
                    //   "Quận/Huyện",
                    //   style:
                    //       TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton<int>(
                    //       value: selectedDistrict,
                    //       hint: Text('Chọn quận/huyện'),
                    //       onChanged: (int? newValue) async {
                    //         setState(() {
                    //           selectedDistrict = newValue;
                    //           selectedWard = null;
                    //           _loadWards(newValue!);
                    //           districts;
                    //         });
                    //         await LocationProvider.fetchWards(newValue!);
                    //       },
                    //       items: districts.map((district) {
                    //         return DropdownMenuItem<int>(
                    //           value: district['code'],
                    //           child: Text(district['name']),
                    //         );
                    //       }).toList(),
                    //       disabledHint: Text('Chọn quận/huyện'),
                    //       onTap: () {
                    //         if (selectedCity == null) {
                    //           ScaffoldMessenger.of(context).showSnackBar(
                    //             SnackBar(
                    //               content:
                    //                   Text('Vui lòng chọn thành phố trước'),
                    //             ),
                    //           );
                    //         }
                    //       },
                    //       isExpanded: true,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // const Text(
                    //   "Phường/Xã",
                    //   style:
                    //       TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton<int>(
                    //       value: selectedWard,
                    //       hint: Text('Chọn phường/xã'),
                    //       onChanged: (int? newValue) {
                    //         setState(() {
                    //           selectedWard = newValue;
                    //           wards;
                    //         });
                    //       },
                    //       items: wards.map((ward) {
                    //         return DropdownMenuItem<int>(
                    //           value: ward['code'],
                    //           child: Text(ward['name']),
                    //         );
                    //       }).toList(),
                    //       disabledHint: Text('Chọn phường/xã'),
                    //       onTap: () {
                    //         if (selectedDistrict == null) {
                    //           ScaffoldMessenger.of(context).showSnackBar(
                    //             SnackBar(
                    //               content: Text('Vui lòng chọn tỉnh trước'),
                    //             ),
                    //           );
                    //         }
                    //       },
                    //       isExpanded: true,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // const Text(
                    //   "Số nhà",
                    //   style:
                    //       TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: TextFormField(
                    //     controller: street,
                    //     decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //       contentPadding: EdgeInsets.all(10),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 30),
                    const Text(
                      "Attachment",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Row(
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
                                      if (requestCreateTicketModel
                                              .attachmentUrls !=
                                          null)
                                        for (int index = 0;
                                            index <
                                                requestCreateTicketModel
                                                    .attachmentUrls!.length;
                                            index++)
                                          Stack(
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      requestCreateTicketModel
                                                              .attachmentUrls![
                                                          index],
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
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
                                                      requestCreateTicketModel
                                                          .attachmentUrls!
                                                          .removeAt(index);
                                                    });
                                                  },
                                                  child: AnimatedOpacity(
                                                    opacity: _deleteIconVisible
                                                        ? 1.0
                                                        : 0.0,
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      color: Colors.red,
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.white,
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
                                if (requestCreateTicketModel.attachmentUrls ==
                                    null)
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
                                              requestCreateTicketModel
                                                  .attachmentUrls = fileNames;
                                            });
                                            print("a");
                                            print(fileNames);
                                            print(
                                                "abcxyz ${requestCreateTicketModel.attachmentUrls}");
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

                    SizedBox(height: 40),
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
                        SizedBox(width: 30),
                        Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
                          child: InkWell(
                            onTap: () async {
                              requestCreateTicketModel.title = title.text;
                              requestCreateTicketModel.description =
                                  description.text;
                              requestCreateTicketModel.serviceId =
                                  serviceModel?.id;
                              // requestCreateTicketModel.priority =
                              //     selectedPriority;
                              // requestCreateTicketModel.street = street.text;
                              //requestCreateTicketModel.type = selectedType;
                              // requestCreateTicketModel.city = selectedCity;
                              // requestCreateTicketModel.district =
                              //     selectedDistrict;
                              // requestCreateTicketModel.ward = selectedWard;
                              //requestCreateTicketModel.attachmentUrl = attachmentUrl;
                              //requestCreateTicketModel.attachmentUrl = ;
                              print(
                                  "call api ${requestCreateTicketModel.attachmentUrls}");
                              _bloc.add(CreateTicketEvent(
                                  request: requestCreateTicketModel));
                            },
                            child: Center(
                              child: Text(
                                "Create",
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
