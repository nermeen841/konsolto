import 'package:konsolto/domain/sub_category_repo_interf/sub_category_repo_interf.dart';
import 'package:konsolto/constants/Api_utils.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubcatRepo implements ISubcatRepo {
  NetWorkData netWorkData = NetWorkData();

  @override
  Future getSubcat(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    return netWorkData
        .getData(url: Utils.BASE_URL + '/categories/products/$id', headers: [
      {'Authorization': '  Bearer $token', 'lang': sendapiLang()}
    ]);
  }
}
