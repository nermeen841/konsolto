import 'package:konsolto/constants/constans.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QRcodeApi {
  static Future<dynamic> qrCode(String code) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    final id = preferences.getString('userDbId');
    try {
      var response = await http.get(
        Uri.parse(
          "https://api.konsolto.com/qr/check/$id?code=$code",
        ),
        headers: {'Authorization': '  Bearer $token', 'lang': sendapiLang()},
      );
      var jsonData = json.decode(response.body);
      if (jsonData['success']) {
        print(
            "______________________________________________________ qrcode data: $jsonData");
        return jsonData['data'];
      }
    } catch (e) {
      print(
          "______________________________________________________qrcode error: $e");
    }
  }
}
