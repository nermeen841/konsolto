import 'package:konsolto/constants/constans.dart';

class SubCatModel {
  bool success;
  Data data;

  SubCatModel({this.success, this.data});

  SubCatModel.fromJson(Map<String, dynamic> json) {
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
  // List<Null> products;
  // List<Null> pictures;
  bool isApproved;
  var price;
  List<String> categories;
  bool hidden;
  bool isSeparated;
  bool order;
  bool removed;
  bool isLimited;
  String name;
  String nameArabic;
  String company;
  String dose;
  String doseArabic;
  String form;
  String formArabic;
  String formQuantity;
  int quantity;
  String groupArabic;
  String activeIngredients;
  String url;
  String groupSub;
  // List<Null> locations;
  String createdAt;
  String updatedAt;
  int iV;
  String slug;
  int views;
  bool isMonthly;
  var monthlyPrice;
  int reedemablePoints;
  // List<Null> tags;
  bool addToFacebook;
  bool fulfilledByKonsolto;
  String dynamicLink;
  // List<Null> alternatives;

  Products({
    this.sId,
    this.isOffer,
    // this.products,
    // this.pictures,
    this.isApproved,
    this.price,
    this.categories,
    this.hidden,
    this.isSeparated,
    this.order,
    this.removed,
    this.isLimited,
    this.name,
    this.nameArabic,
    this.company,
    this.dose,
    this.doseArabic,
    this.form,
    this.formArabic,
    this.formQuantity,
    this.quantity,
    this.groupArabic,
    this.activeIngredients,
    this.url,
    this.groupSub,
    // this.locations,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.slug,
    this.views,
    this.isMonthly,
    this.monthlyPrice,
    this.reedemablePoints,
    // this.tags,
    this.addToFacebook,
    this.fulfilledByKonsolto,
    this.dynamicLink,
    //  this.alternatives
  });

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isOffer = json['isOffer'];
    // if (json['products'] != null) {
    //   products = new List<Null>();
    //   json['products'].forEach((v) {
    //     products.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['pictures'] != null) {
    //   pictures = new List<Null>();
    //   json['pictures'].forEach((v) {
    //     pictures.add(new Null.fromJson(v));
    //   });
    // }
    isApproved = json['isApproved'];
    price = json['price'];
    categories = json['categories'].cast<String>();
    hidden = json['hidden'];
    isSeparated = json['isSeparated'];
    order = json['order'];
    removed = json['removed'];
    isLimited = json['isLimited'];
    name = (apiLang() == 'en') ? json['nameArabic'] : json['name'];
    nameArabic = json['nameArabic'];
    company = json['company'];
    dose = (apiLang() == 'en') ? json['doseArabic'] : json['dose'];
    doseArabic = json['doseArabic'];
    form = (apiLang() == 'en') ? json['formArabic'] : json['form'];
    formArabic = json['formArabic'];
    formQuantity = json['formQuantity'];
    quantity = json['quantity'];
    groupArabic = json['groupArabic'];
    activeIngredients = json['activeIngredients'];
    url = json['url'];
    groupSub = json['groupSub'];
    // if (json['locations'] != null) {
    //   locations = new List<Null>();
    //   json['locations'].forEach((v) {
    //     locations.add(new Null.fromJson(v));
    //   });
    // }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    slug = json['slug'];
    views = json['views'];
    isMonthly = json['isMonthly'];
    monthlyPrice = json['monthlyPrice'];
    reedemablePoints = json['reedemablePoints'];
    // if (json['tags'] != null) {
    //   tags = new List<Null>();
    //   json['tags'].forEach((v) {
    //     tags.add(new Null.fromJson(v));
    //   });
    // }
    addToFacebook = json['addToFacebook'];
    fulfilledByKonsolto = json['fulfilledByKonsolto'];
    dynamicLink = json['dynamicLink'];
    // if (json['alternatives'] != null) {
    //   alternatives = new List<Null>();
    //   json['alternatives'].forEach((v) {
    //     alternatives.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['isOffer'] = this.isOffer;
    // if (this.products != null) {
    //   data['products'] = this.products.map((v) => v.toJson()).toList();
    // }
    // if (this.pictures != null) {
    //   data['pictures'] = this.pictures.map((v) => v.toJson()).toList();
    // }
    data['isApproved'] = this.isApproved;
    data['price'] = this.price;
    data['categories'] = this.categories;
    data['hidden'] = this.hidden;
    data['isSeparated'] = this.isSeparated;
    data['order'] = this.order;
    data['removed'] = this.removed;
    data['isLimited'] = this.isLimited;
    data['name'] = this.name;
    data['nameArabic'] = this.nameArabic;
    data['company'] = this.company;
    data['dose'] = this.dose;
    data['doseArabic'] = this.doseArabic;
    data['form'] = this.form;
    data['formArabic'] = this.formArabic;
    data['formQuantity'] = this.formQuantity;
    data['quantity'] = this.quantity;
    data['groupArabic'] = this.groupArabic;
    data['activeIngredients'] = this.activeIngredients;
    data['url'] = this.url;
    data['groupSub'] = this.groupSub;
    // if (this.locations != null) {
    //   data['locations'] = this.locations.map((v) => v.toJson()).toList();
    // }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['slug'] = this.slug;
    data['views'] = this.views;
    data['isMonthly'] = this.isMonthly;
    data['monthlyPrice'] = this.monthlyPrice;
    data['reedemablePoints'] = this.reedemablePoints;
    // if (this.tags != null) {
    //   data['tags'] = this.tags.map((v) => v.toJson()).toList();
    // }
    data['addToFacebook'] = this.addToFacebook;
    data['fulfilledByKonsolto'] = this.fulfilledByKonsolto;
    data['dynamicLink'] = this.dynamicLink;
    // if (this.alternatives != null) {
    //   data['alternatives'] = this.alternatives.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
