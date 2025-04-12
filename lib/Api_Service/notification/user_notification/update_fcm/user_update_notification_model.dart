
import 'dart:convert';

UserUpdateNotificationModel userUpdateNotificationModelFromJson(String str) => UserUpdateNotificationModel.fromJson(json.decode(str));
String userUpdateNotificationModelToJson(UserUpdateNotificationModel data) => json.encode(data.toJson());
class UserUpdateNotificationModel {
  UserUpdateNotificationModel({
      bool? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  UserUpdateNotificationModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
UserUpdateNotificationModel copyWith({  bool? status,
  String? message,
}) => UserUpdateNotificationModel(  status: status ?? _status,
  message: message ?? _message,
);
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}