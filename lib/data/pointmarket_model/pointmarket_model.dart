class PointmarketModel {
  bool success;
  Data data;

  PointmarketModel({this.success, this.data});

  PointmarketModel.fromJson(Map<String, dynamic> json) {
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
  List<RedeemMethods> redeemMethods;

  Data({this.redeemMethods});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['redeemMethods'] != null) {
      redeemMethods = new List<RedeemMethods>();
      json['redeemMethods'].forEach((v) {
        redeemMethods.add(new RedeemMethods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.redeemMethods != null) {
      data['redeemMethods'] =
          this.redeemMethods.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RedeemMethods {
  String sId;
  int requiredPoints;
  bool removed;
  String title;
  String titleAR;
  String description;
  String descriptionAR;
  String howToRedeem;
  String picture;
  String createdAt;
  String updatedAt;
  int iV;

  RedeemMethods(
      {this.sId,
      this.requiredPoints,
      this.removed,
      this.title,
      this.titleAR,
      this.description,
      this.descriptionAR,
      this.howToRedeem,
      this.picture,
      this.createdAt,
      this.updatedAt,
      this.iV});

  RedeemMethods.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    requiredPoints = json['requiredPoints'];
    removed = json['removed'];
    title = json['title'];
    titleAR = json['title_AR'];
    description = json['description'];
    descriptionAR = json['description_AR'];
    howToRedeem = json['howToRedeem'];
    picture = json['picture'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['requiredPoints'] = this.requiredPoints;
    data['removed'] = this.removed;
    data['title'] = this.title;
    data['title_AR'] = this.titleAR;
    data['description'] = this.description;
    data['description_AR'] = this.descriptionAR;
    data['howToRedeem'] = this.howToRedeem;
    data['picture'] = this.picture;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
