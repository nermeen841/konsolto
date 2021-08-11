// import 'package:konsolto/constants/constans.dart';

// class HomeSectionModel {
//   bool success;
//   Data data;

//   HomeSectionModel({this.success, this.data});

//   HomeSectionModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   List<Sections> sections;

//   Data({this.sections});

//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['sections'] != null) {
//       // ignore: deprecated_member_use
//       sections = new List<Sections>();
//       json['sections'].forEach((v) {
//         sections.add(new Sections.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.sections != null) {
//       data['sections'] = this.sections.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Sections {
//   String sId;
//   String title;
//   String titleAr;
//   List<Categories> categories;
//   List<Pharmacies> pharmacies;
//   List<Products> products;
//   int order;
//   bool removed;
//   String name;
//   String type;
//   List<Sliders> sliders;
//   String createdAt;
//   String updatedAt;
//   int iV;
//   String titleHexColor;
//   List<Brands> brands;
//   String backgroundURL;

//   Sections(
//       {this.sId,
//       this.title,
//       this.titleAr,
//       this.categories,
//       this.pharmacies,
//       this.products,
//       this.order,
//       this.removed,
//       this.name,
//       this.type,
//       this.sliders,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.titleHexColor,
//       this.brands,
//       this.backgroundURL});

//   Sections.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     titleAr = json['titleAr'];
//     if (json['categories'] != null) {
//       // ignore: deprecated_member_use
//       categories = new List<Categories>();
//       json['categories'].forEach((v) {
//         categories.add(new Categories.fromJson(v));
//       });
//     }
//     if (json['pharmacies'] != null) {
//       // ignore: deprecated_member_use
//       pharmacies = new List<Pharmacies>();
//       json['pharmacies'].forEach((v) {
//         pharmacies.add(new Pharmacies.fromJson(v));
//       });
//     }
//     if (json['products'] != null) {
//       // ignore: deprecated_member_use
//       var list = new List<Products>();
//       products = list;
//       json['products'].forEach((v) {
//         products.add(new Products.fromJson(v));
//       });
//     }
//     order = json['order'];
//     removed = json['removed'];
//     name = json['name'];
//     type = json['type'];
//     if (json['sliders'] != null) {
//       // ignore: deprecated_member_use
//       sliders = new List<Sliders>();
//       json['sliders'].forEach((v) {
//         sliders.add(new Sliders.fromJson(v));
//       });
//     }
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     titleHexColor = json['titleHexColor'];
//     if (json['brands'] != null) {
//       // ignore: deprecated_member_use
//       brands = new List<Brands>();
//       json['brands'].forEach((v) {
//         brands.add(new Brands.fromJson(v));
//       });
//     }
//     backgroundURL = json['backgroundURL'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['title'] = this.title;
//     data['titleAr'] = this.titleAr;
//     if (this.categories != null) {
//       data['categories'] = this.categories.map((v) => v.toJson()).toList();
//     }
//     if (this.pharmacies != null) {
//       data['pharmacies'] = this.pharmacies.map((v) => v.toJson()).toList();
//     }
//     if (this.products != null) {
//       data['products'] = this.products.map((v) => v.toJson()).toList();
//     }
//     data['order'] = this.order;
//     data['removed'] = this.removed;
//     data['name'] = this.name;
//     data['type'] = this.type;
//     if (this.sliders != null) {
//       data['sliders'] = this.sliders.map((v) => v.toJson()).toList();
//     }
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     data['titleHexColor'] = this.titleHexColor;
//     if (this.brands != null) {
//       data['brands'] = this.brands.map((v) => v.toJson()).toList();
//     }
//     data['backgroundURL'] = this.backgroundURL;
//     return data;
//   }
// }

// class Categories {
//   String sId;
//   int order;
//   bool isParent;
//   List<Categories1> categories1;
//   int hidden;
//   bool removed;
//   String name;
//   String aname;
//   String url;
//   String createdAt;
//   String updatedAt;
//   int iV;

//   Categories(
//       {this.sId,
//       this.order,
//       this.isParent,
//       this.categories1,
//       this.hidden,
//       this.removed,
//       this.name,
//       this.aname,
//       this.url,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   Categories.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     order = json['order'];
//     isParent = json['isParent'];
//     if (json['categories'] != null) {
//       // ignore: deprecated_member_use
//       categories1 = new List<Categories1>();
//       json['categories'].forEach((v) {
//         categories1.add(new Categories1.fromJson(v));
//       });
//     }
//     hidden = json['hidden'];
//     removed = json['removed'];
//     name = json['name'];
//     aname = json['aname'];
//     url = json['url'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['order'] = this.order;
//     data['isParent'] = this.isParent;
//     if (this.categories1 != null) {
//       data['categories'] = this.categories1.map((v) => v.toJson()).toList();
//     }
//     data['hidden'] = this.hidden;
//     data['removed'] = this.removed;
//     data['name'] = this.name;
//     data['aname'] = this.aname;
//     data['url'] = this.url;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

// class Categories1 {
//   String sId;
//   int order;
//   bool isParent;
//   List<Categories1> categories;
//   int hidden;
//   bool removed;
//   String name;
//   String aname;
//   String url;
//   String createdAt;
//   String updatedAt;
//   int iV;

//   Categories1(
//       {this.sId,
//       this.order,
//       this.isParent,
//       this.categories,
//       this.hidden,
//       this.removed,
//       this.name,
//       this.aname,
//       this.url,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   Categories1.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     order = json['order'];
//     isParent = json['isParent'];
//     if (json['categories'] != null) {
//       categories = new List<Categories1>();
//       json['categories'].forEach((v) {
//         categories.add(new Categories1.fromJson(v));
//       });
//     }
//     hidden = json['hidden'];
//     removed = json['removed'];
//     name = json['name'];
//     aname = json['aname'];
//     url = json['url'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['order'] = this.order;
//     data['isParent'] = this.isParent;
//     if (this.categories != null) {
//       data['categories'] = this.categories.map((v) => v.toJson()).toList();
//     }
//     data['hidden'] = this.hidden;
//     data['removed'] = this.removed;
//     data['name'] = this.name;
//     data['aname'] = this.aname;
//     data['url'] = this.url;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

// class Pharmacies {
//   String sId;
//   //List<Null> numbers;
//   bool removed;
//   String name;
//   String sqlId;
//   String createdAt;
//   String updatedAt;
//   int iV;
//   String url;

//   Pharmacies(
//       {this.sId,
//       //this.numbers,
//       this.removed,
//       this.name,
//       this.sqlId,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.url});

//   Pharmacies.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     // if (json['numbers'] != null) {
//     //   numbers = new List<Null>();
//     //   json['numbers'].forEach((v) {
//     //     numbers.add(new Null.fromJson(v));
//     //   });
//     // }
//     removed = json['removed'];
//     name = json['name'];
//     sqlId = json['sql_id'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     url = json['url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     // if (this.numbers != null) {
//     //   data['numbers'] = this.numbers.map((v) => v.toJson()).toList();
//     // }
//     data['removed'] = this.removed;
//     data['name'] = this.name;
//     data['sql_id'] = this.sqlId;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     data['url'] = this.url;
//     return data;
//   }
// }

// class Products {
//   String sId;
//   bool isOffer;
//   bool isApproved;
//   var price;
//   bool hidden;
//   bool isSeparated;
//   bool order;
//   bool removed;
//   bool isLimited;
//   String name;
//   String nameArabic;
//   String company;
//   String dose;
//   String doseArabic;
//   String form;
//   String formArabic;
//   String formQuantity;
//   int quantity;
//   String groupArabic;
//   String activeIngredients;
//   String url;
//   String groupSub;
//   //List<Null> locations;
//   String createdAt;
//   String updatedAt;
//   int iV;
//   String slug;
//   int views;
//   bool isMonthly;
//   var monthlyPrice;
//   bool addToFacebook;
//   int reedemablePoints;
//   //List<Tags> tags;
//   bool fulfilledByKonsolto;
//   String dynamicLink;

//   Products({
//     this.sId,
//     this.isOffer,
//     this.isApproved,
//     this.price,
//     this.hidden,
//     this.isSeparated,
//     this.order,
//     this.removed,
//     this.isLimited,
//     this.name,
//     this.nameArabic,
//     this.company,
//     this.dose,
//     this.doseArabic,
//     this.form,
//     this.formArabic,
//     this.formQuantity,
//     this.quantity,
//     this.groupArabic,
//     this.activeIngredients,
//     this.url,
//     this.groupSub,
//     // this.locations,
//     this.createdAt,
//     this.updatedAt,
//     this.iV,
//     this.slug,
//     this.views,
//     this.isMonthly,
//     this.monthlyPrice,
//     this.addToFacebook,
//     this.reedemablePoints,
//     // this.tags,
//     this.fulfilledByKonsolto,
//     this.dynamicLink,
//   });

//   Products.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     isOffer = json['isOffer'];
//     isApproved = json['isApproved'];
//     price = json['price'];
//     hidden = json['hidden'];
//     isSeparated = json['isSeparated'];
//     order = json['order'];
//     removed = json['removed'];
//     isLimited = json['isLimited'];
//     name = (apiLang() == 'en') ? json['nameArabic'] : json['name'];
//     nameArabic = json['nameArabic'];
//     company = json['company'];
//     dose = (apiLang() == 'en') ? json['doseArabic'] : json['dose'];
//     doseArabic = json['doseArabic'];
//     form = (apiLang() == 'en') ? json['formArabic'] : json['form'];
//     formArabic = json['formArabic'];
//     formQuantity = json['formQuantity'];
//     quantity = json['quantity'];
//     groupArabic = json['groupArabic'];
//     activeIngredients = json['activeIngredients'];
//     url = json['url'];
//     groupSub = json['groupSub'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     slug = json['slug'];
//     views = json['views'];
//     isMonthly = json['isMonthly'];
//     monthlyPrice = json['monthlyPrice'];
//     addToFacebook = json['addToFacebook'];
//     reedemablePoints = json['reedemablePoints'];
//     fulfilledByKonsolto = json['fulfilledByKonsolto'];
//     dynamicLink = json['dynamicLink'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['isOffer'] = this.isOffer;
//     data['isApproved'] = this.isApproved;
//     data['price'] = this.price;
//     data['hidden'] = this.hidden;
//     data['isSeparated'] = this.isSeparated;
//     data['order'] = this.order;
//     data['removed'] = this.removed;
//     data['isLimited'] = this.isLimited;
//     data['name'] = this.name;
//     data['nameArabic'] = this.nameArabic;
//     data['company'] = this.company;
//     data['dose'] = this.dose;
//     data['doseArabic'] = this.doseArabic;
//     data['form'] = this.form;
//     data['formArabic'] = this.formArabic;
//     data['formQuantity'] = this.formQuantity;
//     data['quantity'] = this.quantity;
//     data['groupArabic'] = this.groupArabic;
//     data['activeIngredients'] = this.activeIngredients;
//     data['url'] = this.url;
//     data['groupSub'] = this.groupSub;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     data['slug'] = this.slug;
//     data['views'] = this.views;
//     data['isMonthly'] = this.isMonthly;
//     data['monthlyPrice'] = this.monthlyPrice;
//     data['addToFacebook'] = this.addToFacebook;
//     data['reedemablePoints'] = this.reedemablePoints;
//     data['fulfilledByKonsolto'] = this.fulfilledByKonsolto;
//     data['dynamicLink'] = this.dynamicLink;
//     return data;
//   }
// }

// class Sliders {
//   String sId;
//   String url;
//   Categories category;
//   Pharmacy pharmacy;

//   Sliders({this.sId, this.url, this.category, this.pharmacy});

//   Sliders.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     url = json['url'];
//     category = json['category'] != null
//         ? new Categories.fromJson(json['category'])
//         : null;
//     pharmacy = json['pharmacy'] != null
//         ? new Pharmacy.fromJson(json['pharmacy'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['url'] = this.url;
//     if (this.category != null) {
//       data['category'] = this.category.toJson();
//     }
//     if (this.pharmacy != null) {
//       data['pharmacy'] = this.pharmacy.toJson();
//     }
//     return data;
//   }
// }

// class Pharmacy {
//   String sId;
//   //List<Null> numbers;
//   bool removed;
//   String name;
//   String sqlId;
//   String createdAt;
//   String updatedAt;
//   int iV;
//   String url;

//   Pharmacy(
//       {this.sId,
//       // this.numbers,
//       this.removed,
//       this.name,
//       this.sqlId,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.url});

//   Pharmacy.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     // if (json['numbers'] != null) {
//     //   numbers = new List<Null>();
//     //   json['numbers'].forEach((v) {
//     //     numbers.add(new Null.fromJson(v));
//     //   });
//     // }
//     removed = json['removed'];
//     name = json['name'];
//     sqlId = json['sql_id'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     url = json['url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     // if (this.numbers != null) {
//     //   data['numbers'] = this.numbers.map((v) => v.toJson()).toList();
//     // }
//     data['removed'] = this.removed;
//     data['name'] = this.name;
//     data['sql_id'] = this.sqlId;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     data['url'] = this.url;
//     return data;
//   }
// }

// class Brands {
//   String sId;
//   bool isBrand;
//   bool removed;
//   String name;
//   String nameAr;
//   String createdAt;
//   String updatedAt;
//   int iV;
//   String url;

//   Brands(
//       {this.sId,
//       this.isBrand,
//       this.removed,
//       this.name,
//       this.nameAr,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.url});

//   Brands.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     isBrand = json['isBrand'];
//     removed = json['removed'];
//     name = json['name'];
//     nameAr = json['nameAr'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     url = json['url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['isBrand'] = this.isBrand;
//     data['removed'] = this.removed;
//     data['name'] = this.name;
//     data['nameAr'] = this.nameAr;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     data['url'] = this.url;
//     return data;
//   }
// }
