import 'package:konsolto/constants/constans.dart';

class UserorderModel {
  bool success;
  Data data;

  UserorderModel({this.success, this.data});

  UserorderModel.fromJson(Map<String, dynamic> json) {
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
  List<Orders> orders;

  Data({this.orders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  String sId;
  var totalPrice;
  // List<Null> howToUse;
  // List<Null> howToUseAr;
  int discount;
  bool isMonthly;
  int deliveryFees;
  bool isPickUp;
  bool isPromoValid;
  List<Files> files;
  String status;
  int rating;
  bool useWallet;
  int prePaidAmount;
  bool removed;
  String note;
  Address address;
  String orderNumber;
  List<Details> details;
  String createdAt;
  String updatedAt;
  int iV;
  String statusMsg;
  bool patientAgree;

  Orders(
      {this.sId,
      this.totalPrice,
      // this.howToUse,
      // this.howToUseAr,
      this.discount,
      this.isMonthly,
      this.deliveryFees,
      this.isPickUp,
      this.isPromoValid,
      this.files,
      this.status,
      this.rating,
      this.useWallet,
      this.prePaidAmount,
      this.removed,
      this.note,
      this.address,
      this.orderNumber,
      this.details,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.statusMsg,
      this.patientAgree});

  Orders.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    totalPrice = json['totalPrice'];
    discount = json['discount'];
    isMonthly = json['isMonthly'];
    deliveryFees = json['deliveryFees'];
    isPickUp = json['isPickUp'];
    isPromoValid = json['isPromoValid'];
    if (json['files'] != null) {
      files = new List<Files>();
      json['files'].forEach((v) {
        files.add(new Files.fromJson(v));
      });
    }
    status = json['status'];
    rating = json['rating'];
    useWallet = json['useWallet'];
    prePaidAmount = json['prePaidAmount'];
    removed = json['removed'];
    note = json['note'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    orderNumber = json['orderNumber'];
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    statusMsg = json['statusMsg'];
    patientAgree = json['patientAgree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['totalPrice'] = this.totalPrice;
    data['discount'] = this.discount;
    data['isMonthly'] = this.isMonthly;
    data['deliveryFees'] = this.deliveryFees;
    data['isPickUp'] = this.isPickUp;
    data['isPromoValid'] = this.isPromoValid;
    if (this.files != null) {
      data['files'] = this.files.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['rating'] = this.rating;
    data['useWallet'] = this.useWallet;
    data['prePaidAmount'] = this.prePaidAmount;
    data['removed'] = this.removed;
    data['note'] = this.note;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['orderNumber'] = this.orderNumber;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['statusMsg'] = this.statusMsg;
    data['patientAgree'] = this.patientAgree;
    return data;
  }
}

class Files {
  String sId;
  bool removed;
  String name;
  Null size;
  String originalName;
  String url;
  String createdAt;
  String updatedAt;
  int iV;

  Files(
      {this.sId,
      this.removed,
      this.name,
      this.size,
      this.originalName,
      this.url,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Files.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    removed = json['removed'];
    name = json['name'];
    size = json['size'];
    originalName = json['originalName'];
    url = json['url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['removed'] = this.removed;
    data['name'] = this.name;
    data['size'] = this.size;
    data['originalName'] = this.originalName;
    data['url'] = this.url;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Address {
  String sId;
  bool removed;
  String address;
  String patient;
  String latitude;
  String longitude;
  String createdAt;
  String updatedAt;
  int iV;
  String name;
  String floor;
  String flat;
  String buildingNo;

  Address(
      {this.sId,
      this.removed,
      this.address,
      this.patient,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.name,
      this.floor,
      this.flat,
      this.buildingNo});

  Address.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    removed = json['removed'];
    address = json['address'];
    patient = json['patient'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    name = json['name'];
    floor = json['floor'];
    flat = json['flat'];
    buildingNo = json['buildingNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['removed'] = this.removed;
    data['address'] = this.address;
    data['patient'] = this.patient;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['name'] = this.name;
    data['floor'] = this.floor;
    data['flat'] = this.flat;
    data['buildingNo'] = this.buildingNo;
    return data;
  }
}

class Details {
  String packageType;
  bool notFoundAndNoAlternative;
  bool hasAlternative;
  String status;
  int modifiedQuantity;
  var modifiedPricePerOne;
  var alternativePricePerOne;
  bool removed;
  String sId;
  var pricePerOne;
  int quantity;
  Product product;

  Details(
      {this.packageType,
      this.notFoundAndNoAlternative,
      this.hasAlternative,
      this.status,
      this.modifiedQuantity,
      this.modifiedPricePerOne,
      this.alternativePricePerOne,
      this.removed,
      this.sId,
      this.pricePerOne,
      this.quantity,
      this.product});

  Details.fromJson(Map<String, dynamic> json) {
    packageType = json['packageType'];
    notFoundAndNoAlternative = json['notFoundAndNoAlternative'];
    hasAlternative = json['hasAlternative'];
    status = json['status'];
    modifiedQuantity = json['modifiedQuantity'];
    modifiedPricePerOne = json['modifiedPricePerOne'];
    alternativePricePerOne = json['alternativePricePerOne'];
    removed = json['removed'];
    sId = json['_id'];
    pricePerOne = json['pricePerOne'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packageType'] = this.packageType;
    data['notFoundAndNoAlternative'] = this.notFoundAndNoAlternative;
    data['hasAlternative'] = this.hasAlternative;
    data['status'] = this.status;
    data['modifiedQuantity'] = this.modifiedQuantity;
    data['modifiedPricePerOne'] = this.modifiedPricePerOne;
    data['alternativePricePerOne'] = this.alternativePricePerOne;
    data['removed'] = this.removed;
    data['_id'] = this.sId;
    data['pricePerOne'] = this.pricePerOne;
    data['quantity'] = this.quantity;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Product {
  String sId;
  bool isOffer;
  // List<Null> pictures;
  bool isApproved;
  var price;
  List<Categories> categories;
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
  //List<Null> tags;
  bool addToFacebook;
  bool fulfilledByKonsolto;
  String dynamicLink;
  String usesArabic;
  int woocommerceID;

  Product(
      {this.sId,
      this.isOffer,
      //this.pictures,
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
      this.usesArabic,
      this.woocommerceID});

  Product.fromJson(Map<String, dynamic> json) {
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
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
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
    usesArabic = json['usesArabic'];
    woocommerceID = json['woocommerceID'];
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
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
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
    data['usesArabic'] = this.usesArabic;
    data['woocommerceID'] = this.woocommerceID;
    return data;
  }
}

class Categories {
  String sId;
  int order;
  bool isParent;
  List<Categories> categories;
  int hidden;
  bool removed;
  String name;
  String aname;
  String url;
  String createdAt;
  String updatedAt;
  int iV;

  Categories(
      {this.sId,
      this.order,
      this.isParent,
      this.categories,
      this.hidden,
      this.removed,
      this.name,
      this.aname,
      this.url,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    order = json['order'];
    isParent = json['isParent'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    hidden = json['hidden'];
    removed = json['removed'];
    name = json['name'];
    aname = json['aname'];
    url = json['url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['order'] = this.order;
    data['isParent'] = this.isParent;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    data['hidden'] = this.hidden;
    data['removed'] = this.removed;
    data['name'] = this.name;
    data['aname'] = this.aname;
    data['url'] = this.url;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
