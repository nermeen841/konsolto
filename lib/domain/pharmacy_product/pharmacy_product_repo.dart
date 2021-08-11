import 'package:konsolto/domain/pharmacy_product/pharmacy_product_repo_interf.dart';
import 'package:konsolto/constants/Api_utils.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:konsolto/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:konsolto/constants/constans.dart';

class PharmacyproductRepo implements IPharmacyproductRepo {
  NetWorkData netWorkData = NetWorkData();

  @override
  Future getPharmacyproduct(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');

    return netWorkData
        .getData(url: Utils.BASE_URL + '/pharmacy/products/$id', headers: [
      {'Authorization': 'Bearer $token', 'lang': sendapiLang()}
    ]);
  }
}
