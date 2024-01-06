// ignore_for_file: use_build_context_synchronously

import 'package:dich_vu_it/app/theme/colors.dart';
import 'package:dich_vu_it/app/widgets/loading.dart';
import 'package:dich_vu_it/app/widgets/login_widget.dart';
import 'package:dich_vu_it/app/widgets/toast.dart';
import 'package:dich_vu_it/modules/c_technician/naivigator.technician.dart';
import 'package:dich_vu_it/modules/customer/naivigator.customer.dart';
import 'package:dich_vu_it/modules/login/ui/forget_pasword.dart';
import 'package:dich_vu_it/repository/authentication.repository.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
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
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();

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
                    builder: (BuildContext context) =>
                        MultiRepositoryProvider(providers: [
                      RepositoryProvider.value(
                          value: context.read<AuthenticationRepository>()),
                    ], child: const NavigatorMainCustomer()),
                  ),
                );
              } else if (state.userProfileResponseModel.role == 3) {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        MultiRepositoryProvider(providers: [
                      RepositoryProvider.value(
                          value: context.read<AuthenticationRepository>()),
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
              context
                  .read<AuthenticationRepository>()
                  .updateUer(state.userProfileResponseModel);

              if (state.userProfileResponseModel.role == 1) {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        MultiRepositoryProvider(providers: [
                      RepositoryProvider.value(
                          value: context.read<AuthenticationRepository>()),
                    ], child: const NavigatorMainCustomer()),
                  ),
                );
              } else if (state.userProfileResponseModel.role == 3) {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        MultiRepositoryProvider(providers: [
                      RepositoryProvider.value(
                          value: context.read<AuthenticationRepository>()),
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
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/bg.jpg'),
                            fit: BoxFit.cover)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 100),
                            height: 100,
                            child: Image.asset(
                              "assets/images/icon.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(16),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, bottom: 16),
                                  margin: const EdgeInsets.only(top: 55.0),
                                  decoration: boxDecorationWithShadow(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 30),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text("Log In",
                                            style: boldTextStyle(size: 26)),
                                      ),
                                      16.height,
                                      Text("Username",
                                          style: boldTextStyle(size: 14)),
                                      8.height,
                                      AppTextField(
                                        decoration: textInputDecoration(
                                            hint: 'Enter your username here',
                                            prefixIcon: Icons.person),
                                        textFieldType: TextFieldType.USERNAME,
                                        keyboardType: TextInputType.text,
                                        controller: usernameController,
                                        focus: usernameFocusNode,
                                        nextFocus: passWordFocusNode,
                                        onChanged: (value) {
                                          username = value;
                                        },
                                      ),
                                      16.height,
                                      Text("Password",
                                          style: boldTextStyle(size: 14)),
                                      8.height,
                                      AppTextField(
                                        decoration: textInputDecoration(
                                            hint: 'Enter your password here',
                                            prefixIcon: Icons.lock_outline),
                                        suffixIconColor: MyColors.blue,
                                        textFieldType: TextFieldType.PASSWORD,
                                        isPassword: true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        controller: passwordController,
                                        focus: passWordFocusNode,
                                        onChanged: (value) {
                                          password = value;
                                        },
                                      ),
                                      16.height,

                                      GestureDetector(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text("Forgot password?",
                                              style: primaryTextStyle()),                                      
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                   ForgetScreen()),
                                          );
                                        },
                                      ),
                                      30.height,
                                      AppButton(
                                              text: "Log In",
                                              color: MyColors.blue,
                                              textColor: Colors.white,
                                              shapeBorder:
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                              width: context.width(),
                                              onTap: () {
                                                _bloc.add(StartLoginEvent(
                                                    username: username,
                                                    password: password));
                                              })
                                          .paddingOnly(
                                              left: context.width() * 0.1,
                                              right: context.width() * 0.1),
                                      30.height,
                                    ],
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
