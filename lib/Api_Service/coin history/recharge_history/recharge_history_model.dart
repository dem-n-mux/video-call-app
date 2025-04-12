import 'dart:convert';

RechargeHistoryModel rechargeHistoryModelFromJson(String str) =>
    RechargeHistoryModel.fromJson(json.decode(str));

String rechargeHistoryModelToJson(RechargeHistoryModel data) =>
    json.encode(data.toJson());

class RechargeHistoryModel {
  RechargeHistoryModel({
    bool? status,
    String? message,
    List<History>? history,
    num? total,
    num? totalCoin,
  }) {
    _status = status;
    _message = message;
    _history = history;
    _total = total;
    _totalCoin = totalCoin;
  }

  RechargeHistoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['history'] != null) {
      _history = [];
      json['history'].forEach((v) {
        _history?.add(History.fromJson(v));
      });
    }
    _total = json['total'];
    _totalCoin = json['totalCoin'];
  }

  bool? _status;
  String? _message;
  List<History>? _history;
  num? _total;
  num? _totalCoin;

  RechargeHistoryModel copyWith({
    bool? status,
    String? message,
    List<History>? history,
    num? total,
    num? totalCoin,
  }) =>
      RechargeHistoryModel(
        status: status ?? _status,
        message: message ?? _message,
        history: history ?? _history,
        total: total ?? _total,
        totalCoin: totalCoin ?? _totalCoin,
      );

  bool? get status => _status;

  String? get message => _message;

  List<History>? get history => _history;

  num? get total => _total;

  num? get totalCoin => _totalCoin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_history != null) {
      map['history'] = _history?.map((v) => v.toJson()).toList();
    }
    map['total'] = _total;
    map['totalCoin'] = _totalCoin;
    return map;
  }
}

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
  History({
    String? id,
    num? coin,
    String? paymentGateway,
    String? name,
    num? dollar,
    String? purchaseDate,
  }) {
    _id = id;
    _coin = coin;
    _paymentGateway = paymentGateway;
    _name = name;
    _dollar = dollar;
    _purchaseDate = purchaseDate;
  }

  History.fromJson(dynamic json) {
    _id = json['_id'];
    _coin = json['coin'];
    _paymentGateway = json['paymentGateway'];
    _name = json['name'];
    _dollar = json['dollar'];
    _purchaseDate = json['purchaseDate'];
  }

  String? _id;
  num? _coin;
  String? _paymentGateway;
  String? _name;
  num? _dollar;
  String? _purchaseDate;

  History copyWith({
    String? id,
    num? coin,
    String? paymentGateway,
    String? name,
    num? dollar,
    String? purchaseDate,
  }) =>
      History(
        id: id ?? _id,
        coin: coin ?? _coin,
        paymentGateway: paymentGateway ?? _paymentGateway,
        name: name ?? _name,
        dollar: dollar ?? _dollar,
        purchaseDate: purchaseDate ?? _purchaseDate,
      );

  String? get id => _id;

  num? get coin => _coin;

  String? get paymentGateway => _paymentGateway;

  String? get name => _name;

  num? get dollar => _dollar;

  String? get purchaseDate => _purchaseDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['coin'] = _coin;
    map['paymentGateway'] = _paymentGateway;
    map['name'] = _name;
    map['dollar'] = _dollar;
    map['purchaseDate'] = _purchaseDate;
    return map;
  }
}
