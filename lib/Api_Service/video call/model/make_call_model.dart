import 'dart:convert';

MakeCallModel makeCallModelFromJson(String str) => MakeCallModel.fromJson(json.decode(str));
String makeCallModelToJson(MakeCallModel data) => json.encode(data.toJson());
class MakeCallModel {
  MakeCallModel({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  MakeCallModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
MakeCallModel copyWith({  bool? status,
  String? message,
  Data? data,
}) => MakeCallModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}


Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? callerId, 
      String? receiverId, 
      String? videoCallType, 
      String? callerImage, 
      String? callerName, 
      String? live, 
      String? token, 
      String? channel, 
      String? callId,}){
    _callerId = callerId;
    _receiverId = receiverId;
    _videoCallType = videoCallType;
    _callerImage = callerImage;
    _callerName = callerName;
    _live = live;
    _token = token;
    _channel = channel;
    _callId = callId;
}

  Data.fromJson(dynamic json) {
    _callerId = json['callerId'];
    _receiverId = json['receiverId'];
    _videoCallType = json['videoCallType'];
    _callerImage = json['callerImage'];
    _callerName = json['callerName'];
    _live = json['live'];
    _token = json['token'];
    _channel = json['channel'];
    _callId = json['callId'];
  }
  String? _callerId;
  String? _receiverId;
  String? _videoCallType;
  String? _callerImage;
  String? _callerName;
  String? _live;
  String? _token;
  String? _channel;
  String? _callId;
Data copyWith({  String? callerId,
  String? receiverId,
  String? videoCallType,
  String? callerImage,
  String? callerName,
  String? live,
  String? token,
  String? channel,
  String? callId,
}) => Data(  callerId: callerId ?? _callerId,
  receiverId: receiverId ?? _receiverId,
  videoCallType: videoCallType ?? _videoCallType,
  callerImage: callerImage ?? _callerImage,
  callerName: callerName ?? _callerName,
  live: live ?? _live,
  token: token ?? _token,
  channel: channel ?? _channel,
  callId: callId ?? _callId,
);
  String? get callerId => _callerId;
  String? get receiverId => _receiverId;
  String? get videoCallType => _videoCallType;
  String? get callerImage => _callerImage;
  String? get callerName => _callerName;
  String? get live => _live;
  String? get token => _token;
  String? get channel => _channel;
  String? get callId => _callId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['callerId'] = _callerId;
    map['receiverId'] = _receiverId;
    map['videoCallType'] = _videoCallType;
    map['callerImage'] = _callerImage;
    map['callerName'] = _callerName;
    map['live'] = _live;
    map['token'] = _token;
    map['channel'] = _channel;
    map['callId'] = _callId;
    return map;
  }

}