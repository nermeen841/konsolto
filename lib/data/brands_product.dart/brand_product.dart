import 'package:konsolto/constants/constans.dart';

class BrandsProductModel {
  bool success;
  Data data;

  BrandsProductModel({this.success, this.data});

  BrandsProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Products> products;

  Data({this.products});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String sId;
  bool isOffer;
  //List<Null> pictures;
  bool isApproved;
  var price;
  bool hidden;
  bool isSeparated;
  bool order;
  bool removed;
  bool isLimited;
  String name;
  int maxQuantity;
  String product;
  String url;
  String description;
  String descriptionAr;
  String nameArabic;
  var oldPrice;
  String expireDate;
  String startDate;
  String createdAt;
  String updatedAt;
  int iV;
  //List<Null> products;
  String company;
  String dose;
  String doseArabic;
  String form;
  String formArabic;
  String formQuantity;
  int quantity;
  String groupArabic;
  String activeIngredients;
  String groupSub;
  // List<Null> locations;
  String slug;
  bool isMonthly;
  var monthlyPrice;
  int views;
  String dynamicLink;
  int reedemablePoints;
  bool addToFacebook;
  List<Null> tags;
  bool fulfilledByKonsolto;

  Products(
      {this.sId,
      this.isOffer,
      // this.pictures,
      this.isApproved,
      this.price,
      this.hidden,
      this.isSeparated,
      this.order,
      this.removed,
      this.isLimited,
      this.name,
      this.maxQuantity,
      this.product,
      this.url,
      this.description,
      this.descriptionAr,
      this.nameArabic,
      this.oldPrice,
      this.expireDate,
      this.startDate,
      this.createdAt,
      this.updatedAt,
      this.iV,
      // this.products,
      this.company,
      this.dose,
      this.doseArabic,
      this.form,
      this.formArabic,
      this.formQuantity,
      this.quantity,
      this.groupArabic,
      this.activeIngredients,
      this.groupSub,
      // this.locations,
      this.slug,
      this.isMonthly,
      this.monthlyPrice,
      this.views,
      this.dynamicLink,
      this.reedemablePoints,
      this.addToFacebook,
      this.tags,
      this.fulfilledByKonsolto});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isOffer = json['isOffer'];
    isApproved = json['isApproved'];
    price = json['price'];
    hidden = json['hidden'];
    isSeparated = json['isSeparated'];
    order = json['order'];
    removed = json['removed'];
    isLimited = json['isLimited'];
    name = (apiLang() == 'en') ? json['nameArabic'] : json['name'];
    maxQuantity = json['maxQuantity'];
    product = json['product'];
    url = json['url'];
    description =
        (apiLang() == 'en') ? json['descriptionAr'] : json['description'];
    descriptionAr = json['descriptionAr'];
    nameArabic = json['nameArabic'];
    oldPrice = json['oldPrice'];
    expireDate = json['expireDate'];
    startDate = json['startDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];

    company = json['company'];
    dose = (apiLang() == 'en') ? json['doseArabic'] : json['dose'];
    doseArabic = json['doseArabic'];
    form = (apiLang() == 'en') ? json['formArabic'] : json['form'];
    formArabic = json['formArabic'];
    formQuantity = json['formQuantity'];
    quantity = json['quantity'];
    groupArabic = json['groupArabic'];
    activeIngredients = json['activeIngredients'];
    groupSub = json['groupSub'];
    slug = json['slug'];
    isMonthly = json['isMonthly'];
    monthlyPrice = json['monthlyPrice'];
    views = json['views'];
    dynamicLink = json['dynamicLink'];
    reedemablePoints = json['reedemablePoints'];
    addToFacebook = json['addToFacebook'];

    fulfilledByKonsolto = json['fulfilledByKonsolto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['isOffer'] = this.isOffer;
    // if (this.pictures != null) {
    //   data['pictures'] = this.pictures.map((v) => v.toJson()).toList();
    // }
    data['isApproved'] = this.isApproved;
    data['price'] = this.price;
    data['hidden'] = this.hidden;
    data['isSeparated'] = this.isSeparated;
    data['order'] = this.order;
    data['removed'] = this.removed;
    data['isLimited'] = this.isLimited;
    data['name'] = this.name;
    data['maxQuantity'] = this.maxQuantity;
    data['product'] = this.product;
    data['url'] = this.url;
    data['description'] = this.description;
    data['descriptionAr'] = this.descriptionAr;
    data['nameArabic'] = this.nameArabic;
    data['oldPrice'] = this.oldPrice;
    data['expireDate'] = this.expireDate;
    data['startDate'] = this.startDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    // if (this.products != null) {
    //   data['products'] = this.products.map((v) => v.toJson()).toList();
    // }
    data['company'] = this.company;
    data['dose'] = this.dose;
    data['doseArabic'] = this.doseArabic;
    data['form'] = this.form;
    data['formArabic'] = this.formArabic;
    data['formQuantity'] = this.formQuantity;
    data['quantity'] = this.quantity;
    data['groupArabic'] = this.groupArabic;
    data['activeIngredients'] = this.activeIngredients;
    data['groupSub'] = this.groupSub;
    // if (this.locations != null) {
    //   data['locations'] = this.locations.map((v) => v.toJson()).toList();
    // }
    data['slug'] = this.slug;
    data['isMonthly'] = this.isMonthly;
    data['monthlyPrice'] = this.monthlyPrice;
    data['views'] = this.views;
    data['dynamicLink'] = this.dynamicLink;
    data['reedemablePoints'] = this.reedemablePoints;
    data['addToFacebook'] = this.addToFacebook;
    // if (this.tags != null) {
    //   data['tags'] = this.tags.map((v) => v.toJson()).toList();
    // }
    data['fulfilledByKonsolto'] = this.fulfilledByKonsolto;
    return data;
  }
}
