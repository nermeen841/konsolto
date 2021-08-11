class UserprofileModel {
  bool success;
  Data data;

  UserprofileModel({this.success, this.data});

  UserprofileModel.fromJson(Map<String, dynamic> json) {
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
  Patient patient;

  Data({this.patient});

  Data.fromJson(Map<String, dynamic> json) {
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    return data;
  }
}

class Patient {
  String sId;
  int ordersDelivered;
  int totalOrders;
  String language;
  bool isSubscribed;
  bool removed;
  String mobile;
  String code;
  String referralCode;
  String createdAt;
  String updatedAt;
  int iV;
  var address;
  String birthDate;
  String bloodType;
  String email;
  String gender;
  String name;
  Wallet wallet;
  Wallet point;
  bool isProfileComplete;
  String referralPercentage;
  String subscribeMsg;
  String referralMsg;
  String referralChatMSG;
  String relation;
  bool hasMonthlyOrders;

  Patient(
      {this.sId,
      this.ordersDelivered,
      this.totalOrders,
      this.isSubscribed,
      this.removed,
      this.mobile,
      this.code,
      this.referralCode,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.address,
      this.birthDate,
      this.bloodType,
      this.email,
      this.gender,
      this.name,
      this.wallet,
      this.point,
      this.isProfileComplete,
      this.referralPercentage,
      this.subscribeMsg,
      this.referralMsg,
      this.referralChatMSG,
      this.relation,
      this.hasMonthlyOrders});

  Patient.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ordersDelivered = json['ordersDelivered'];
    totalOrders = json['totalOrders'];
    language = json['language'];
    removed = json['removed'];
    mobile = json['mobile'];
    code = json['code'];
    referralCode = json['referralCode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  address = json['address'];
    birthDate = json['birthDate'];
    bloodType = json['bloodType'];
    email = json['email'];
    gender = json['gender'];
    name = json['name'];
    wallet =
        json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
    point = json['point'] != null ? new Wallet.fromJson(json['point']) : null;
    isProfileComplete = json['isProfileComplete'];
    referralPercentage = json['referralPercentage'];
    subscribeMsg = json['subscribeMsg'];
    referralMsg = json['referralMsg'];
    referralChatMSG = json['referralChatMSG'];
    relation = json['relation'];
    hasMonthlyOrders = json['hasMonthlyOrders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['ordersDelivered'] = this.ordersDelivered;
    data['totalOrders'] = this.totalOrders;
    data['language'] = this.language;
    data['removed'] = this.removed;
    data['mobile'] = this.mobile;
    data['code'] = this.code;
    data['referralCode'] = this.referralCode;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['address'] = this.address;
    data['birthDate'] = this.birthDate;
    data['bloodType'] = this.bloodType;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['name'] = this.name;
    if (this.wallet != null) {
      data['wallet'] = this.wallet.toJson();
    }
    if (this.point != null) {
      data['point'] = this.point.toJson();
    }
    data['isProfileComplete'] = this.isProfileComplete;
    data['referralPercentage'] = this.referralPercentage;
    data['subscribeMsg'] = this.subscribeMsg;
    data['referralMsg'] = this.referralMsg;
    data['referralChatMSG'] = this.referralChatMSG;
    data['relation'] = this.relation;
    data['hasMonthlyOrders'] = this.hasMonthlyOrders;
    return data;
  }
}

class Wallet {
  String sId;
  int availableAmount;

  Wallet({this.sId, this.availableAmount});

  Wallet.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    availableAmount = json['availableAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['availableAmount'] = this.availableAmount;
    return data;
  }
}
