import 'dart:convert';

HostSearchModel hostSearchModelFromJson(String str) => HostSearchModel.fromJson(json.decode(str));
String hostSearchModelToJson(HostSearchModel data) => json.encode(data.toJson());
class HostSearchModel {
  HostSearchModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  HostSearchModel.fromJson(dynamic json) {
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
HostSearchModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => HostSearchModel(  status: status ?? _status,
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
      String? name, 
      String? image, 
      String? country, 
      String? message, 
      String? topicId, 
      String? time, 
      String? createdAt,}){
    _id = id;
    _name = name;
    _image = image;
    _country = country;
    _message = message;
    _topicId = topicId;
    _time = time;
    _createdAt = createdAt;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _image = json['image'];
    _country = json['country'];
    _message = json['message'];
    _topicId = json['topicId'];
    _time = json['time'];
    _createdAt = json['createdAt'];
  }
  String? _id;
  String? _name;
  String? _image;
  String? _country;
  String? _message;
  String? _topicId;
  String? _time;
  String? _createdAt;
Data copyWith({  String? id,
  String? name,
  String? image,
  String? country,
  String? message,
  String? topicId,
  String? time,
  String? createdAt,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  image: image ?? _image,
  country: country ?? _country,
  message: message ?? _message,
  topicId: topicId ?? _topicId,
  time: time ?? _time,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get country => _country;
  String? get message => _message;
  String? get topicId => _topicId;
  String? get time => _time;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['country'] = _country;
    map['message'] = _message;
    map['topicId'] = _topicId;
    map['time'] = _time;
    map['createdAt'] = _createdAt;
    return map;
  }

}