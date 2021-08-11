import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/screens/CameraScreens/view_code_response.dart';
import 'package:konsolto/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../locator.dart';

class DynamicLinkService {
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleDynamicLinks(context) async {
    // 1. Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    // 2. handle link that has been retrieved
    _handleDeepLink(context, data);

    // 3. Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      // 3a. handle link that has been retrieved
      _handleDeepLink(context, dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  void _handleDeepLink(context, PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');

      // Check if we want to make a Code
      var isCode = deepLink.pathSegments.contains('qrcode');

      if (isCode) {
        // get the code of the Code
        var code = deepLink.queryParameters['code'];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('qr_code', code);
        if (code != null) {
          // if we have a Code navigate to the ViewCodeResponse and pass in the code as the arguments.
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => ViewCodeResponse(code: code),
            ),
            (routes) => false,
          );
        }
      }
    }
  }
}
