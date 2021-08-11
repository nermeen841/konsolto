import 'package:konsolto/http_services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SinglePointMarketApi {
  static String error;
  static Future<dynamic> singlepointMarketdata(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');

    try {
      var response = await http.get(
        Uri.parse(
          Utils.SINGLEPOINTMARKET + "$id",
        ),
        headers: {
          'Authorization': '  Bearer $token',
          // 'Content-Type': 'application/json',
        },
      );
      var jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        print(
            "_________________________________________________________SINGLE POINT MARKET: $jsonData");
        return jsonData['data'];
      } else {
        error = jsonData['msg'];
        print(
            "________________________________________________________ POINT MARKET :$error");
        return error;
      }
    } catch (e) {
      print(
          "________________________________________________________ POINT MARKET :$e");
    }
  }
}
