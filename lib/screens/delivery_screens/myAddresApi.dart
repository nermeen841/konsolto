import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyAddressApi {
  static Future<List> newAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    final id = preferences.getString('userDbId');
    try {
      var response = await http.get(
        Uri.parse(
          Utils.BASE_URL + '/addresses/all/$id',
        ),
        headers: {
          'Authorization': '  Bearer $token',
          'lang': sendapiLang(),
        },
      );
      print(response);
      var jsonData = json.decode(response.body);
      print(jsonData);
      return jsonData['data']['addresses'];
    } catch (e) {
      print("MAAAAAAAAAAAAAAAAAAAYYYYYYYYYYYYYYYYYYYYYYYYY:$e");
    }
  }
}
