import 'dart:convert';

CreateChatModel createChatModelFromJson(String str) =>
    CreateChatModel.fromJson(json.decode(str));

String createChatModelToJson(CreateChatModel data) =>
    json.encode(data.toJson());

class CreateChatModel {
  CreateChatModel({
    bool? status,
    String? message,
    Chat? chat,
  }) {
    _status = status;
    _message = message;
    _chat = chat;
  }

  CreateChatModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _chat = json['chat'] != null ? Chat.fromJson(json['chat']) : null;
  }

  bool? _status;
  String? _message;
  Chat? _chat;

  CreateChatModel copyWith({
    bool? status,
    String? message,
    Chat? chat,
  }) =>
      CreateChatModel(
        status: status ?? _status,
        message: message ?? _message,
        chat: chat ?? _chat,
      );

  bool? get status => _status;

  String? get message => _message;

  Chat? get chat => _chat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_chat != null) {
      map['chat'] = _chat?.toJson();
    }
    return map;
  }
}

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  Chat({
    dynamic image,
    dynamic video,
    dynamic audio,
    bool? isRead,
    String? id,
    String? senderId,
    num? type,
    String? date,
    String? createdAt,
    String? updatedAt,
  }) {
    _image = image;
    _video = video;
    _audio = audio;
    _isRead = isRead;
    _id = id;
    _senderId = senderId;
    _type = type;
    _date = date;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Chat.fromJson(dynamic json) {
    _image = json['image'];
    _video = json['video'];
    _audio = json['audio'];
    _isRead = json['isRead'];
    _id = json['_id'];
    _senderId = json['senderId'];
    _type = json['type'];
    _date = json['date'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  dynamic _image;
  dynamic _video;
  dynamic _audio;
  bool? _isRead;
  String? _id;
  String? _senderId;
  num? _type;
  String? _date;
  String? _createdAt;
  String? _updatedAt;

  Chat copyWith({
    dynamic image,
    dynamic video,
    dynamic audio,
    bool? isRead,
    String? id,
    String? senderId,
    num? type,
    String? date,
    String? createdAt,
    String? updatedAt,
  }) =>
      Chat(
        image: image ?? _image,
        video: video ?? _video,
        audio: audio ?? _audio,
        isRead: isRead ?? _isRead,
        id: id ?? _id,
        senderId: senderId ?? _senderId,
        type: type ?? _type,
        date: date ?? _date,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  dynamic get image => _image;

  dynamic get video => _video;

  dynamic get audio => _audio;

  bool? get isRead => _isRead;

  String? get id => _id;

  String? get senderId => _senderId;

  num? get type => _type;

  String? get date => _date;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = _image;
    map['video'] = _video;
    map['audio'] = _audio;
    map['isRead'] = _isRead;
    map['_id'] = _id;
    map['senderId'] = _senderId;
    map['type'] = _type;
    map['date'] = _date;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
