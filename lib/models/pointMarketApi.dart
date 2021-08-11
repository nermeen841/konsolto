import 'package:konsolto/http_services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PointMarketApi {
  static Future<dynamic> pointMarketdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');

    try {
      var response = await http.get(
        Uri.parse(
          Utils.POINTMARKET,
        ),
        headers: {
          'Authorization': '  Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      var jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        return jsonData['data']['redeemMethods'];
      }
    } catch (e) {
      print(
          "________________________________________________________ POINT MARKET :$e");
    }
  }
}
