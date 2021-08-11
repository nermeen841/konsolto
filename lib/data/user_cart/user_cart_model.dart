class UserCartModel {
  bool success;
  Data data;

  UserCartModel({this.success, this.data});

  UserCartModel.fromJson(Map<String, dynamic> json) {
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
  String sId;
  Product product;

  Details({this.packageType, this.quantity, this.sId, this.product});

  Details.fromJson(Map<String, dynamic> json) {
    packageType = json['packageType'];
    quantity = json['quantity'];
    sId = json['_id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packageType'] = this.packageType;
    data['quantity'] = this.quantity;
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
  //List<Null> products;
  // List<Null> pictures;
  bool isApproved;
  var price;
  // List<Null> categories;
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
  String startDate;
  String expireDate;
  String createdAt;
  String updatedAt;
  int iV;
  String usesArabic;
  String activeIngredientsAr;
  String description;
  String descriptionAr;
  String group;
  String companyAr;
  String contactDoctorIF;
  String contactDoctorIFArabic;
  String formQuantityArabic;
  String groupSubAr;
  String interaction3;
  String interaction1;
  String interaction2;
  String interaction4;
  String isRemoved;
  String lactatingSaftey;
  String pregnancySafteyLevel;
  String uses;

  String slug;
  int views;
  String dynamicLink;
  bool addToFacebook;
  bool fulfilledByKonsolto;
  bool isMonthly;
  var monthlyPrice;
  int reedemablePoints;
  // List<Null> tags;
  int woocommerceID;

  Product(
      {this.sId,
      this.isOffer,
      //this.products,
      // this.pictures,
      this.isApproved,
      this.price,
      //  this.categories,
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
      this.startDate,
      this.expireDate,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.usesArabic,
      this.activeIngredientsAr,
      this.description,
      this.descriptionAr,
      this.group,
      this.companyAr,
      this.contactDoctorIF,
      this.contactDoctorIFArabic,
      this.formQuantityArabic,
      this.groupSubAr,
      this.interaction3,
      this.interaction1,
      this.interaction2,
      this.interaction4,
      this.isRemoved,
      this.lactatingSaftey,
      this.pregnancySafteyLevel,
      this.uses,
      //this.interaction3,
      this.slug,
      this.views,
      this.dynamicLink,
      this.addToFacebook,
      this.fulfilledByKonsolto,
      this.isMonthly,
      this.monthlyPrice,
      this.reedemablePoints,
      // this.tags,
      this.woocommerceID});

  Product.fromJson(Map<String, dynamic> json) {
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
    // if (json['categories'] != null) {
    //   categories = new List<Null>();
    //   json['categories'].forEach((v) {
    //     categories.add(new Null.fromJson(v));
    //   });
    // }
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
    // if (json['locations'] != null) {
    //   locations = new List<Null>();
    //   json['locations'].forEach((v) {
    //     locations.add(new Null.fromJson(v));
    //   });
    // }
    startDate = json['startDate'];
    expireDate = json['expireDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    usesArabic = json['usesArabic'];
    activeIngredientsAr = json['activeIngredientsAr'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
    group = json['group'];
    companyAr = json['companyAr'];
    contactDoctorIF = json['contactDoctorIF'];
    contactDoctorIFArabic = json['contactDoctorIFArabic'];
    formQuantityArabic = json['formQuantityArabic'];
    groupSubAr = json['groupSubAr'];
    interaction3 = json['interaction 3'];
    interaction1 = json['interaction1'];
    interaction2 = json['interaction2'];
    interaction4 = json['interaction4'];
    isRemoved = json['isRemoved'];
    lactatingSaftey = json['lactatingSaftey'];
    pregnancySafteyLevel = json['pregnancySafteyLevel'];
    uses = json['uses'];
    interaction3 = json['interaction3'];
    slug = json['slug'];
    views = json['views'];
    dynamicLink = json['dynamicLink'];
    addToFacebook = json['addToFacebook'];
    fulfilledByKonsolto = json['fulfilledByKonsolto'];
    isMonthly = json['isMonthly'];
    monthlyPrice = json['monthlyPrice'];
    reedemablePoints = json['reedemablePoints'];
    // if (json['tags'] != null) {
    //   tags = new List<Null>();
    //   json['tags'].forEach((v) {
    //     tags.add(new Null.fromJson(v));
    //   });
    // }
    woocommerceID = json['woocommerceID'];
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
    // if (this.categories != null) {
    //   data['categories'] = this.categories.map((v) => v.toJson()).toList();
    // }
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
    data['startDate'] = this.startDate;
    data['expireDate'] = this.expireDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['usesArabic'] = this.usesArabic;
    data['activeIngredientsAr'] = this.activeIngredientsAr;
    data['description'] = this.description;
    data['descriptionAr'] = this.descriptionAr;
    data['group'] = this.group;
    data['companyAr'] = this.companyAr;
    data['contactDoctorIF'] = this.contactDoctorIF;
    data['contactDoctorIFArabic'] = this.contactDoctorIFArabic;
    data['formQuantityArabic'] = this.formQuantityArabic;
    data['groupSubAr'] = this.groupSubAr;
    data['interaction 3'] = this.interaction3;
    data['interaction1'] = this.interaction1;
    data['interaction2'] = this.interaction2;
    data['interaction4'] = this.interaction4;
    data['isRemoved'] = this.isRemoved;
    data['lactatingSaftey'] = this.lactatingSaftey;
    data['pregnancySafteyLevel'] = this.pregnancySafteyLevel;
    data['uses'] = this.uses;
    data['interaction3'] = this.interaction3;
    data['slug'] = this.slug;
    data['views'] = this.views;
    data['dynamicLink'] = this.dynamicLink;
    data['addToFacebook'] = this.addToFacebook;
    data['fulfilledByKonsolto'] = this.fulfilledByKonsolto;
    data['isMonthly'] = this.isMonthly;
    data['monthlyPrice'] = this.monthlyPrice;
    data['reedemablePoints'] = this.reedemablePoints;
    // if (this.tags != null) {
    //   data['tags'] = this.tags.map((v) => v.toJson()).toList();
    // }
    data['woocommerceID'] = this.woocommerceID;
    return data;
  }
}
