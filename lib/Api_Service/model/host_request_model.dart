import 'dart:convert';

HostRequestModel hostRequestModelFromJson(String str) => HostRequestModel.fromJson(json.decode(str));
String hostRequestModelToJson(HostRequestModel data) => json.encode(data.toJson());
class HostRequestModel {
  HostRequestModel({
      bool? status, 
      String? message, 
      Request? request,}){
    _status = status;
    _message = message;
    _request = request;
}

  HostRequestModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _request = json['request'] != null ? Request.fromJson(json['request']) : null;
  }
  bool? _status;
  String? _message;
  Request? _request;
HostRequestModel copyWith({  bool? status,
  String? message,
  Request? request,
}) => HostRequestModel(  status: status ?? _status,
  message: message ?? _message,
  request: request ?? _request,
);
  bool? get status => _status;
  String? get message => _message;
  Request? get request => _request;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_request != null) {
      map['request'] = _request?.toJson();
    }
    return map;
  }

}


Request requestFromJson(String str) => Request.fromJson(json.decode(str));
String requestToJson(Request data) => json.encode(data.toJson());
class Request {
  Request({
      String? bio, 
      num? age, 
      String? userId, 
      String? image, 
      bool? isAccepted, 
      String? id, 
      String? uniqueID, 
      String? email, 
      String? country, 
      String? identity, 
      String? date, 
      String? createdAt, 
      String? updatedAt,}){
    _bio = bio;
    _age = age;
    _userId = userId;
    _image = image;
    _isAccepted = isAccepted;
    _id = id;
    _uniqueID = uniqueID;
    _email = email;
    _country = country;
    _identity = identity;
    _date = date;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Request.fromJson(dynamic json) {
    _bio = json['bio'];
    _age = json['age'];
    _userId = json['userId'];
    _image = json['image'];
    _isAccepted = json['isAccepted'];
    _id = json['_id'];
    _uniqueID = json['uniqueID'];
    _email = json['email'];
    _country = json['country'];
    _identity = json['identity'];
    _date = json['date'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _bio;
  num? _age;
  String? _userId;
  String? _image;
  bool? _isAccepted;
  String? _id;
  String? _uniqueID;
  String? _email;
  String? _country;
  String? _identity;
  String? _date;
  String? _createdAt;
  String? _updatedAt;
Request copyWith({  String? bio,
  num? age,
  String? userId,
  String? image,
  bool? isAccepted,
  String? id,
  String? uniqueID,
  String? email,
  String? country,
  String? identity,
  String? date,
  String? createdAt,
  String? updatedAt,
}) => Request(  bio: bio ?? _bio,
  age: age ?? _age,
  userId: userId ?? _userId,
  image: image ?? _image,
  isAccepted: isAccepted ?? _isAccepted,
  id: id ?? _id,
  uniqueID: uniqueID ?? _uniqueID,
  email: email ?? _email,
  country: country ?? _country,
  identity: identity ?? _identity,
  date: date ?? _date,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get bio => _bio;
  num? get age => _age;
  String? get userId => _userId;
  String? get image => _image;
  bool? get isAccepted => _isAccepted;
  String? get id => _id;
  String? get uniqueID => _uniqueID;
  String? get email => _email;
  String? get country => _country;
  String? get identity => _identity;
  String? get date => _date;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bio'] = _bio;
    map['age'] = _age;
    map['userId'] = _userId;
    map['image'] = _image;
    map['isAccepted'] = _isAccepted;
    map['_id'] = _id;
    map['uniqueID'] = _uniqueID;
    map['email'] = _email;
    map['country'] = _country;
    map['identity'] = _identity;
    map['date'] = _date;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}