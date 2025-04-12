import 'dart:convert';

GetOldChatModel getOldChatModelFromJson(String str) => GetOldChatModel.fromJson(json.decode(str));

String getOldChatModelToJson(GetOldChatModel data) => json.encode(data.toJson());

class GetOldChatModel {
  GetOldChatModel({
    bool? status,
    String? message,
    List<GetOldChat>? chat,
  }) {
    _status = status;
    _message = message;
    _chat = chat;
  }

  GetOldChatModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['chat'] != null) {
      _chat = [];
      json['chat'].forEach((v) {
        _chat?.add(GetOldChat.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<GetOldChat>? _chat;

  GetOldChatModel copyWith({
    bool? status,
    String? message,
    List<GetOldChat>? chat,
  }) =>
      GetOldChatModel(
        status: status ?? _status,
        message: message ?? _message,
        chat: chat ?? _chat,
      );

  bool? get status => _status;

  String? get message => _message;

  List<GetOldChat>? get chat => _chat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_chat != null) {
      map['chat'] = _chat?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

GetOldChat chatFromJson(String str) => GetOldChat.fromJson(json.decode(str));

String chatToJson(GetOldChat data) => json.encode(data.toJson());

class GetOldChat {
  GetOldChat({
    String? id,
    dynamic image,
    dynamic video,
    dynamic audio,
    bool? isRead,
    String? senderId,
    num? messageType,
    String? message,
    num? type,
    String? topicId,
    String? date,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _image = image;
    _video = video;
    _audio = audio;
    _isRead = isRead;
    _senderId = senderId;
    _messageType = messageType;
    _message = message;
    _type = type;
    _topicId = topicId;
    _date = date;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  GetOldChat.fromJson(dynamic json) {
    _id = json['_id'];
    _image = json['image'];
    _video = json['video'];
    _audio = json['audio'];
    _isRead = json['isRead'];
    _senderId = json['senderId'];
    _messageType = json['messageType'];
    _message = json['message'];
    _type = json['type'];
    _topicId = json['topicId'];
    _date = json['date'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  dynamic _image;
  dynamic _video;
  dynamic _audio;
  bool? _isRead;
  String? _senderId;
  num? _messageType;
  String? _message;
  num? _type;
  String? _topicId;
  String? _date;
  String? _createdAt;
  String? _updatedAt;

  GetOldChat copyWith({
    String? id,
    dynamic image,
    dynamic video,
    dynamic audio,
    bool? isRead,
    String? senderId,
    num? messageType,
    String? message,
    num? type,
    String? topicId,
    String? date,
    String? createdAt,
    String? updatedAt,
  }) =>
      GetOldChat(
        id: id ?? _id,
        image: image ?? _image,
        video: video ?? _video,
        audio: audio ?? _audio,
        isRead: isRead ?? _isRead,
        senderId: senderId ?? _senderId,
        messageType: messageType ?? _messageType,
        message: message ?? _message,
        type: type ?? _type,
        topicId: topicId ?? _topicId,
        date: date ?? _date,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;

  dynamic get image => _image;

  dynamic get video => _video;

  dynamic get audio => _audio;

  bool? get isRead => _isRead;

  String? get senderId => _senderId;

  num? get messageType => _messageType;

  String? get message => _message;

  num? get type => _type;

  String? get topicId => _topicId;

  String? get date => _date;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['image'] = _image;
    map['video'] = _video;
    map['audio'] = _audio;
    map['isRead'] = _isRead;
    map['senderId'] = _senderId;
    map['messageType'] = _messageType;
    map['message'] = _message;
    map['type'] = _type;
    map['topicId'] = _topicId;
    map['date'] = _date;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
