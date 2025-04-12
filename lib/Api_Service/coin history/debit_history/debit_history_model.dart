import 'dart:convert';

DebitHistoryModel debitHistoryModelFromJson(String str) =>
    DebitHistoryModel.fromJson(json.decode(str));

String debitHistoryModelToJson(DebitHistoryModel data) =>
    json.encode(data.toJson());

class DebitHistoryModel {
  DebitHistoryModel({
    bool? status,
    String? message,
    num? total,
    num? totalCoin,
    List<History>? history,
  }) {
    _status = status;
    _message = message;
    _total = total;
    _totalCoin = totalCoin;
    _history = history;
  }

  DebitHistoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _total = json['total'];
    _totalCoin = json['totalCoin'];
    if (json['history'] != null) {
      _history = [];
      json['history'].forEach((v) {
        _history?.add(History.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  num? _total;
  num? _totalCoin;
  List<History>? _history;

  DebitHistoryModel copyWith({
    bool? status,
    String? message,
    num? total,
    num? totalCoin,
    List<History>? history,
  }) =>
      DebitHistoryModel(
        status: status ?? _status,
        message: message ?? _message,
        total: total ?? _total,
        totalCoin: totalCoin ?? _totalCoin,
        history: history ?? _history,
      );

  bool? get status => _status;

  String? get message => _message;

  num? get total => _total;

  num? get totalCoin => _totalCoin;

  List<History>? get history => _history;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['total'] = _total;
    map['totalCoin'] = _totalCoin;
    if (_history != null) {
      map['history'] = _history?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
  History({
    String? id,
    bool? isIncome,
    num? coin,
    bool? callConnect,
    dynamic callStartTime,
    dynamic callEndTime,
    num? duration,
    num? type,
    String? date,
    String? callType,
    String? hostId,
    String? hostName,
    String? sorting,
  }) {
    _id = id;
    _isIncome = isIncome;
    _coin = coin;
    _callConnect = callConnect;
    _callStartTime = callStartTime;
    _callEndTime = callEndTime;
    _duration = duration;
    _type = type;
    _date = date;
    _callType = callType;
    _hostId = hostId;
    _hostName = hostName;
    _sorting = sorting;
  }

  History.fromJson(dynamic json) {
    _id = json['_id'];
    _isIncome = json['isIncome'];
    _coin = json['coin'];
    _callConnect = json['callConnect'];
    _callStartTime = json['callStartTime'];
    _callEndTime = json['callEndTime'];
    _duration = json['duration'];
    _type = json['type'];
    _date = json['date'];
    _callType = json['callType'];
    _hostId = json['hostId'];
    _hostName = json['hostName'];
    _sorting = json['sorting'];
  }

  String? _id;
  bool? _isIncome;
  num? _coin;
  bool? _callConnect;
  dynamic _callStartTime;
  dynamic _callEndTime;
  num? _duration;
  num? _type;
  String? _date;
  String? _callType;
  String? _hostId;
  String? _hostName;
  String? _sorting;

  History copyWith({
    String? id,
    bool? isIncome,
    num? coin,
    bool? callConnect,
    dynamic callStartTime,
    dynamic callEndTime,
    num? duration,
    num? type,
    String? date,
    String? callType,
    String? hostId,
    String? hostName,
    String? sorting,
  }) =>
      History(
        id: id ?? _id,
        isIncome: isIncome ?? _isIncome,
        coin: coin ?? _coin,
        callConnect: callConnect ?? _callConnect,
        callStartTime: callStartTime ?? _callStartTime,
        callEndTime: callEndTime ?? _callEndTime,
        duration: duration ?? _duration,
        type: type ?? _type,
        date: date ?? _date,
        callType: callType ?? _callType,
        hostId: hostId ?? _hostId,
        hostName: hostName ?? _hostName,
        sorting: sorting ?? _sorting,
      );

  String? get id => _id;

  bool? get isIncome => _isIncome;

  num? get coin => _coin;

  bool? get callConnect => _callConnect;

  dynamic get callStartTime => _callStartTime;

  dynamic get callEndTime => _callEndTime;

  num? get duration => _duration;

  num? get type => _type;

  String? get date => _date;

  String? get callType => _callType;

  String? get hostId => _hostId;

  String? get hostName => _hostName;

  String? get sorting => _sorting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['isIncome'] = _isIncome;
    map['coin'] = _coin;
    map['callConnect'] = _callConnect;
    map['callStartTime'] = _callStartTime;
    map['callEndTime'] = _callEndTime;
    map['duration'] = _duration;
    map['type'] = _type;
    map['date'] = _date;
    map['callType'] = _callType;
    map['hostId'] = _hostId;
    map['hostName'] = _hostName;
    map['sorting'] = _sorting;
    return map;
  }
}
