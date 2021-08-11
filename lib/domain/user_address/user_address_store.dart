import 'package:konsolto/data/user_address/user_address.dart';
import 'package:konsolto/domain/user_address/user_address_repo_interf.dart';

class UserAddressStore {
  IUserAddressRepo iUserAddressRepo;
  UserAddressStore(this.iUserAddressRepo);
  UserAddressModel userAddressModel;

  Future<UserAddressModel> getUserAddress() async {
    userAddressModel =
        UserAddressModel.fromJson(await iUserAddressRepo.getUserAddress());
    if (userAddressModel.success == true) {
      print("999999999999999999999999999999999999999999999999999999999");
    }
    return userAddressModel;
  }
}
