import 'dart:convert';

StickerModel stickerModelFromJson(String str) => StickerModel.fromJson(json.decode(str));
String stickerModelToJson(StickerModel data) => json.encode(data.toJson());
class StickerModel {
  StickerModel({
      bool? status, 
      String? message, 
      List<Sticker>? sticker,}){
    _status = status;
    _message = message;
    _sticker = sticker;
}

  StickerModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['sticker'] != null) {
      _sticker = [];
      json['sticker'].forEach((v) {
        _sticker?.add(Sticker.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Sticker>? _sticker;
StickerModel copyWith({  bool? status,
  String? message,
  List<Sticker>? sticker,
}) => StickerModel(  status: status ?? _status,
  message: message ?? _message,
  sticker: sticker ?? _sticker,
);
  bool? get status => _status;
  String? get message => _message;
  List<Sticker>? get sticker => _sticker;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_sticker != null) {
      map['sticker'] = _sticker?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


Sticker stickerFromJson(String str) => Sticker.fromJson(json.decode(str));
String stickerToJson(Sticker data) => json.encode(data.toJson());
class Sticker {
  Sticker({
      String? id, 
      String? sticker, 
      String? createdAt, 
      String? updatedAt, 
      String? type,}){
    _id = id;
    _sticker = sticker;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _type = type;
}

  Sticker.fromJson(dynamic json) {
    _id = json['_id'];
    _sticker = json['sticker'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _type = json['type'];
  }
  String? _id;
  String? _sticker;
  String? _createdAt;
  String? _updatedAt;
  String? _type;
Sticker copyWith({  String? id,
  String? sticker,
  String? createdAt,
  String? updatedAt,
  String? type,
}) => Sticker(  id: id ?? _id,
  sticker: sticker ?? _sticker,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  type: type ?? _type,
);
  String? get id => _id;
  String? get sticker => _sticker;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['sticker'] = _sticker;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['type'] = _type;
    return map;
  }

}