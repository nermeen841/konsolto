import 'package:konsolto/constants/Api_utils.dart';
import 'package:konsolto/domain/user_orders/user_orders_repo_interf.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:konsolto/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:konsolto/constants/constans.dart';

class UserordersRepo implements IUserordersRepo {
  NetWorkData netWorkData = NetWorkData();

  @override
  Future getUserorders() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    return netWorkData.getData(url: Utils.BASE_URL + '/orders/all/', headers: [
      {'Authorization': 'Bearer $token', 'lang': sendapiLang()}
    ]);
  }
}
