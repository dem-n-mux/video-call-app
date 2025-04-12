import 'dart:convert';

GlobalCountryModel globalCountryModelFromJson(String str) =>
    GlobalCountryModel.fromJson(json.decode(str));

String globalCountryModelToJson(GlobalCountryModel data) =>
    json.encode(data.toJson());

class GlobalCountryModel {
  GlobalCountryModel({
    bool? status,
    String? message,
    List<Flag>? flag,
  }) {
    _status = status;
    _message = message;
    _flag = flag;
  }

  GlobalCountryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['flag'] != null) {
      _flag = [];
      json['flag'].forEach((v) {
        _flag?.add(Flag.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<Flag>? _flag;

  GlobalCountryModel copyWith({
    bool? status,
    String? message,
    List<Flag>? flag,
  }) =>
      GlobalCountryModel(
        status: status ?? _status,
        message: message ?? _message,
        flag: flag ?? _flag,
      );

  bool? get status => _status;

  String? get message => _message;

  List<Flag>? get flag => _flag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_flag != null) {
      map['flag'] = _flag?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Flag flagFromJson(String str) => Flag.fromJson(json.decode(str));

String flagToJson(Flag data) => json.encode(data.toJson());

class Flag {
  Flag({
    String? id,
    String? name,
    String? flag,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _flag = flag;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Flag.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _flag = json['flag'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _name;
  String? _flag;
  String? _createdAt;
  String? _updatedAt;

  Flag copyWith({
    String? id,
    String? name,
    String? flag,
    String? createdAt,
    String? updatedAt,
  }) =>
      Flag(
        id: id ?? _id,
        name: name ?? _name,
        flag: flag ?? _flag,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;

  String? get name => _name;

  String? get flag => _flag;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['flag'] = _flag;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
