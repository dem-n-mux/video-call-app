import 'dart:convert';

CoinPlanModel coinPlanCreateHistoryModelFromJson(String str) =>
    CoinPlanModel.fromJson(json.decode(str));

String coinPlanCreateHistoryModelToJson(CoinPlanModel data) =>
    json.encode(data.toJson());

class CoinPlanModel {
  CoinPlanModel({
    bool? status,
    String? message,
    History? history,
  }) {
    _status = status;
    _message = message;
    _history = history;
  }

  CoinPlanModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _history =
        json['history'] != null ? History.fromJson(json['history']) : null;
  }

  bool? _status;
  String? _message;
  History? _history;

  CoinPlanModel copyWith({
    bool? status,
    String? message,
    History? history,
  }) =>
      CoinPlanModel(
        status: status ?? _status,
        message: message ?? _message,
        history: history ?? _history,
      );

  bool? get status => _status;

  String? get message => _message;

  History? get history => _history;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_history != null) {
      map['history'] = _history?.toJson();
    }
    return map;
  }
}

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
  History({
    dynamic hostId,
    dynamic giftId,
    bool? isIncome,
    num? coin,
    dynamic callUniqueId,
    bool? callConnect,
    dynamic callStartTime,
    dynamic callEndTime,
    num? duration,
    String? id,
    String? userId,
    String? coinPlanId,
    num? type,
    String? paymentGateway,
    String? date,
  }) {
    _hostId = hostId;
    _giftId = giftId;
    _isIncome = isIncome;
    _coin = coin;
    _callUniqueId = callUniqueId;
    _callConnect = callConnect;
    _callStartTime = callStartTime;
    _callEndTime = callEndTime;
    _duration = duration;
    _id = id;
    _userId = userId;
    _coinPlanId = coinPlanId;
    _type = type;
    _paymentGateway = paymentGateway;
    _date = date;
  }

  History.fromJson(dynamic json) {
    _hostId = json['hostId'];
    _giftId = json['giftId'];
    _isIncome = json['isIncome'];
    _coin = json['coin'];
    _callUniqueId = json['callUniqueId'];
    _callConnect = json['callConnect'];
    _callStartTime = json['callStartTime'];
    _callEndTime = json['callEndTime'];
    _duration = json['duration'];
    _id = json['_id'];
    _userId = json['userId'];
    _coinPlanId = json['coinPlanId'];
    _type = json['type'];
    _paymentGateway = json['paymentGateway'];
    _date = json['date'];
  }

  dynamic _hostId;
  dynamic _giftId;
  bool? _isIncome;
  num? _coin;
  dynamic _callUniqueId;
  bool? _callConnect;
  dynamic _callStartTime;
  dynamic _callEndTime;
  num? _duration;
  String? _id;
  String? _userId;
  String? _coinPlanId;
  num? _type;
  String? _paymentGateway;
  String? _date;

  History copyWith({
    dynamic hostId,
    dynamic giftId,
    bool? isIncome,
    num? coin,
    dynamic callUniqueId,
    bool? callConnect,
    dynamic callStartTime,
    dynamic callEndTime,
    num? duration,
    String? id,
    String? userId,
    String? coinPlanId,
    num? type,
    String? paymentGateway,
    String? date,
  }) =>
      History(
        hostId: hostId ?? _hostId,
        giftId: giftId ?? _giftId,
        isIncome: isIncome ?? _isIncome,
        coin: coin ?? _coin,
        callUniqueId: callUniqueId ?? _callUniqueId,
        callConnect: callConnect ?? _callConnect,
        callStartTime: callStartTime ?? _callStartTime,
        callEndTime: callEndTime ?? _callEndTime,
        duration: duration ?? _duration,
        id: id ?? _id,
        userId: userId ?? _userId,
        coinPlanId: coinPlanId ?? _coinPlanId,
        type: type ?? _type,
        paymentGateway: paymentGateway ?? _paymentGateway,
        date: date ?? _date,
      );

  dynamic get hostId => _hostId;

  dynamic get giftId => _giftId;

  bool? get isIncome => _isIncome;

  num? get coin => _coin;

  dynamic get callUniqueId => _callUniqueId;

  bool? get callConnect => _callConnect;

  dynamic get callStartTime => _callStartTime;

  dynamic get callEndTime => _callEndTime;

  num? get duration => _duration;

  String? get id => _id;

  String? get userId => _userId;

  String? get coinPlanId => _coinPlanId;

  num? get type => _type;

  String? get paymentGateway => _paymentGateway;

  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hostId'] = _hostId;
    map['giftId'] = _giftId;
    map['isIncome'] = _isIncome;
    map['coin'] = _coin;
    map['callUniqueId'] = _callUniqueId;
    map['callConnect'] = _callConnect;
    map['callStartTime'] = _callStartTime;
    map['callEndTime'] = _callEndTime;
    map['duration'] = _duration;
    map['_id'] = _id;
    map['userId'] = _userId;
    map['coinPlanId'] = _coinPlanId;
    map['type'] = _type;
    map['paymentGateway'] = _paymentGateway;
    map['date'] = _date;
    return map;
  }
}
