import 'package:konsolto/data/user_profile/user_profile.dart';
import 'package:konsolto/domain/user_profile/user_profile_repo_intrf.dart';

class ProfiledataStore {
  UserprofileModel userprofileModel;
  IProfiledataRepo iProfiledataRepo;
  ProfiledataStore(this.iProfiledataRepo);

  Future<UserprofileModel> getProfiledata() async {
    userprofileModel =
        UserprofileModel.fromJson(await iProfiledataRepo.getProfiledata());
    if (userprofileModel.success == true) {
      print("------------------------------------- BRAVOOOOOO");
    }
    return userprofileModel;
  }
}
