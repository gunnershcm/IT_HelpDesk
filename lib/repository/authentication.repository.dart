import 'package:dich_vu_it/models/response/user.profile.response.model.dart';

class AuthenticationRepository {
  AuthenticationRepository();
  UserProfileResponseModel user = UserProfileResponseModel();
  String? tokenFirebase;

  UserProfileResponseModel? get currentUser {
    return user;
  }

  UserProfileResponseModel updateUer(UserProfileResponseModel userProfileResponseModel) {
    user = userProfileResponseModel;
    return user;
  }

  String? gettTokenFirebase() {
    if (tokenFirebase != null) return tokenFirebase;
    return null;
  }

  void updateTokenFirebase(String? token) {
    tokenFirebase = token;
  }
}
