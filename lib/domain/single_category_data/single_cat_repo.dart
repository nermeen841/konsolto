import 'package:konsolto/domain/single_category_data/single_cat_repo_inter.dart';
import 'package:konsolto/constants/Api_utils.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:konsolto/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:konsolto/constants/constans.dart';

class SinglecatRepo implements IRepoSingleCat {
  NetWorkData netWorkData = NetWorkData();

  @override
  Future getSingleCat(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');

    if (token != null) {
      return netWorkData
          .getData(url: Utils.BASE_URL + '/categories/getone/$id', headers: [
        {'Authorization': 'Bearer $token', 'lang': sendapiLang()}
      ]);
    }
  }
}
