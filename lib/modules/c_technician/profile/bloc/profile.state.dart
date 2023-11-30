part of 'profile.bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileStateInitial extends ProfileState {}

class ProfileStateLoading extends ProfileState {}

class ProfileStateFailure extends ProfileState {
  final String error;

  const ProfileStateFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class ProfileStateSuccess extends ProfileState {
  final UserProfileResponseModel userProfile;

  const ProfileStateSuccess({required this.userProfile});

  @override
  List<Object> get props => [userProfile];
}

class ChangeAvatarSuccess extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {}

class ChangePasswordSuccess extends ProfileState {}
