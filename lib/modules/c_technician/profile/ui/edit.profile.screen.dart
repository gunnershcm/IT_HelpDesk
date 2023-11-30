import 'package:dich_vu_it/app/theme/colors.dart';
import 'package:dich_vu_it/app/theme/text.style.dart';
import 'package:dich_vu_it/app/widgets/border_textfield.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/pick.date.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
import 'package:dich_vu_it/models/response/user.profile.response.model.dart';
import 'package:dich_vu_it/modules/c_technician/profile/bloc/profile.bloc.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EditProfileScrren extends StatefulWidget {
  final UserProfileResponseModel userdata;
  final Function callBack;
  const EditProfileScrren({super.key, required this.userdata, required this.callBack});

  @override
  State<EditProfileScrren> createState() => _EditProfileScrrenState();
}

class _EditProfileScrrenState extends State<EditProfileScrren> {
  UserProfileResponseModel userdata = UserProfileResponseModel();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? birth;

  int selectedGender = 0;

  Map<int, String> listGender = {
    0: 'Male',
    1: 'Female',
    2: 'Orther',
    3: 'Prefer Not To Say',
  };
  final _bloc = ProfileBloc();
  bool validateEmailCheck = true;

  String? validateEmail(String? text) {
    if (emailController.text.isEmpty) {
      setState(() {
        validateEmailCheck = false;
      });
      return "Not null";
    }
    if (!Validator.hexEmail.hasMatch(emailController.text)) {
      setState(() {
        validateEmailCheck = false;
      });
      return "Not right";
    }
    setState(() {
      validateEmailCheck = true;
    });
    return null;
  }

  bool validatePhoneCheck = true;
  bool validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.contains(RegExp(r'[^\d]'))) {
      return false;
    }
    // Kiểm tra xem chuỗi có đúng 10 số không
    if (phoneNumber.length != 10 || !phoneNumber.startsWith('0')) {
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    userdata = widget.userdata;
    firstNameController.text = userdata.firstName ?? "";
    lastNameController.text = userdata.lastName ?? "";
    emailController.text = userdata.email ?? "";
    phoneController.text = userdata.phoneNumber ?? "";
    addressController.text = userdata.address ?? "";
    if (userdata.dateOfBirth != null && userdata.dateOfBirth != "") {
      birth = DateFormat("dd-MM-yyyy").format(DateTime.parse(userdata.dateOfBirth!));
    }
    userdata.gender ??= 0;
    selectedGender = userdata.gender ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            widget.callBack(widget.userdata);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyColors.white,
          ),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: MyColors.blue,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is ProfileStateLoading) {
              onLoading(context);
              return;
            } else if (state is UpdateProfileSuccess) {
              Navigator.pop(context);
              Navigator.pop(context);
              showToast(
                context: context,
                msg: "Update was successfully",
                color: const Color.fromARGB(255, 32, 255, 76),
                icon: const Icon(Icons.done),
              );
            } else if (state is ProfileStateFailure) {
              showToast(
                context: context,
                msg: state.error,
                color: Colors.orange,
                icon: const Icon(Icons.warning),
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BorderTextField(
                      controller: firstNameController,
                      title: "First Name",
                      placeholder: 'Enter first name',
                      onChangeText: (value) {
                        userdata.firstName = value;
                      },
                    ),
                    const SizedBox(height: 15),
                    BorderTextField(
                      controller: lastNameController,
                      title: "Last Name",
                      placeholder: 'Enter last name',
                      onChangeText: (value) {
                        userdata.lastName = value;
                      },
                    ),
                    const SizedBox(height: 15),
                    BorderTextField(
                      validator: validateEmailCheck,
                      controller: emailController,
                      title: "Email",
                      placeholder: 'Enter Email',
                      onChangeText: (value) {
                        validateEmail(value);
                        userdata.email = value;
                      },
                    ),
                    const SizedBox(height: 15),
                    BorderTextField(
                      validator: validatePhoneCheck,
                      typeKey: TextInputType.phone,
                      controller: phoneController,
                      title: "Phone number",
                      placeholder: 'Enter phone number',
                      onChangeText: (value) {
                        setState(() {
                          validatePhoneCheck = validatePhoneNumber(value);
                        });
                        userdata.phoneNumber = value;
                      },
                    ),
                    const SizedBox(height: 15),
                    BorderTextField(
                      controller: TextEditingController(text: userdata.address ?? ""),
                      title: "Address",
                      placeholder: 'Enter address',
                      onChangeText: (value) {
                        userdata.address = value;
                      },
                    ),
                    const SizedBox(height: 15),
                    DatePickerBox1(
                        isTime: false,
                        label: Text(
                          "Date Of Birth",
                          style: MyTextStyle.titleTextfile,
                        ),
                        dateDisplay: birth,
                        selectedDateFunction: (day) {
                          birth = day;
                          if (birth != null) {
                            userdata.dateOfBirth = dateReverse(birth);
                          } else {
                            userdata.dateOfBirth = "";
                          }
                        }),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          "Gender",
                          style: MyTextStyle.titleTextfile,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            decoration: BoxDecoration(
                              color: MyColors.grey1,
                              border: Border.all(width: 1, color: MyColors.grey2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton2(
                              customButton: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${listGender[selectedGender]}",
                                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                                  ),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                              items: listGender.entries.map((item) => DropdownMenuItem<int>(value: item.key, child: Text(item.value))).toList(),
                              value: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value as int;
                                  userdata.gender = selectedGender;
                                });
                              },
                              underline: Container(),
                              dropdownStyleData: const DropdownStyleData(
                                maxHeight: 200,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          width: 170,
                          decoration: BoxDecoration(color: MyColors.blue, borderRadius: BorderRadius.circular(5)),
                          child: InkWell(
                            onTap: () {
                              if(validateEmailCheck==true && validatePhoneCheck ==true) {
                                _bloc.add(UpdateProfileEvent(userProfileResponseModel: userdata));
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Update",
                                  style: MyTextStyle.btnTextWhite,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class Validator {
  static RegExp hexEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static RegExp hexPass = RegExp(r'.');

  static get emailValidate => (String? text) {
        if (text == null || text.isEmpty) {
          return "Not null";
        }
        if (!hexEmail.hasMatch(text)) {
          return "Not right";
        }
        return null;
      };
}
