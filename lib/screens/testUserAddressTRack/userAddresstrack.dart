import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/screens/home/homeClasses/tapToSeeOffers.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  final Geolocator geolocator = Geolocator();
  // Position _currentPosition;
  String _currentAddress;

  @override
  void initState() {
    this._getCurrentLocation();
    super.initState();
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        TapToSeeOffers.currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          TapToSeeOffers.currentPosition.latitude,
          TapToSeeOffers.currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddress =
            "${place.street},${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return (TapToSeeOffers.currentPosition != null && _currentAddress != null)
        ? Text(
            _currentAddress,
            style: AppTheme.subHeadingColorBlue,
          )
        : Container();
  }
}
