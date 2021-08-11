import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailproductApi {
  static Future<dynamic> productdatail(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');

    try {
      var response = await http.get(
        Uri.parse(
          Utils.BASE_URL + '/products/getone/$id',
        ),
        headers: {'Authorization': '  Bearer $token', 'lang': sendapiLang()},
      );
      // print(response);
      var jsonData = json.decode(response.body);
      return jsonData['data']['product'];
    } catch (e) {
      print("MAAAAAAAAAAAAAAAAAAAYYYYYYYYYYYYYYYYYYYYYYYYY:$e");
    }
  }
}
