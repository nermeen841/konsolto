import 'package:konsolto/domain/user_address/user_address_repo_interf.dart';
import 'package:konsolto/constants/Api_utils.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/models/user_data.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserAddressRepo implements IUserAddressRepo {
  NetWorkData netWorkData = NetWorkData();
  @override
  Future getUserAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    final id = preferences.getString('userDbId');
    return netWorkData
        .getData(url: Utils.BASE_URL + '/addresses/all/$id', headers: [
      {'Authorization': 'Bearer $token', 'lang': sendapiLang()}
    ]);
  }
}
