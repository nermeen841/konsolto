class AddtocartModel{
  bool success;
  Data data;

  AddtocartModel({this.success, this.data});

  AddtocartModel.fromJson(Map<String, dynamic> json) {
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

  Cart(
      {this.sId,
      this.removed,
      this.details,
      this.createdAt,
      this.updatedAt,
      this.iV});

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

  String createdAt;
  String updatedAt;
  int iV;
  String slug;
  bool isMonthly;
 var monthlyPrice;
  int views;
  String dynamicLink;
  int reedemablePoints;

  Product(
      {this.sId,
      this.isOffer,
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
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.slug,
      this.isMonthly,
      this.monthlyPrice,
      this.views,
      this.dynamicLink,
      this.reedemablePoints});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isOffer = json['isOffer'];

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
    name = json['name'];
    nameArabic = json['nameArabic'];
    company = json['company'];
    dose = json['dose'];
    doseArabic = json['doseArabic'];
    form = json['form'];
    formArabic = json['formArabic'];
    formQuantity = json['formQuantity'];
    quantity = json['quantity'];
    groupArabic = json['groupArabic'];
    activeIngredients = json['activeIngredients'];
    url = json['url'];
    groupSub = json['groupSub'];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    slug = json['slug'];
    isMonthly = json['isMonthly'];
    monthlyPrice = json['monthlyPrice'];
    views = json['views'];
    dynamicLink = json['dynamicLink'];
    reedemablePoints = json['reedemablePoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['isOffer'] = this.isOffer;

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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['slug'] = this.slug;
    data['isMonthly'] = this.isMonthly;
    data['monthlyPrice'] = this.monthlyPrice;
    data['views'] = this.views;
    data['dynamicLink'] = this.dynamicLink;
    data['reedemablePoints'] = this.reedemablePoints;
    return data;
  }
}

class Categories {
  String sId;
  int order;
  bool isParent;
  List<Null> categories;
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
