import 'package:konsolto/constants/Api_utils.dart';
import 'package:konsolto/domain/get_recommended/recommended_repo_interf.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:konsolto/constants/constans.dart';


class RecommendedRepo implements IRecommendedRepo {
  NetWorkData netWorkData = NetWorkData();

  @override
  Future getRecommended() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');

    return netWorkData.getData(
      url: Utils.BASE_URL+'/cart/getrecommended',
      headers: [{
        'Authorization' : 'Bearer $token',
        'lang': apiLang(),
        
      }]
    );
  }
}
