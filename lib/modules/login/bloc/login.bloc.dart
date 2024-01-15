// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dich_vu_it/app/constant/value.dart';
import 'package:dich_vu_it/models/response/user.profile.response.model.dart';
import 'package:dich_vu_it/provider/api.dart';
import 'package:dich_vu_it/provider/firebase.auth.service.dart';
import 'package:dich_vu_it/provider/session.provider.dart';
import 'package:dich_vu_it/repository/authentication.repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login.state.dart';
part 'login.event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    // event handler was added
    on<LoginEvent>((event, emit) async {
      await loginUser(emit, event);
    });
  }

  loginUser(Emitter<LoginState> emit, LoginEvent event) async {
    emit(LoginLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (event is CheckLoginEvent) {
        var userModel = await SessionProvider.getProfile();
        if (userModel != null) {
          var password = prefs.getString("password");
          await AuthService().signInWithEmailAndPassword(userModel.email ?? "", password ?? "");
          emit(LoginSecondState(userProfileResponseModel: userModel));
        } else {
          emit(LoginFirstState());
        }
      } else if (event is StartLoginEvent) {
        if (event.username == "" || event.password == "") {
          emit(LoginFailure(error: "Username or password cannot be blank"));
        } else {
          var user = await SessionProvider.login(email: event.username, password: event.password);
          if (user != null) {
            prefs.setString(myToken, user.accessToken ?? "");
            prefs.setString("password", event.password);

            var userLogin = await SessionProvider.getProfile();
          
            await AuthService().signInWithEmailAndPassword(user.email?? "", event.password);
            await SessionProvider.postToken();
            emit(LoginSuccessState(userProfileResponseModel: userLogin ?? UserProfileResponseModel()));
          } else {
            emit(LoginFailure(error: "Username or password is incorrect"));
          }
        }
      
      }
    } catch (e) {
      print("Loi: $e");
      emit(LoginFailure(error: "Username or password is incorrect"));
    }
  }
}
