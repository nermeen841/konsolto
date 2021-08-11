import 'package:flutter/material.dart';
import 'package:konsolto/constants/themes.dart';
import 'package:konsolto/constants/constans.dart';
import 'package:konsolto/generated/local_keys.dart';
import 'package:konsolto/local_cart_data/state/add_remove_cart_button.dart';
import 'package:konsolto/screens/product_detail_screen/product_detail_screen.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:konsolto/domain/sub_category_repo_interf/sub_category_store.dart';
import 'package:easy_localization/easy_localization.dart';

class SubcatTabViewPage extends StatelessWidget {
  String id;
  SubcatTabViewPage({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WhenRebuilderOr<SubCatStore>(
        initState: (context, rm) => rm.setState((s) => s.getSubcat(id)),
        observe: () => RM.get<SubCatStore>(),
        builder: (context, model) => SubcatTabView(),
        onWaiting: () => Loading(),
        onError: (error) => IN.get<SubCatStore>().getSubcat(id) == null
            ? Text('$error')
            : SubcatTabView(),
      ),
    );
  }
}

class SubcatTabView extends StatefulWidget {
  @override
  _SubcatTabViewState createState() => _SubcatTabViewState();
}

class _SubcatTabViewState extends State<SubcatTabView> {
  final subCatModel = IN.get<SubCatStore>().subCatModel;
  @override
  Widget build(BuildContext context) {
    // print("UserData.appLang():${Userdata.appLang()}");
    return ListView.builder(
      itemCount: subCatModel.data.products.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            print(
                "_____________________________________________________________ PRODUCT STATUSE : ${subCatModel.data.products[index].sId}");
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductdetailScreen(
                    id: subCatModel.data.products[index].sId,
                  ),
                ));
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .65,
                              child: Text(
                                subCatModel.data.products[index].name ?? '',
                                style: AppTheme.headingColorBlue,
                              ),
                            ),
                            Text(
                              subCatModel.data.products[index].formQuantity ??
                                  '',
                              style: AppTheme.subHeading,
                            ),
                            spaceH(10),
                            Text(
                              (subCatModel.data.products[index].price == null)
                                  ? ''
                                  : subCatModel.data.products[index].price
                                          .toStringAsFixed(2) +
                                      ' ${LocalKeys.EGP.tr()}',
                              style: AppTheme.subHeadingColorBlue,
                            ),
                            spaceH(10),
                            CartData(
                              id: subCatModel.data.products[index].sId,
                              name: subCatModel.data.products[index].name,
                              price: subCatModel.data.products[index].price,
                              oldprice:
                                  subCatModel.data.products[index].monthlyPrice,
                              url: subCatModel.data.products[index].url,
                              width: 150.0,
                              width2: 70.0,
                              inCart: false,
                            ),
                          ],
                        ),
                        spaceW(20),
                        Expanded(
                          child: Container(
                            width: 50,
                            height: 80,
                            child: customCachedNetworkImage(
                              fit: BoxFit.contain,
                              context: context,
                              url: subCatModel.data.products[index].url,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
