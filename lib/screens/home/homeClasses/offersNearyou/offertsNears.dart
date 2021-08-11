import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/screens/home/homeClasses/offersNearyou/allOfersNearYou.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:konsolto/domain/pharmacy_product/pharmacy_product_repo.dart';
import 'package:easy_localization/easy_localization.dart';

class OffersNearYou extends StatefulWidget {
  List<dynamic> homeSections;
  int thisIndex;
  OffersNearYou(
      {Key key, @required this.homeSections, @required this.thisIndex})
      : super(key: key);
  @override
  _OffersNearYouState createState() => _OffersNearYouState();
}

class _OffersNearYouState extends State<OffersNearYou> {
  // final homeSectionModel = IN.get<HomeStore>().homeSectionModel;
  PharmacyproductRepo pharmacyproductRepo = PharmacyproductRepo();
  String _lat;
  String _log;
  bool hasLocation = false;

  _checkIfHasLocation() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    _lat = _sp.getString('late');
    _log = _sp.getString('long');
    if (_log != null && _lat != null) {
      setState(() {
        hasLocation = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    this._checkIfHasLocation();
    if (hasLocation == true) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocalKeys.HOME_OFFER.tr(),
                style: AppTheme.headingColorBlue.copyWith(
                  fontSize: 16,
                ),
              ),
              spaceH(10),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 0.8),
                  itemCount: widget
                      .homeSections[widget.thisIndex]['Pharmacies'].length,
                  semanticChildCount: 3,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: InkWell(
                        onTap: () {
                          pharmacyproductRepo.getPharmacyproduct(
                              widget.homeSections[widget.thisIndex]
                                  ['Pharmacies'][index]['_id']);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => AllOfersNearYouPage(
                                  id: widget.homeSections[widget.thisIndex]
                                      ['Pharmacies'][index]['_id'],
                                  name: widget.homeSections[widget.thisIndex]
                                      ['Pharmacies'][index]['name'],
                                  image: widget.homeSections[widget.thisIndex]
                                      ['Pharmacies'][index]['url']),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: customCachedNetworkImage(
                                url: widget.homeSections[widget.thisIndex]
                                    ['Pharmacies'][index]['url'],
                                fit: BoxFit.contain,
                                context: context),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]),
      );
    }
  }
}
