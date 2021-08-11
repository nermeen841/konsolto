import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:konsolto/http_services/utils.dart';
import 'package:konsolto/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:konsolto/constants/constans.dart';

class Product {
  final String sId;
  final String name;
  final String price;
  final int oldPrice;
  final String url;
  final String formQuantity;
  final String dose;
  final String doseArabic;
  final String usesArabic;
  final String groupArabic;
  final String slug;
  final String aname;
  final String isLimited;
  final String activeIngredients;
  var alternatives;
  var offers;

  Product({
    this.sId,
    this.name,
    this.price,
    this.oldPrice,
    this.url,
    this.formQuantity,
    this.dose,
    this.doseArabic,
    this.usesArabic,
    this.groupArabic,
    this.slug,
    this.aname,
    this.isLimited,
    this.activeIngredients,
    this.alternatives,
    this.offers,
  });
}

class HomeSearchApi {
  static Future<List<Product>> homeSearch(String name) async {
    List<Product> listOfProduct = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    try {
      var response = await http.get(
        Uri.parse(
          Utils.BASE_URL + '/products/search?search=$name',
        ),
        headers: {
          'Authorization': '  Bearer $token',
          'lang': Userdata.apiLang,
        },
      );
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var prod in jsonData['data']['products']) {
          Product product = Product(
            sId: prod['_id'],
            name: (apiLang() == 'en') ? prod['aname'] : prod['name'],
            price: prod['price'],
            oldPrice: prod['oldPrice'],
            url: prod['url'],
            formQuantity: prod['formQuantity'],
            dose: (apiLang() == 'en') ? prod['doseArabic'] : prod['dose'],
            doseArabic: prod['doseArabic'],
            groupArabic: prod['groupArabic'],
            usesArabic: prod['usesArabic'],
            slug: prod['slug'],
            aname: prod['aname'],
            isLimited: prod['isLimited'],
            activeIngredients: prod['activeIngredients'],
            alternatives: prod['alternatives'],
            offers: prod['offers'],
          );

          listOfProduct.add(product);
        }
      }
    } catch (e) {
      print(e);
    }
    return listOfProduct;
  }
}
