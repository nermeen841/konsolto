import 'package:konsolto/constants/Api_utils.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:konsolto/constants/constans.dart';
import 'brand_product_repo_interf.dart';

class BrandsProductRepo implements IBrandsproductRepo {
//5f68e7889cbcb10308932a46
  NetWorkData netWorkData = NetWorkData();
  @override
  Future getProductsbrand(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');

    return await netWorkData
        .getData(url: Utils.BASE_URL + '/brands/products/$id', headers: [
      {'Authorization': 'Bearer $token', 'lang': sendapiLang()}
    ]);
  }
}
