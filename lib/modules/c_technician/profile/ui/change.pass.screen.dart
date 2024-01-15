import 'package:dich_vu_it/app/theme/colors.dart';
import 'package:dich_vu_it/app/theme/text.style.dart';
import 'package:dich_vu_it/app/widgets/border_textfield.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
import 'package:dich_vu_it/modules/c_technician/profile/bloc/profile.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScrren extends StatefulWidget {
  const ChangePasswordScrren({super.key});

  @override
  State<ChangePasswordScrren> createState() => _ChangePasswordScrrenState();
}

class _ChangePasswordScrrenState extends State<ChangePasswordScrren> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordNewController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final _bloc = ProfileBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyColors.white,
          ),
        ),
        title: const Text(
          "Change Password",
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
          } else if (state is ChangePasswordSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
            showToast(
              context: context,
              msg: "Update was successfully",
              color: MyColors.success,
              icon: const Icon(Icons.done),
            );
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
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BorderTextField(
                    controller: passwordController,
                    title: "Current password",
                    placeholder: 'Enter your current password',
                    isPassword: true,
                    onChangeText: (value) {},
                  ),
                  const SizedBox(height: 30),
                  BorderTextField(
                    controller: passwordNewController,
                    title: "New password",
                    placeholder: 'Enter your new password',
                    isPassword: true,
                    onChangeText: (value) {},
                  ),
                  const SizedBox(height: 30),
                  BorderTextField(
                    controller: confirmPassController,
                    title: "Confirm password",
                    placeholder: 'Enter your confirm password',
                    isPassword: true,
                    onChangeText: (value) {},
                  ),
                  const SizedBox(height: 45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        width: 170,
                        decoration: BoxDecoration(
                            color: MyColors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: InkWell(
                          onTap: () {
                            _bloc.add(ChangePassEvent(
                                currentPass: passwordController.text,
                                newPass: passwordNewController.text,
                                confirmPass: confirmPassController.text));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Submit",
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
        },
      ),
    );
  }
}
