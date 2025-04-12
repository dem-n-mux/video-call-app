import 'dart:convert';

WithdrawModel withdrawModelFromJson(String str) => WithdrawModel.fromJson(json.decode(str));
String withdrawModelToJson(WithdrawModel data) => json.encode(data.toJson());
class WithdrawModel {
  WithdrawModel({
      bool? status, 
      String? message, 
      List<Redeem>? redeem,}){
    _status = status;
    _message = message;
    _redeem = redeem;
}

  WithdrawModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['redeem'] != null) {
      _redeem = [];
      json['redeem'].forEach((v) {
        _redeem?.add(Redeem.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Redeem>? _redeem;
WithdrawModel copyWith({  bool? status,
  String? message,
  List<Redeem>? redeem,
}) => WithdrawModel(  status: status ?? _status,
  message: message ?? _message,
  redeem: redeem ?? _redeem,
);
  bool? get status => _status;
  String? get message => _message;
  List<Redeem>? get redeem => _redeem;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_redeem != null) {
      map['redeem'] = _redeem?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Redeem redeemFromJson(String str) => Redeem.fromJson(json.decode(str));
String redeemToJson(Redeem data) => json.encode(data.toJson());
class Redeem {
  Redeem({
      String? id, 
      String? hostId, 
      String? description, 
      num? coin, 
      String? paymentGateway, 
      String? date, 
      String? createdAt, 
      String? updatedAt, 
      String? status, 
      String? time,}){
    _id = id;
    _hostId = hostId;
    _description = description;
    _coin = coin;
    _paymentGateway = paymentGateway;
    _date = date;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _status = status;
    _time = time;
}

  Redeem.fromJson(dynamic json) {
    _id = json['_id'];
    _hostId = json['hostId'];
    _description = json['description'];
    _coin = json['coin'];
    _paymentGateway = json['paymentGateway'];
    _date = json['date'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _status = json['status'];
    _time = json['time'];
  }
  String? _id;
  String? _hostId;
  String? _description;
  num? _coin;
  String? _paymentGateway;
  String? _date;
  String? _createdAt;
  String? _updatedAt;
  String? _status;
  String? _time;
Redeem copyWith({  String? id,
  String? hostId,
  String? description,
  num? coin,
  String? paymentGateway,
  String? date,
  String? createdAt,
  String? updatedAt,
  String? status,
  String? time,
}) => Redeem(  id: id ?? _id,
  hostId: hostId ?? _hostId,
  description: description ?? _description,
  coin: coin ?? _coin,
  paymentGateway: paymentGateway ?? _paymentGateway,
  date: date ?? _date,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  status: status ?? _status,
  time: time ?? _time,
);
  String? get id => _id;
  String? get hostId => _hostId;
  String? get description => _description;
  num? get coin => _coin;
  String? get paymentGateway => _paymentGateway;
  String? get date => _date;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get status => _status;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['hostId'] = _hostId;
    map['description'] = _description;
    map['coin'] = _coin;
    map['paymentGateway'] = _paymentGateway;
    map['date'] = _date;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['status'] = _status;
    map['time'] = _time;
    return map;
  }

}