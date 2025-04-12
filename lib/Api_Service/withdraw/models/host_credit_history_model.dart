import 'dart:convert';

HostCreditHistoryModel hostCreditHistoryModelFromJson(String str) => HostCreditHistoryModel.fromJson(json.decode(str));
String hostCreditHistoryModelToJson(HostCreditHistoryModel data) => json.encode(data.toJson());
class HostCreditHistoryModel {
  HostCreditHistoryModel({
      bool? status, 
      String? message, 
      num? total, 
      num? totalCoin, 
      List<History>? history,}){
    _status = status;
    _message = message;
    _total = total;
    _totalCoin = totalCoin;
    _history = history;
}

  HostCreditHistoryModel.fromJson(dynamic json) {
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
HostCreditHistoryModel copyWith({  bool? status,
  String? message,
  num? total,
  num? totalCoin,
  List<History>? history,
}) => HostCreditHistoryModel(  status: status ?? _status,
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
      String? callStartTime, 
      dynamic callEndTime, 
      num? duration, 
      num? type, 
      String? date, 
      String? videoCallType, 
      String? callType, 
      String? userId, 
      String? userName, 
      String? sorting,}){
    _id = id;
    _isIncome = isIncome;
    _coin = coin;
    _callConnect = callConnect;
    _callStartTime = callStartTime;
    _callEndTime = callEndTime;
    _duration = duration;
    _type = type;
    _date = date;
    _videoCallType = videoCallType;
    _callType = callType;
    _userId = userId;
    _userName = userName;
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
    _videoCallType = json['videoCallType'];
    _callType = json['callType'];
    _userId = json['userId'];
    _userName = json['userName'];
    _sorting = json['sorting'];
  }
  String? _id;
  bool? _isIncome;
  num? _coin;
  bool? _callConnect;
  String? _callStartTime;
  dynamic _callEndTime;
  num? _duration;
  num? _type;
  String? _date;
  String? _videoCallType;
  String? _callType;
  String? _userId;
  String? _userName;
  String? _sorting;
History copyWith({  String? id,
  bool? isIncome,
  num? coin,
  bool? callConnect,
  String? callStartTime,
  dynamic callEndTime,
  num? duration,
  num? type,
  String? date,
  String? videoCallType,
  String? callType,
  String? userId,
  String? userName,
  String? sorting,
}) => History(  id: id ?? _id,
  isIncome: isIncome ?? _isIncome,
  coin: coin ?? _coin,
  callConnect: callConnect ?? _callConnect,
  callStartTime: callStartTime ?? _callStartTime,
  callEndTime: callEndTime ?? _callEndTime,
  duration: duration ?? _duration,
  type: type ?? _type,
  date: date ?? _date,
  videoCallType: videoCallType ?? _videoCallType,
  callType: callType ?? _callType,
  userId: userId ?? _userId,
  userName: userName ?? _userName,
  sorting: sorting ?? _sorting,
);
  String? get id => _id;
  bool? get isIncome => _isIncome;
  num? get coin => _coin;
  bool? get callConnect => _callConnect;
  String? get callStartTime => _callStartTime;
  dynamic get callEndTime => _callEndTime;
  num? get duration => _duration;
  num? get type => _type;
  String? get date => _date;
  String? get videoCallType => _videoCallType;
  String? get callType => _callType;
  String? get userId => _userId;
  String? get userName => _userName;
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
    map['videoCallType'] = _videoCallType;
    map['callType'] = _callType;
    map['userId'] = _userId;
    map['userName'] = _userName;
    map['sorting'] = _sorting;
    return map;
  }

}