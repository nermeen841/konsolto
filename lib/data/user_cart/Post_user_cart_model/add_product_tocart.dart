class EditcartModel {
  bool success;
  Data data;

  EditcartModel({this.success, this.data});

  EditcartModel.fromJson(Map<String, dynamic> json) {
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
  Cart cart;

  Data({this.cart});

  Data.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart.toJson();
    }
    return data;
  }
}

class Cart {
  String sId;
  bool removed;
  List<Details> details;
  String createdAt;
  String updatedAt;
  int iV;
  bool isOffersExpired;

  Cart(
      {this.sId,
      this.removed,
      this.details,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isOffersExpired});

  Cart.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    removed = json['removed'];
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isOffersExpired = json['isOffersExpired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['removed'] = this.removed;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isOffersExpired'] = this.isOffersExpired;
    return data;
  }
}

class Details {
  String packageType;
  int quantity;
  bool isDeliveryError;
  String sId;
  Product product;

  Details(
      {this.packageType,
      this.quantity,
      this.isDeliveryError,
      this.sId,
      this.product});

  Details.fromJson(Map<String, dynamic> json) {
    packageType = json['packageType'];
    quantity = json['quantity'];
    isDeliveryError = json['isDeliveryError'];
    sId = json['_id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packageType'] = this.packageType;
    data['quantity'] = this.quantity;
    data['isDeliveryError'] = this.isDeliveryError;
    data['_id'] = this.sId;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Product {
  String sId;
  bool isOffer;
  bool fulfilledByKonsolto;
  int reedemablePoints;
  bool isApproved;
  bool addToFacebook;
  int price;

  bool hidden;
  bool isSeparated;
  bool order;
  bool removed;
  bool isLimited;
  bool isMonthly;
  int monthlyPrice;
  int views;
  String createdAt;
  String updatedAt;
  int iV;

  Product(
      {this.sId,
      this.isOffer,
      this.fulfilledByKonsolto,
      this.reedemablePoints,
      this.isApproved,
      this.addToFacebook,
      this.price,
      this.hidden,
      this.isSeparated,
      this.order,
      this.removed,
      this.isLimited,
      this.isMonthly,
      this.monthlyPrice,
      this.views,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isOffer = json['isOffer'];

    fulfilledByKonsolto = json['fulfilledByKonsolto'];

    reedemablePoints = json['reedemablePoints'];
    isApproved = json['isApproved'];
    addToFacebook = json['addToFacebook'];
    price = json['price'];

    hidden = json['hidden'];
    isSeparated = json['isSeparated'];
    order = json['order'];
    removed = json['removed'];
    isLimited = json['isLimited'];
    isMonthly = json['isMonthly'];
    monthlyPrice = json['monthlyPrice'];
    views = json['views'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['isOffer'] = this.isOffer;

    data['fulfilledByKonsolto'] = this.fulfilledByKonsolto;

    data['reedemablePoints'] = this.reedemablePoints;
    data['isApproved'] = this.isApproved;
    data['addToFacebook'] = this.addToFacebook;
    data['price'] = this.price;

    data['hidden'] = this.hidden;
    data['isSeparated'] = this.isSeparated;
    data['order'] = this.order;
    data['removed'] = this.removed;
    data['isLimited'] = this.isLimited;
    data['isMonthly'] = this.isMonthly;
    data['monthlyPrice'] = this.monthlyPrice;
    data['views'] = this.views;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
