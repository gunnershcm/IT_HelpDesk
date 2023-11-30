// ignore_for_file: use_build_context_synchronously

import 'package:dich_vu_it/app/theme/colors.dart';
import 'package:dich_vu_it/app/theme/text.style.dart';
import 'package:dich_vu_it/app/widgets/border_textfield.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
import 'package:dich_vu_it/modules/c_technician/naivigator.technician.dart';
import 'package:dich_vu_it/modules/customer/naivigator.customer.dart';
import 'package:dich_vu_it/repository/authentication.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login.bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool checkLogin = false;
  final _bloc = LoginBloc();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String username = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    _bloc.add(CheckLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is LoginLoading) {
              onLoading(context);
              return;
            } else if (state is LoginSecondState) {
              Navigator.pop(context);
              if (state.userProfileResponseModel.role == 1) {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MultiRepositoryProvider(providers: [
                      RepositoryProvider.value(value: context.read<AuthenticationRepository>()),
                    ], child: const NavigatorMainCustomer()),
                  ),
                );
              } else if (state.userProfileResponseModel.role == 3) {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MultiRepositoryProvider(providers: [
                      RepositoryProvider.value(value: context.read<AuthenticationRepository>()),
                    ], child: const NavigatorMainTechnician()),
                  ),
                );
              } else {
                showToast(
                  context: context,
                  msg: "You do not have access",
                  color: const Color.fromARGB(255, 100, 99, 97),
                  icon: const Icon(Icons.warning),
                );
              }
            } else if (state is LoginFirstState) {
              Navigator.pop(context);
              checkLogin = true;
            } else if (state is LoginSuccessState) {
              Navigator.pop(context);
              context.read<AuthenticationRepository>().updateUer(state.userProfileResponseModel);
              if (state.userProfileResponseModel.role == 1) {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MultiRepositoryProvider(providers: [
                      RepositoryProvider.value(value: context.read<AuthenticationRepository>()),
                    ], child: const NavigatorMainCustomer()),
                  ),
                );
              } else if (state.userProfileResponseModel.role == 3) {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MultiRepositoryProvider(providers: [
                      RepositoryProvider.value(value: context.read<AuthenticationRepository>()),
                    ], child: const NavigatorMainTechnician()),
                  ),
                );
              } else {
                showToast(
                  context: context,
                  msg: "You do not have access",
                  color: const Color.fromARGB(255, 100, 99, 97),
                  icon: const Icon(Icons.warning),
                );
              }
            } else if (state is LoginFailure) {
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
            return checkLogin
                ? Container(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 100, bottom: 50),
                            height: 100,
                            child: Image.asset(
                              "assets/images/icon.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 15),
                          BorderTextField(
                            controller: usernameController,
                            title: "Username",
                            placeholder: 'Enter your username',
                            onChangeText: (value) {
                              username = value;
                            },
                          ),
                          const SizedBox(height: 15),
                          BorderTextField(
                            controller: passwordController,
                            title: "Password",
                            placeholder: 'Enter your password',
                            isPassword: true,
                            onChangeText: (value) {
                              password = value;
                            },
                          ),
                          const SizedBox(height: 15),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     InkWell(
                          //       onTap: () {},
                          //       child: Text(
                          //         "Forgot Password?",
                          //         style: AppTheme.green14n600,
                          //       ),
                          //     )
                          //   ],
                          // ),
                          Container(
                            margin: const EdgeInsets.only(top: 15),
                            height: 56,
                            decoration: BoxDecoration(color: MyColors.blue, borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      _bloc.add(StartLoginEvent(username: username, password: password));
                                    },
                                    child: Text(
                                      "Login",
                                      style: MyTextStyle.btnTextWhite,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 100, bottom: 50),
                          height: 100,
                          child: Image.asset(
                            "assets/images/icon.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
