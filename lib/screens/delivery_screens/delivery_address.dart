import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/screens/delivery_screens/add_naw_address_data2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:konsolto/screens/delivery_screens/user_addressses.dart';

class DeliveryAddressScreen extends StatefulWidget {
  @override
  _DeliveryAddressScreenState createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text(
          LocalKeys.DELIVERY_ADDRESS.tr(),
          style: AppTheme.headingColorBlue,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            color: customColor,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.78,
            child: UserAddresses(),
          ),
          alignment_cont(context),
        ],
      ),
    );
  }


  alignment_cont(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: InkWell(
              child: Container(
                height: 40,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: customColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    LocalKeys.ADD_NEW_ADDRESS.tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddnewAddressData(
                              editAddress: false,
                            )));
              },
            )));
  }
}
