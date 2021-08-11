import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserOrdersApi {
  static Future<List> userOrdersApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');

    try {
      var response = await http.get(
        Uri.parse(
          Utils.BASE_URL + '/orders/all/',
        ),
        headers: {
          'Authorization': '  Bearer $token',
          'lang': apiLang(),
        },
      );
      print(response);
      var jsonData = json.decode(response.body);
      print(jsonData);
      return jsonData['data']['orders'];
    } catch (e) {
      print(
          "________________________________________________________________ ALL ORDER DATA:$e");
    }
  }
}
