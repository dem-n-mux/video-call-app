import 'dart:convert';

CreateHostComplainModel createHostComplainModelFromJson(String str) =>
    CreateHostComplainModel.fromJson(json.decode(str));

String createHostComplainModelToJson(CreateHostComplainModel data) =>
    json.encode(data.toJson());

class CreateHostComplainModel {
  CreateHostComplainModel({
    bool? status,
    String? message,
    Complaint? complaint,
  }) {
    _status = status;
    _message = message;
    _complaint = complaint;
  }

  CreateHostComplainModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _complaint = json['complaint'] != null
        ? Complaint.fromJson(json['complaint'])
        : null;
  }

  bool? _status;
  String? _message;
  Complaint? _complaint;

  CreateHostComplainModel copyWith({
    bool? status,
    String? message,
    Complaint? complaint,
  }) =>
      CreateHostComplainModel(
        status: status ?? _status,
        message: message ?? _message,
        complaint: complaint ?? _complaint,
      );

  bool? get status => _status;

  String? get message => _message;

  Complaint? get complaint => _complaint;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_complaint != null) {
      map['complaint'] = _complaint?.toJson();
    }
    return map;
  }
}

Complaint complaintFromJson(String str) => Complaint.fromJson(json.decode(str));

String complaintToJson(Complaint data) => json.encode(data.toJson());

class Complaint {
  Complaint({
    dynamic userId,
    String? hostId,
    String? image,
    bool? isSolved,
    String? id,
    String? message,
    String? contact,
    String? date,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) {
    _userId = userId;
    _hostId = hostId;
    _image = image;
    _isSolved = isSolved;
    _id = id;
    _message = message;
    _contact = contact;
    _date = date;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Complaint.fromJson(dynamic json) {
    _userId = json['userId'];
    _hostId = json['hostId'];
    _image = json['image'];
    _isSolved = json['isSolved'];
    _id = json['_id'];
    _message = json['message'];
    _contact = json['contact'];
    _date = json['date'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }

  dynamic _userId;
  String? _hostId;
  String? _image;
  bool? _isSolved;
  String? _id;
  String? _message;
  String? _contact;
  String? _date;
  String? _createdAt;
  String? _updatedAt;
  num? _v;

  Complaint copyWith({
    dynamic userId,
    String? hostId,
    String? image,
    bool? isSolved,
    String? id,
    String? message,
    String? contact,
    String? date,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      Complaint(
        userId: userId ?? _userId,
        hostId: hostId ?? _hostId,
        image: image ?? _image,
        isSolved: isSolved ?? _isSolved,
        id: id ?? _id,
        message: message ?? _message,
        contact: contact ?? _contact,
        date: date ?? _date,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        v: v ?? _v,
      );

  dynamic get userId => _userId;

  String? get hostId => _hostId;

  String? get image => _image;

  bool? get isSolved => _isSolved;

  String? get id => _id;

  String? get message => _message;

  String? get contact => _contact;

  String? get date => _date;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['hostId'] = _hostId;
    map['image'] = _image;
    map['isSolved'] = _isSolved;
    map['_id'] = _id;
    map['message'] = _message;
    map['contact'] = _contact;
    map['date'] = _date;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }
}
