import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/themes.dart';
import 'enums/connectivity_status.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final double opacity;

  NetworkSensitive({
    this.child,
    this.opacity = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.WiFi) {
      return child;
    }

    if (connectionStatus == ConnectivityStatus.Cellular) {
      return child;
    }

    return Stack(
      children: [
        child,
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black,
            ),
            child: Text(
              "Currently replying in a minute",
              style: AppTheme.heading
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w400),
            ),
          ),
        )
        // Center(
        //   child: Icon(
        //     FontAwesomeIcons.wifi,
        //     size: 50,
        //     color: customColor,
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // Text(
        //   'لا ‏يوجد ‏اتصال ‏بالإنترنت',
        //   style: AppTheme.subHeading.copyWith(
        //     color: Colors.blue,
        //     fontSize: 20,
        //   ),
        // ),
      ],
    );
  }
}
