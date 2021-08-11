class UserAddressModel {
  bool success;
  Data data;

  UserAddressModel({this.success, this.data});

  UserAddressModel.fromJson(Map<String, dynamic> json) {
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
  List<Addresses> addresses;

  Data({this.addresses});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  bool removed;
  String sId;
  String address;
  String patient;
  String name;
  String latitude;
  String longitude;
  String floor;
  String flat;
  String buildingNo;
  String createdAt;
  String updatedAt;
  int iV;

  Addresses(
      {this.removed,
      this.sId,
      this.address,
      this.patient,
      this.name,
      this.latitude,
      this.longitude,
      this.floor,
      this.flat,
      this.buildingNo,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Addresses.fromJson(Map<String, dynamic> json) {
    removed = json['removed'];
    sId = json['_id'];
    address = json['address'];
    patient = json['patient'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    floor = json['floor'];
    flat = json['flat'];
    buildingNo = json['buildingNo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['removed'] = this.removed;
    data['_id'] = this.sId;
    data['address'] = this.address;
    data['patient'] = this.patient;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['floor'] = this.floor;
    data['flat'] = this.flat;
    data['buildingNo'] = this.buildingNo;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
