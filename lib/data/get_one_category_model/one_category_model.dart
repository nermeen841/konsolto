import 'package:konsolto/constants/constans.dart';

class SinglecatModel {
  bool success;
  Data data;

  SinglecatModel({this.success, this.data});

  SinglecatModel.fromJson(Map<String, dynamic> json) {
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
  Category category;

  Data({this.category});

  Data.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}

class Category {
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

  Category(
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

  Category.fromJson(Map<String, dynamic> json) {
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
    name = (apiLang() == 'en') ? json['aname'] : json['name'];
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
    name = (apiLang() == 'en') ? json['aname'] : json['name'];
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
