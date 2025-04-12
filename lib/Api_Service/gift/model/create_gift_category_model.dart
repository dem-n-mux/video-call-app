import 'dart:convert';

CreateGiftCategoryModel createGiftCategoryModelFromJson(String str) =>
    CreateGiftCategoryModel.fromJson(json.decode(str));

String createGiftCategoryModelToJson(CreateGiftCategoryModel data) =>
    json.encode(data.toJson());

class CreateGiftCategoryModel {
  CreateGiftCategoryModel({
    bool? status,
    String? message,
    List<Gift>? gift,
  }) {
    _status = status;
    _message = message;
    _gift = gift;
  }

  CreateGiftCategoryModel.fromJson(dynamic json) {
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

  CreateGiftCategoryModel copyWith({
    bool? status,
    String? message,
    List<Gift>? gift,
  }) =>
      CreateGiftCategoryModel(
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
    bool? isActive,
    String? name,
    String? image,
    String? createdAt,
    num? giftCount,
  }) {
    _id = id;
    _isActive = isActive;
    _name = name;
    _image = image;
    _createdAt = createdAt;
    _giftCount = giftCount;
  }

  Gift.fromJson(dynamic json) {
    _id = json['_id'];
    _isActive = json['isActive'];
    _name = json['name'];
    _image = json['image'];
    _createdAt = json['createdAt'];
    _giftCount = json['giftCount'];
  }

  String? _id;
  bool? _isActive;
  String? _name;
  String? _image;
  String? _createdAt;
  num? _giftCount;

  Gift copyWith({
    String? id,
    bool? isActive,
    String? name,
    String? image,
    String? createdAt,
    num? giftCount,
  }) =>
      Gift(
        id: id ?? _id,
        isActive: isActive ?? _isActive,
        name: name ?? _name,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        giftCount: giftCount ?? _giftCount,
      );

  String? get id => _id;

  bool? get isActive => _isActive;

  String? get name => _name;

  String? get image => _image;

  String? get createdAt => _createdAt;

  num? get giftCount => _giftCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['isActive'] = _isActive;
    map['name'] = _name;
    map['image'] = _image;
    map['createdAt'] = _createdAt;
    map['giftCount'] = _giftCount;
    return map;
  }
}
