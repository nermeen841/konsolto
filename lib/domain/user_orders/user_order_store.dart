import 'package:konsolto/data/user_orders/user_orders_model.dart';
import 'package:konsolto/domain/user_orders/user_orders_repo_interf.dart';

class UserOrdersStore {
  IUserordersRepo iUserordersRepo;
  UserOrdersStore(this.iUserordersRepo);
  UserorderModel userorderModel;

  Future<UserorderModel> getUserorders() async {
    userorderModel =
        UserorderModel.fromJson(await iUserordersRepo.getUserorders());

    return userorderModel;
  }
}
