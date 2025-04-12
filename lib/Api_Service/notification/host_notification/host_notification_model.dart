import 'dart:convert';

HostNotificationModel hostNotificationModelFromJson(String str) => HostNotificationModel.fromJson(json.decode(str));
String hostNotificationModelToJson(HostNotificationModel data) => json.encode(data.toJson());
class HostNotificationModel {
  HostNotificationModel({
      bool? status, 
      String? message, 
      List<Notification>? notification,}){
    _status = status;
    _message = message;
    _notification = notification;
}

  HostNotificationModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['notification'] != null) {
      _notification = [];
      json['notification'].forEach((v) {
        _notification?.add(Notification.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Notification>? _notification;
HostNotificationModel copyWith({  bool? status,
  String? message,
  List<Notification>? notification,
}) => HostNotificationModel(  status: status ?? _status,
  message: message ?? _message,
  notification: notification ?? _notification,
);
  bool? get status => _status;
  String? get message => _message;
  List<Notification>? get notification => _notification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_notification != null) {
      map['notification'] = _notification?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


Notification notificationFromJson(String str) => Notification.fromJson(json.decode(str));
String notificationToJson(Notification data) => json.encode(data.toJson());
class Notification {
  Notification({
      String? id, 
      dynamic userId, 
      String? hostId, 
      dynamic type, 
      String? image, 
      String? title, 
      String? message, 
      num? notificationType, 
      String? date, 
      String? time,}){
    _id = id;
    _userId = userId;
    _hostId = hostId;
    _type = type;
    _image = image;
    _title = title;
    _message = message;
    _notificationType = notificationType;
    _date = date;
    _time = time;
}

  Notification.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    _hostId = json['hostId'];
    _type = json['type'];
    _image = json['image'];
    _title = json['title'];
    _message = json['message'];
    _notificationType = json['notificationType'];
    _date = json['date'];
    _time = json['time'];
  }
  String? _id;
  dynamic _userId;
  String? _hostId;
  dynamic _type;
  String? _image;
  String? _title;
  String? _message;
  num? _notificationType;
  String? _date;
  String? _time;
Notification copyWith({  String? id,
  dynamic userId,
  String? hostId,
  dynamic type,
  String? image,
  String? title,
  String? message,
  num? notificationType,
  String? date,
  String? time,
}) => Notification(  id: id ?? _id,
  userId: userId ?? _userId,
  hostId: hostId ?? _hostId,
  type: type ?? _type,
  image: image ?? _image,
  title: title ?? _title,
  message: message ?? _message,
  notificationType: notificationType ?? _notificationType,
  date: date ?? _date,
  time: time ?? _time,
);
  String? get id => _id;
  dynamic get userId => _userId;
  String? get hostId => _hostId;
  dynamic get type => _type;
  String? get image => _image;
  String? get title => _title;
  String? get message => _message;
  num? get notificationType => _notificationType;
  String? get date => _date;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userId'] = _userId;
    map['hostId'] = _hostId;
    map['type'] = _type;
    map['image'] = _image;
    map['title'] = _title;
    map['message'] = _message;
    map['notificationType'] = _notificationType;
    map['date'] = _date;
    map['time'] = _time;
    return map;
  }

}