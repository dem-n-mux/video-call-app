import 'dart:convert';

GenerateGiftModel generateGiftModelFromJson(String str) =>
    GenerateGiftModel.fromJson(json.decode(str));

String generateGiftModelToJson(GenerateGiftModel data) =>
    json.encode(data.toJson());

class GenerateGiftModel {
  GenerateGiftModel({
    bool? status,
    String? message,
    List<Gift>? gift,
  }) {
    _status = status;
    _message = message;
    _gift = gift;
  }

  GenerateGiftModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['gift'] != null) {
      _gift = [];
      json['gift'].forEach((v) {
        _gift?.add(Gift.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<Gift>? _gift;

  GenerateGiftModel copyWith({
    bool? status,
    String? message,
    List<Gift>? gift,
  }) =>
      GenerateGiftModel(
        status: status ?? _status,
        message: message ?? _message,
        gift: gift ?? _gift,
      );

  bool? get status => _status;

  String? get message => _message;

  List<Gift>? get gift => _gift;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_gift != null) {
      map['gift'] = _gift?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Gift giftFromJson(String str) => Gift.fromJson(json.decode(str));

String giftToJson(Gift data) => json.encode(data.toJson());

class Gift {
  Gift({
    String? id,
    String? image,
    num? coin,
    num? type,
    String? category,
    num? platFormType,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _image = image;
    _coin = coin;
    _type = type;
    _category = category;
    _platFormType = platFormType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Gift.fromJson(dynamic json) {
    _id = json['_id'];
    _image = json['image'];
    _coin = json['coin'];
    _type = json['type'];
    _category = json['category'];
    _platFormType = json['platFormType'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _image;
  num? _coin;
  num? _type;
  String? _category;
  num? _platFormType;
  String? _createdAt;
  String? _updatedAt;

  Gift copyWith({
    String? id,
    String? image,
    num? coin,
    num? type,
    String? category,
    num? platFormType,
    String? createdAt,
    String? updatedAt,
  }) =>
      Gift(
        id: id ?? _id,
        image: image ?? _image,
        coin: coin ?? _coin,
        type: type ?? _type,
        category: category ?? _category,
        platFormType: platFormType ?? _platFormType,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;

  String? get image => _image;

  num? get coin => _coin;

  num? get type => _type;

  String? get category => _category;

  num? get platFormType => _platFormType;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['image'] = _image;
    map['coin'] = _coin;
    map['type'] = _type;
    map['category'] = _category;
    map['platFormType'] = _platFormType;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
