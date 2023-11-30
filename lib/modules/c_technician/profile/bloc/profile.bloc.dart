import 'package:bloc/bloc.dart';
import 'package:dich_vu_it/models/response/user.profile.response.model.dart';
import 'package:dich_vu_it/provider/session.provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile.event.dart';

part 'profile.state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateInitial()) {
    on<ProfileEvent>((event, emit) async {
      await profileBloc(emit, event);
    });
  }

  profileBloc(Emitter<ProfileState> emit, ProfileEvent event) async {
    emit(ProfileStateLoading());
    try {
      if (event is GetProfileEvent) {
        await Future.delayed(const Duration(seconds: 1));
        var user = await SessionProvider.getProfile();
        if (user != null) {
          emit(ProfileStateSuccess(userProfile: user));
        } else {
          emit(const ProfileStateFailure(error: "Error"));
        }
      } else if (event is UpdateAvatarEvent) {
        var check = await SessionProvider.updateAvatar(event.url);
        if (check == true) {
          emit(ChangeAvatarSuccess());
        } else {
          emit(const ProfileStateFailure(error: "Error"));
        }
      } else if (event is UpdateProfileEvent) {
        if (event.userProfileResponseModel.firstName == "") {
          emit(const ProfileStateFailure(error: "First name is not blank"));
        } else if (event.userProfileResponseModel.lastName == "") {
          emit(const ProfileStateFailure(error: "Last name is not blank"));
        } else if (event.userProfileResponseModel.email == "") {
          emit(const ProfileStateFailure(error: "Email is not blank"));
        } else {
          var check = await SessionProvider.updateProfile(event.userProfileResponseModel);
          if (check == true) {
            emit(UpdateProfileSuccess());
          } else {
            emit(const ProfileStateFailure(error: "Error"));
          }
        }
      } else if (event is ChangePassEvent) {
        var check = await SessionProvider.changePassword(currentPass: event.currentPass, newPass: event.newPass, confirmPass: event.confirmPass);
        if (check == true) {
          emit(ChangePasswordSuccess());
        } else {
          emit(const ProfileStateFailure(error: "Error"));
        }
      }
    } catch (e) {
      emit(const ProfileStateFailure(error: "Error"));
    }
  }
}
