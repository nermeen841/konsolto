import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konsolto/connectivity_service.dart';
import 'package:konsolto/domain/brand_product/brand_product_repo.dart';
import 'package:konsolto/domain/brand_product/brand_product_store.dart';
import 'package:konsolto/domain/get_recommended/recommended_store.dart';
import 'package:konsolto/domain/get_recommended/recommnded_repo.dart';
import 'package:konsolto/domain/notification/notification_repo.dart';
import 'package:konsolto/domain/notification/notification_store.dart';
import 'package:konsolto/domain/pharmacy_product/pharmacy_product_repo.dart';
import 'package:konsolto/domain/pharmacy_product/pharmacy_product_store.dart';
import 'package:konsolto/domain/user_address/user_address_store.dart';
import 'package:konsolto/domain/user_orders/user_order_repo.dart';
import 'package:konsolto/domain/user_orders/user_order_store.dart';
import 'package:konsolto/domain/user_profile/user_profile_repo.dart';
import 'package:konsolto/domain/user_profile/user_profile_store.dart';
import 'package:konsolto/enums/connectivity_status.dart';
import 'package:konsolto/generated/coden_loader.dart';
import 'package:konsolto/screens/delivery_screens/mapDataPovider.dart';
import 'package:provider/provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'constants/constans.dart';
import 'constants/themes.dart';
import 'package:konsolto/screens/splashscreen.dart';
import 'package:konsolto/domain/sub_category_repo_interf/sub_category_repo.dart';
import 'package:konsolto/domain/sub_category_repo_interf/sub_category_store.dart';
import 'package:konsolto/domain/single_category_data/single_cat_repo.dart';
import 'package:konsolto/domain/single_category_data/single_cat_store.dart';
import 'domain/user_address/user_address_repo.dart';
import 'package:konsolto/screens/home/homeAddersProvider.dart';
import 'dart:async';
import 'models/cartModels.dart';
import 'locator.dart';

Future<void> main() async {
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MapDataProvider>(
          create: (_) => MapDataProvider(),
        ),
        ChangeNotifierProvider<HomeAddressProvider>(
          create: (_) => HomeAddressProvider(),
        ),
        ChangeNotifierProvider<CartProductProvider>(
          create: (_) => CartProductProvider(),
        ),
        ChangeNotifierProvider<CartItemCount>(
          create: (_) => CartItemCount(),
        ),
        ChangeNotifierProvider<CartDataProvider>(
          create: (_) => CartDataProvider(),
        ),
        StreamProvider<ConnectivityStatus>(
          create: (_) =>
              ConnectivityService().connectionStatusController.stream,
        ),
      ],
      child: EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations', // <-- change patch to your
        assetLoader: CodegenLoader(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Injector(
        inject: [
          Inject(() => SubCatStore(SubcatRepo())),
          Inject(() => SingleCatStore(SinglecatRepo())),
          Inject(() => BrandsProductsStore(BrandsProductRepo())),
          Inject(() => PharmacyproductStore(PharmacyproductRepo())),
          Inject(() => UserOrdersStore(UserordersRepo())),
          Inject(() => UserAddressStore(UserAddressRepo())),
          Inject(() => RecommendedStore(RecommendedRepo())),
          Inject(() => ProfiledataStore(ProfiledataRepo())),
          Inject(() => NotificationStore(NotificationRepo())),
        ],
        builder: (context) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: RM.navigate.navigatorKey,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: ThemeData(
                scaffoldBackgroundColor: Color(0xffff1f1f1),
                primaryIconTheme: IconThemeData(color: Colors.white),
                primaryColor: customColor,
                bottomAppBarColor: customColor,
                appBarTheme: AppBarTheme(
                  color: customColor,
                  elevation: 3,
                  iconTheme: IconThemeData(color: customColor),
                  actionsIconTheme: IconThemeData(color: customColor),
                  centerTitle: true,
                  textTheme: TextTheme(
                    headline6: AppTheme.headingColorBlue,
                  ),
                ),
                accentColor: customColor,
                iconTheme: IconThemeData(color: customColor),
              ),
              home: SplashScreen());
        });
  }
}
