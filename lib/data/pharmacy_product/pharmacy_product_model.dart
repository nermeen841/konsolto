import 'package:konsolto/constants/constans.dart';

class PharmacyProductModel {
  bool success;
  Data data;

  PharmacyProductModel({this.success, this.data});

  PharmacyProductModel.fromJson(Map<String, dynamic> json) {
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
  // List<Null> pictures;
  bool isApproved;
  var price;
  bool hidden;
  bool isSeparated;
  bool order;
  bool removed;
  bool isLimited;
  String name;
  int maxQuantity;
  String description;
  String descriptionAr;
  String nameArabic;
  var oldPrice;
  String expireDate;
  String startDate;
  String createdAt;
  String updatedAt;
  int iV;
  int quantity;

  Products(
      {this.sId,
      this.isOffer,
      //this.pictures,
      this.isApproved,
      this.price,
      this.hidden,
      this.isSeparated,
      this.order,
      this.removed,
      this.isLimited,
      this.name,
      this.maxQuantity,
      this.description,
      this.descriptionAr,
      this.nameArabic,
      this.oldPrice,
      this.expireDate,
      this.startDate,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isOffer = json['isOffer'];
    // if (json['pictures'] != null) {
    //   pictures = new List<Null>();
    //   json['pictures'].forEach((v) {
    //     pictures.add(new Null.fromJson(v));
    //   });
    // }
    isApproved = json['isApproved'];
    price = json['price'];
    hidden = json['hidden'];
    isSeparated = json['isSeparated'];
    order = json['order'];
    removed = json['removed'];
    isLimited = json['isLimited'];
    name = (apiLang() == 'en') ? json['nameArabic'] : json['name'];
    maxQuantity = json['maxQuantity'];
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
    quantity = json['quantity'];
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
    data['description'] = this.description;
    data['descriptionAr'] = this.descriptionAr;
    data['nameArabic'] = this.nameArabic;
    data['oldPrice'] = this.oldPrice;
    data['expireDate'] = this.expireDate;
    data['startDate'] = this.startDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['quantity'] = this.quantity;
    return data;
  }
}
