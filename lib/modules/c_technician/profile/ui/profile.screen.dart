// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:io';

import 'package:dich_vu_it/app/constant/enum.dart';
import 'package:dich_vu_it/app/constant/value.dart';
import 'package:dich_vu_it/app/theme/colors.dart';
import 'package:dich_vu_it/app/theme/text.style.dart';
import 'package:dich_vu_it/app/widgets/WAColors.dart';
import 'package:dich_vu_it/app/widgets/WAWidgets.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
import 'package:dich_vu_it/models/response/user.profile.response.model.dart';
import 'package:dich_vu_it/modules/c_technician/profile/bloc/profile.bloc.dart';
import 'package:dich_vu_it/modules/c_technician/profile/ui/edit.profile.screen.dart';
import 'package:dich_vu_it/modules/login/ui/login.screen.dart';
import 'package:dich_vu_it/provider/firebase.auth.service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'change.pass.screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _bloc = ProfileBloc();

  UserProfileResponseModel userLogin = UserProfileResponseModel();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetProfileEvent());
  }

  String idLogin = "";
  Future<String> getIdLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('idUser');

    if (id != null) {
      print('User Role: $id');
      return idLogin = id;
    } else {
      print('Không tìm thấy thông tin người dùng trong SharedPreferences.');
      return idLogin = "not found id";
    }
  }

  @override
  Widget build(BuildContext context) {
    getIdLogin();
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is ProfileStateLoading) {
              onLoading(context);
              return;
            } else if (state is ProfileStateSuccess) {
              Navigator.pop(context);
              userLogin = state.userProfile;
            } else if (state is ChangeAvatarSuccess) {
              Navigator.pop(context);
              showToast(
                context: context,
                msg: "Update avatar was successfully",
                color: MyColors.success,
                icon: const Icon(Icons.done),
              );
              _bloc.add(GetProfileEvent());
            } else if (state is ProfileStateFailure) {
              showToast(
                context: context,
                msg: state.error,
                color: MyColors.error,
                icon: const Icon(Icons.warning),
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/wa_bg.jpg'),
                      fit: BoxFit.cover)),
              child: SingleChildScrollView(
                //scrollDirection: Axis.vertical,
                //physics: clampingscrollphysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    (userLogin.avatarUrl != null && userLogin.avatarUrl != "")
                        ? Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                image: NetworkImage(userLogin.avatarUrl!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: InkWell(
                              onTap: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();
                                if (result != null) {
                                  String fileName = result.files.first.name;
                                  String path = result.files.first.path ?? "";
                                  await FirebaseStorage.instance
                                      .ref('file/$fileName')
                                      .putFile(File(path));
                                  print("fileName: $fileName");
                                  _bloc.add(UpdateAvatarEvent(
                                      url:
                                          "https://firebasestorage.googleapis.com/v0/b/itsds-v1.appspot.com/o/file%2F$fileName?alt=media"));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: MyColors.black),
                                          // margin: const EdgeInsets.only(top: 170),
                                          child: const Icon(
                                            Icons.photo_camera,
                                            color: MyColors.white,
                                            size: 30,
                                          )),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: const DecorationImage(
                                image: AssetImage("assets/noavatar.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: InkWell(
                              onTap: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();
                                if (result != null) {
                                  String fileName = result.files.first.name;
                                  String path = result.files.first.path ?? "";
                                  await FirebaseStorage.instance
                                      .ref('file/$fileName')
                                      .putFile(File(path));
                                  _bloc.add(UpdateAvatarEvent(
                                      url:
                                          "https://firebasestorage.googleapis.com/v0/b/itsds-v1.appspot.com/o/file%2F$fileName?alt=media"));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: MyColors.black),
                                          // margin: const EdgeInsets.only(top: 170),
                                          child: const Icon(
                                            Icons.photo_camera,
                                            color: MyColors.white,
                                            size: 30,
                                          )),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${userLogin.firstName ?? ""} ${userLogin.lastName ?? ""}",
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.only(
                              top: 50, left: 16, right: 16, bottom: 16),
                          width: context.width(),
                          height: context.height() * .7,
                          decoration: boxDecorationWithShadow(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          //child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text('Personal Information $idLogin',
                              //     style: boldTextStyle(size: 18)),
                              Text('Personal Information',
                                  style: boldTextStyle(size: 18)),
                              16.height,
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.2),
                                        width: 0.5)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TitleDataUer(
                                        titile: "Username",
                                        content: userLogin.username ?? ""),
                                    16.height,
                                    TitleDataUer(
                                        titile: "Email",
                                        content: userLogin.email ?? ""),
                                    16.height,
                                    TitleDataUer(
                                        titile: "Phone",
                                        content: userLogin.phoneNumber ?? ""),
                                    // 16.height,
                                    // TitleDataUer(
                                    //     titile: "Date Of Birth",
                                    //     content: (userLogin.dateOfBirth !=
                                    //                 null &&
                                    //             userLogin.dateOfBirth != "")
                                    //         ? DateFormat('dd/MM/yyyy').format(
                                    //             DateTime.parse(
                                    //                 userLogin.dateOfBirth!))
                                    //         : ""),
                                    16.height,
                                    TitleDataUer(
                                        titile: "Gender",
                                        content:
                                            nameGender(userLogin.gender ?? -1)),
                                    16.height,
                                    TitleDataUer(
                                        titile: "Address",
                                        content: userLogin.address ?? ""),
                                    16.height,
                                    TitleDataUer(
                                        titile: "Role",
                                        content:
                                            nameRole(userLogin.role ?? -1)),
                                    16.height,
                                  ],
                                ),
                              ),
                              16.height,
                              AppButton(
                                color: WAPrimaryColor,
                                width: context.width(),
                                child: Text('Edit',
                                    style: boldTextStyle(
                                        color: Colors.white, size: 14)),
                                onTap: () async {
                                  await Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          EditProfileScrren(
                                        userdata: userLogin,
                                        callBack: (value) {},
                                      ),
                                    ),
                                  );
                                  _bloc.add(GetProfileEvent());
                                },
                              ).cornerRadiusWithClipRRect(30).paddingOnly(
                                  left: context.width() * 0.2,
                                  right: context.width() * 0.2),
                              16.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly, // Adjust the alignment as needed
                                children: [
                                  Expanded(
                                    child: AppButton(
                                      color: WAPrimaryColor,
                                      child: Text(
                                        'Change Password',
                                        style: boldTextStyle(
                                            color: Colors.white,
                                            size:
                                                14), // Adjust the  size as needed
                                      ),
                                      onTap: () {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                const ChangePasswordScrren(),
                                          ),
                                        );
                                      },
                                    ).cornerRadiusWithClipRRect(30).paddingOnly(
                                        left: context.width() * 0.01,
                                        right: context.width() * 0.01),
                                  ),
                                  Expanded(
                                    child: AppButton(
                                      color: WAPrimaryColor,
                                      child: Text('Logout',
                                          style: boldTextStyle(
                                              color: Colors.white, size: 14)),
                                      onTap: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.remove(myToken);
                                        AuthService().signOut();
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                const LoginScreen(),
                                          ),
                                        );
                                      },
                                    ).cornerRadiusWithClipRRect(30).paddingOnly(
                                        left: context.width() * 0.05,
                                        right: context.width() * 0.05),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //),
                        ),
                      ],
                    ).paddingTop(10),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class TitleDataUer extends StatelessWidget {
  final String titile;
  final String content;
  const TitleDataUer({super.key, required this.content, required this.titile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  titile,
                  style: MyTextStyle.title1,
                )),
            SizedBox(width: 50),
            Expanded(
                flex: 5,
                child: Text(
                  content,
                  style: MyTextStyle.content1,
                )),
          ],
        ),
        const SizedBox(height: 5),
        //const Divider()
      ],
    );
  }
}
