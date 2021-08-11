import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartModels {
  final String id;
  final String name;

  final String url;
  final int quantity;
  final double price;
  final bool isOffer;
  final String formQuantity;

  CartModels({
    this.id,
    this.name,
    this.url,
    this.quantity,
    this.price,
    this.isOffer,
    this.formQuantity,
  });
}

class CartDataProvider with ChangeNotifier {
  int totalQuantity = 0;
  double totalPrice = 0.0;
  bool isEmpaty = false;
  // ignore: missing_return
  Future<List<CartModels>> getMyCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    List<CartModels> cartList = [];
    try {
      Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
      var response =
          await http.get(Uri.parse(Utils.MYCART_URL), headers: requestHeaders);
      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (jsonData['data'] != null) {
          for (var prodect in jsonData['data']['cart']['details']) {
            CartModels cartModels = CartModels(
              price: double.parse(prodect['product']['price'].toString()),
              id: prodect['product']['_id'],
              isOffer: prodect['product']['isOffer'],
              formQuantity: prodect['product']['formQuantity'],
              quantity: prodect['quantity'],
              name: (apiLang() == 'en')
                  ? prodect['product']['nameArabic']
                  : prodect['product']['name'],
              url: prodect['product']['url'],
            );
            cartList.add(cartModels);
          }

          return cartList;
        } else {
          this.totalPrice = 0;
          this.totalQuantity = 0;
          return null;
        }
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  // ignore: missing_return
  Future<int> checkIfProductInCart(id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    int cont;
    try {
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer $token',
        'lang': sendapiLang(),
      };
      var response =
          await http.get(Uri.parse(Utils.MYCART_URL), headers: requestHeaders);
      var thisDetails = json.decode(response.body);
      for (var singleProduct in thisDetails['data']['cart']['details']) {
        if (singleProduct['product']['_id'] == id) {
          cont = singleProduct['quantity'];
          return cont;
        }
      }
    } catch (e) {
      print('$e');
    }
    notifyListeners();
  }

  // ignore: missing_return
  Future<int> addProductToCart(id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    int cont;
    try {
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer $token',
        'lang': sendapiLang()
      };
      var response = await http.get(Uri.parse(Utils.ADDTOMYCART_URL + '/' + id),
          headers: requestHeaders);
      var thisDetails = json.decode(response.body);
      for (var singleProduct in thisDetails['data']['cart']['details']) {
        print(singleProduct["product"]['price'].toString());
        if (singleProduct['product']['_id'] == id) {
          increment(
              price:
                  double.parse(singleProduct["product"]['price'].toString()));

          cont = singleProduct['quantity'];
          return cont;
        }
      }
    } catch (e) {
      print('$e');
    }
    notifyListeners();
  }

  increment({double price}) {
    this.totalQuantity++;
    this.totalPrice = this.totalPrice + price;
    notifyListeners();
  }

  dencrement({double price}) {
    if (this.totalQuantity > 0) {
      this.totalQuantity--;
      this.totalPrice = this.totalPrice - price;
    }

    notifyListeners();
  }

  clearData() {
    this.totalPrice = 0.0;
    this.totalQuantity = 0;
    notifyListeners();
  }

  isEmpatyFun(bool isEmpatty) {
    this.isEmpaty = isEmpatty;
    notifyListeners();
  }

  setData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');

    try {
      Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
      var response =
          await http.get(Uri.parse(Utils.MYCART_URL), headers: requestHeaders);
      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (jsonData['data'] != null) {
          int quantity = 0;
          double price = 0.0;
          for (var prodect in jsonData['data']['cart']['details']) {
            quantity += prodect['quantity'];
            price += double.parse(
                (prodect['quantity'] * prodect['product']['price']).toString());
          }
          this.totalPrice = price;
          this.totalQuantity = quantity;
        } else {
          this.totalPrice = 0;
          this.totalQuantity = 0;
        }
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  // ignore: missing_return
  Future<int> removeProductFromCart(id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('userToken');
    int cont;
    try {
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer $token',
        'lang': sendapiLang()
      };
      var response = await http.get(
          Uri.parse(Utils.REMOVEFROMMYCART_URL + '/' + id),
          headers: requestHeaders);
      var thisDetails = json.decode(response.body);

      for (var singleProduct in thisDetails['data']['cart']['details']) {
        if (singleProduct['product']['_id'] == id) {
          cont = singleProduct['quantity'];
          if (singleProduct['quantity'] > 0) {
            dencrement(
                price:
                    double.parse(singleProduct["product"]['price'].toString()));
          } else if (singleProduct['quantity'] == 0) {
            dencrement(
                price:
                    double.parse(singleProduct["product"]['price'].toString()));
          }
          return cont;
        }
      }
    } catch (e) {
      print('$e');
    }
    notifyListeners();
  }
}
