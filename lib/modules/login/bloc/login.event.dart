part of 'login.bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class CheckLoginEvent extends LoginEvent {}

class StartLoginEvent extends LoginEvent {
  final String username;
  final String password;
    const StartLoginEvent({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}


class YourUserLoadedEvent extends LoginEvent {
  final UserProfileResponseModel userProfileResponseModel;

  const YourUserLoadedEvent({required this.userProfileResponseModel});

  @override
  List<Object> get props => [userProfileResponseModel];
}
