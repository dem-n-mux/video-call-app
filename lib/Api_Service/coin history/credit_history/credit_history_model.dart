import 'dart:convert';

CreditHistoryModel creditHistoryModelFromJson(String str) =>
    CreditHistoryModel.fromJson(json.decode(str));

String creditHistoryModelToJson(CreditHistoryModel data) =>
    json.encode(data.toJson());

class CreditHistoryModel {
  CreditHistoryModel({
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

  CreditHistoryModel.fromJson(dynamic json) {
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

  CreditHistoryModel copyWith({
    bool? status,
    String? message,
    List<History>? history,
    num? total,
    num? totalCoin,
  }) =>
      CreditHistoryModel(
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
    dynamic hostId,
    bool? isIncome,
    num? coin,
    String? userId,
    num? type,
    String? date,
  }) {
    _id = id;
    _hostId = hostId;
    _isIncome = isIncome;
    _coin = coin;
    _userId = userId;
    _type = type;
    _date = date;
  }

  History.fromJson(dynamic json) {
    _id = json['_id'];
    _hostId = json['hostId'];
    _isIncome = json['isIncome'];
    _coin = json['coin'];
    _userId = json['userId'];
    _type = json['type'];
    _date = json['date'];
  }

  String? _id;
  dynamic _hostId;
  bool? _isIncome;
  num? _coin;
  String? _userId;
  num? _type;
  String? _date;

  History copyWith({
    String? id,
    dynamic hostId,
    bool? isIncome,
    num? coin,
    String? userId,
    num? type,
    String? date,
  }) =>
      History(
        id: id ?? _id,
        hostId: hostId ?? _hostId,
        isIncome: isIncome ?? _isIncome,
        coin: coin ?? _coin,
        userId: userId ?? _userId,
        type: type ?? _type,
        date: date ?? _date,
      );

  String? get id => _id;

  dynamic get hostId => _hostId;

  bool? get isIncome => _isIncome;

  num? get coin => _coin;

  String? get userId => _userId;

  num? get type => _type;

  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['hostId'] = _hostId;
    map['isIncome'] = _isIncome;
    map['coin'] = _coin;
    map['userId'] = _userId;
    map['type'] = _type;
    map['date'] = _date;
    return map;
  }
}
