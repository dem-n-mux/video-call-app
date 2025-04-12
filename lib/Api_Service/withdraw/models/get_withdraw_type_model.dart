import 'dart:convert';

GetWithdrawTypeModel getWithdrawTypeModelFromJson(String str) => GetWithdrawTypeModel.fromJson(json.decode(str));
String getWithdrawTypeModelToJson(GetWithdrawTypeModel data) => json.encode(data.toJson());
class GetWithdrawTypeModel {
  GetWithdrawTypeModel({
      bool? status, 
      String? message, 
      List<Withdraw>? withdraw,}){
    _status = status;
    _message = message;
    _withdraw = withdraw;
}

  GetWithdrawTypeModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['withdraw'] != null) {
      _withdraw = [];
      json['withdraw'].forEach((v) {
        _withdraw?.add(Withdraw.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Withdraw>? _withdraw;
GetWithdrawTypeModel copyWith({  bool? status,
  String? message,
  List<Withdraw>? withdraw,
}) => GetWithdrawTypeModel(  status: status ?? _status,
  message: message ?? _message,
  withdraw: withdraw ?? _withdraw,
);
  bool? get status => _status;
  String? get message => _message;
  List<Withdraw>? get withdraw => _withdraw;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_withdraw != null) {
      map['withdraw'] = _withdraw?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


Withdraw withdrawFromJson(String str) => Withdraw.fromJson(json.decode(str));
String withdrawToJson(Withdraw data) => json.encode(data.toJson());
class Withdraw {
  Withdraw({
      String? id, 
      List<String>? details, 
      String? name, 
      String? image, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _details = details;
    _name = name;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Withdraw.fromJson(dynamic json) {
    _id = json['_id'];
    _details = json['details'] != null ? json['details'].cast<String>() : [];
    _name = json['name'];
    _image = json['image'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  List<String>? _details;
  String? _name;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
Withdraw copyWith({  String? id,
  List<String>? details,
  String? name,
  String? image,
  String? createdAt,
  String? updatedAt,
}) => Withdraw(  id: id ?? _id,
  details: details ?? _details,
  name: name ?? _name,
  image: image ?? _image,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  List<String>? get details => _details;
  String? get name => _name;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['details'] = _details;
    map['name'] = _name;
    map['image'] = _image;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}