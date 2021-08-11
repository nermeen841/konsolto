import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderDetailApi {
  static String error;
  static Future<dynamic> singleOrderdatail(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');

    try {
      var response = await http.get(
        Uri.parse(
          Utils.BASE_URL + '/orders/get/$id',
        ),
        headers: {'Authorization': '  Bearer $token', 'lang': sendapiLang()},
      );
      print(response);
      var jsonData = json.decode(response.body);
      print(jsonData);
      if (jsonData['success'] == true) {
        return jsonData['data']['order'];
      } else {
        error = jsonData['msg'].toString();
        print(
            "__________________________________________________________ SINGLE ORDER ERRORRRRRR : $error");
        return error;
      }
    } catch (e) {
      print(
          "__________________________________________________________ SINGLE ORDER ERRORRRRRR :$e");
    }
  }
}
