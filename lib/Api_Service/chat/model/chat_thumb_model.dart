import 'dart:convert';

ChatThumbModel chatThumbModelFromJson(String str) =>
    ChatThumbModel.fromJson(json.decode(str));

String chatThumbModelToJson(ChatThumbModel data) => json.encode(data.toJson());

class ChatThumbModel {
  ChatThumbModel({
    bool? status,
    String? message,
    List<ChatList>? chatList,
    num? size,
  }) {
    _status = status;
    _message = message;
    _chatList = chatList;
    _size = size;
  }

  ChatThumbModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['chatList'] != null) {
      _chatList = [];
      json['chatList'].forEach((v) {
        _chatList?.add(ChatList.fromJson(v));
      });
    }
    _size = json['size'];
  }

  bool? _status;
  String? _message;
  List<ChatList>? _chatList;
  num? _size;

  ChatThumbModel copyWith({
    bool? status,
    String? message,
    List<ChatList>? chatList,
    num? size,
  }) =>
      ChatThumbModel(
        status: status ?? _status,
        message: message ?? _message,
        chatList: chatList ?? _chatList,
        size: size ?? _size,
      );

  bool? get status => _status;

  String? get message => _message;

  List<ChatList>? get chatList => _chatList;

  num? get size => _size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_chatList != null) {
      map['chatList'] = _chatList?.map((v) => v.toJson()).toList();
    }
    map['size'] = _size;
    return map;
  }
}

ChatList chatListFromJson(String str) => ChatList.fromJson(json.decode(str));

String chatListToJson(ChatList data) => json.encode(data.toJson());

class ChatList {
  ChatList({
    num? total,
    String? topic,
    String? message,
    String? date,
    String? chatDate,
    String? name,
    String? bio,
    String? image,
    String? country,
    String? video,
    bool? isOnline,
    bool? isFake,
    num? count,
    String? id,
    String? time,
  }) {
    _total = total;
    _topic = topic;
    _message = message;
    _date = date;
    _chatDate = chatDate;
    _name = name;
    _bio = bio;
    _image = image;
    _country = country;
    _video = video;
    _isOnline = isOnline;
    _isFake= isFake;
    _count = count;
    _id = id;
    _time = time;
  }

  ChatList.fromJson(dynamic json) {
    _total = json['total'];
    _topic = json['topic'];
    _message = json['message'];
    _date = json['date'];
    _chatDate = json['chatDate'];
    _name = json['name'];
    _bio = json['bio'];
    _image = json['image'];
    _country = json['country'];
    _video = json['video'];
    _isOnline = json['isOnline'];
    _isFake = json['isFake'];
    _count = json['count'];
    _id = json['id'];
    _time = json['time'];
  }

  num? _total;
  String? _topic;
  String? _message;
  String? _date;
  String? _chatDate;
  String? _name;
  String? _bio;
  String? _image;
  String? _country;
  String? _video;
  bool? _isOnline;
  bool? _isFake;
  num? _count;
  String? _id;
  String? _time;

  ChatList copyWith({
    num? total,
    String? topic,
    String? message,
    String? date,
    String? chatDate,
    String? name,
    String? bio,
    String? image,
    String? country,
    String? video,
    bool? isOnline,
    bool? isFake,
    num? count,
    String? id,
    String? time,
  }) =>
      ChatList(
        total: total ?? _total,
        topic: topic ?? _topic,
        message: message ?? _message,
        date: date ?? _date,
        chatDate: chatDate ?? _chatDate,
        name: name ?? _name,
        bio: bio ?? _bio,
        image: image ?? _image,
        country: country ?? _country,
        video: video ?? _video,
        isOnline: isOnline ?? _isOnline,
        isFake: isFake ?? _isFake,
        count: count ?? _count,
        id: id ?? _id,
        time: time ?? _time,
      );

  num? get total => _total;

  String? get topic => _topic;

  String? get message => _message;

  String? get date => _date;

  String? get chatDate => _chatDate;

  String? get name => _name;

  String? get bio => _bio;

  String? get image => _image;

  String? get country => _country;
  String? get video => _video;

  bool? get isOnline => _isOnline;
  bool? get isFake => _isFake;

  num? get count => _count;

  String? get id => _id;

  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['topic'] = _topic;
    map['message'] = _message;
    map['date'] = _date;
    map['chatDate'] = _chatDate;
    map['name'] = _name;
    map['bio'] = _bio;
    map['image'] = _image;
    map['country'] = _country;
    map['video'] = _video;
    map['isOnline'] = _isOnline;
    map['isFake'] = _isFake;
    map['count'] = _count;
    map['id'] = _id;
    map['time'] = _time;
    return map;
  }
}
