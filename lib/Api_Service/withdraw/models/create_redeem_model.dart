import 'dart:convert';

CreateRedeemModel createRedeemModelFromJson(String str) => CreateRedeemModel.fromJson(json.decode(str));
String createRedeemModelToJson(CreateRedeemModel data) => json.encode(data.toJson());
class CreateRedeemModel {
  CreateRedeemModel({
      bool? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  CreateRedeemModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
CreateRedeemModel copyWith({  bool? status,
  String? message,
}) => CreateRedeemModel(  status: status ?? _status,
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