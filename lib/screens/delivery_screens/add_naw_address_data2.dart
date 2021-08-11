import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:konsolto/models/user_data.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/screens/delivery_screens/add-EditAddressForm.dart';
import 'package:konsolto/screens/delivery_screens/mapDataPovider.dart';
import 'package:konsolto/screens/home/homeClasses/tapToSeeOffers.dart';
import 'package:konsolto/sharedPreferences.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddnewAddressData extends StatefulWidget {
  final String floor;
  final String flat;
  final String build;
  final String phone;
  final String note;
  final String mobile;
  var lat;
  var long;
  bool editAddress;
  String addressId;

  AddnewAddressData(
      {Key key,
      @required this.editAddress,
      this.lat,
      this.long,
      this.addressId,
      this.floor,
      this.flat,
      this.build,
      this.phone,
      this.note,
      this.mobile})
      : super(key: key);
  @override
  _AddnewAddressDataState createState() => _AddnewAddressDataState();
}

class _AddnewAddressDataState extends State<AddnewAddressData> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  getInitialPosition() {
    print(
        "___________________________________________ edit lang: ${widget.long} ");
    print(
        "___________________________________________ edit late : ${widget.lat} ");
    if (widget.editAddress == true) {
      if (widget.lat == null || widget.long == null) {
        return LatLng(TapToSeeOffers.currentPosition.latitude,
            TapToSeeOffers.currentPosition.longitude);
      }
      // if (Provider.of<MapDataProvider>(context, listen: false).long != '') {
      //   return LatLng(
      //       double.parse(
      //           Provider.of<MapDataProvider>(context, listen: false).lat),
      //       double.parse(
      //           Provider.of<MapDataProvider>(context, listen: false).long));
      // }
      else {
        return LatLng(double.parse(widget.lat.toString()),
            double.parse(widget.long.toString()));
      }
    } else {
      if (Provider.of<MapDataProvider>(context, listen: false).long != '') {
        return LatLng(
            double.parse(
                Provider.of<MapDataProvider>(context, listen: false).lat),
            double.parse(
                Provider.of<MapDataProvider>(context, listen: false).long));
      }
      if (TapToSeeOffers.currentPosition.latitude != null ||
          TapToSeeOffers.currentPosition.longitude != null) {
        return LatLng(TapToSeeOffers.currentPosition.latitude,
            TapToSeeOffers.currentPosition.longitude);
      } else {
        return LatLng(31.1975844, 29.9598339);
      }
    }
  }

  _getLocation() async {
    Userdata.lang = await MySharedPreferences.getUserlong() ?? 'null';
    Userdata.let = await MySharedPreferences.getUserLat() ?? 'null';
    Userdata.asddres = await MySharedPreferences.getUserAddress() ?? 'null';
  }

  @override
  void initState() {
    this.getInitialPosition();
    this._getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: customColor,
        elevation: 0.0,
      ),
      body: ListView(
        primary: true,
        shrinkWrap: true,
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: PlacePicker(
              enableMapTypeButton: false,
              enableMyLocationButton: false,
              resizeToAvoidBottomInset: false,
              apiKey: "AIzaSyDzfCqXtmazGkcUXOleHdGsbMxnDoRY95w",
              useCurrentLocation: true,
              selectedPlaceWidgetBuilder:
                  (_, result, state, isSearchBarFocused) {
                if (isSearchBarFocused) {
                  return Container();
                } else {
                  if (state == SearchingState.Searching) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    Future.delayed(Duration.zero, () {
                      Provider.of<MapDataProvider>(context, listen: false)
                          .updataData(
                        address: result.formattedAddress.toString(),
                        lat: result.geometry.location.lat.toString(),
                        long: result.geometry.location.lng.toString(),
                      );
                    });

                    return Container();
                  }
                }
              },
              selectInitialPosition: true,
              initialPosition: getInitialPosition(),
            ),
          ),
          ListView(
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            children: [
              AddressCart(),
              AddEditAddressForm(
                editAddress: widget.editAddress,
                addressId: widget.addressId,
                flat: widget.flat,
                floor: widget.floor,
                phone: widget.mobile,
                build: widget.build,
                note: widget.note,
              )
            ],
          )
        ],
      ),
    );
  }
}

class AddressCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          Provider.of<MapDataProvider>(context).addres,
        ),
      ),
    );
  }
}
