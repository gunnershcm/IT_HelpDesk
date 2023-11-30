// ignore_for_file: prefer_const_constructors_in_immutables

part of 'login.bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

//Đăng nhập lần đầu
class LoginFirstState extends LoginState {}

//Đã từng đăng nhập phiên trước
class LoginSecondState extends LoginState {
  final UserProfileResponseModel userProfileResponseModel;
  LoginSecondState({required this.userProfileResponseModel});
  @override
  List<Object> get props => [userProfileResponseModel];
}

class LoginSuccessState extends LoginState {
  final UserProfileResponseModel userProfileResponseModel;
  LoginSuccessState({required this.userProfileResponseModel});
  @override
  List<Object> get props => [userProfileResponseModel];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
