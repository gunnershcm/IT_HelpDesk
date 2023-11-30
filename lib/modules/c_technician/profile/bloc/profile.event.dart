part of 'profile.bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {}

class UpdateAvatarEvent extends ProfileEvent {
  final String url;
  const UpdateAvatarEvent({required this.url});
}

class UpdateProfileEvent extends ProfileEvent {
  final UserProfileResponseModel userProfileResponseModel;
  const UpdateProfileEvent({required this.userProfileResponseModel});
}

class ChangePassEvent extends ProfileEvent {
  final String currentPass;
  final String newPass;
  final String confirmPass;
  const ChangePassEvent(
      {required this.currentPass,
      required this.newPass,
      required this.confirmPass});
}
