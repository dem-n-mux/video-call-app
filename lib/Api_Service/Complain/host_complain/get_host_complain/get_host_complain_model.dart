import 'dart:convert';

GetHostComplainModel getHostComplainModelFromJson(String str) =>
    GetHostComplainModel.fromJson(json.decode(str));

String getHostComplainModelToJson(GetHostComplainModel data) =>
    json.encode(data.toJson());

class GetHostComplainModel {
  GetHostComplainModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetHostComplainModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<Data>? _data;

  GetHostComplainModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      GetHostComplainModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? id,
    dynamic userId,
    String? hostId,
    String? image,
    bool? isSolved,
    String? message,
    String? contact,
    String? date,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) {
    _id = id;
    _userId = userId;
    _hostId = hostId;
    _image = image;
    _isSolved = isSolved;
    _message = message;
    _contact = contact;
    _date = date;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    _hostId = json['hostId'];
    _image = json['image'];
    _isSolved = json['isSolved'];
    _message = json['message'];
    _contact = json['contact'];
    _date = json['date'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }

  String? _id;
  dynamic _userId;
  String? _hostId;
  String? _image;
  bool? _isSolved;
  String? _message;
  String? _contact;
  String? _date;
  String? _createdAt;
  String? _updatedAt;
  num? _v;

  Data copyWith({
    String? id,
    dynamic userId,
    String? hostId,
    String? image,
    bool? isSolved,
    String? message,
    String? contact,
    String? date,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      Data(
        id: id ?? _id,
        userId: userId ?? _userId,
        hostId: hostId ?? _hostId,
        image: image ?? _image,
        isSolved: isSolved ?? _isSolved,
        message: message ?? _message,
        contact: contact ?? _contact,
        date: date ?? _date,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        v: v ?? _v,
      );

  String? get id => _id;

  dynamic get userId => _userId;

  String? get hostId => _hostId;

  String? get image => _image;

  bool? get isSolved => _isSolved;

  String? get message => _message;

  String? get contact => _contact;

  String? get date => _date;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userId'] = _userId;
    map['hostId'] = _hostId;
    map['image'] = _image;
    map['isSolved'] = _isSolved;
    map['message'] = _message;
    map['contact'] = _contact;
    map['date'] = _date;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }
}
