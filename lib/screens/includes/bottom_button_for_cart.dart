import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/http_services/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BottomCartButton extends StatefulWidget {
  String id;
  String name;
  String url;
  var price;
  var oldprice;
  BottomCartButton({Key key, this.id, this.name, this.url, this.price, this.oldprice})
      : super(key: key);

  @override
  _BottomCartButtonState createState() => _BottomCartButtonState();
}

class _BottomCartButtonState extends State<BottomCartButton> {
  int counter = 1;

  bool _visible = true;

  bool _visible2 = false;

  _checkIfThereIsCart() async {
      SharedPreferences _sp = await SharedPreferences.getInstance();
    final token = _sp.getString('userToken');
    try {
      Map<String, String> requestHeaders = {'Authorization': '$token'};
      var response = await http.get(Uri.parse(Utils.MYCART_URL), headers: requestHeaders);
      var thisDetails = json.decode(response.body);
      for (var singleProduct in thisDetails['data']['cart']['details']) {
        if (singleProduct['product']['_id'] == widget.id) {
          setState(() {
            this._visible = false;
            this._visible2 = true;
            this.counter = singleProduct['quantity'];
          });
        }
      }
      // return thisDetails['data']['cart']['details'];
    } catch (e) {
      print('${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    this._checkIfThereIsCart();
    return Container(
      child: Text('$counter items added to cart'),
    );
  }


}
