import 'dart:convert';

HostStatusModel hostStatusModelFromJson(String str) => HostStatusModel.fromJson(json.decode(str));
String hostStatusModelToJson(HostStatusModel data) => json.encode(data.toJson());
class HostStatusModel {
  HostStatusModel({
      bool? status, 
      String? message, 
      Host? host,}){
    _status = status;
    _message = message;
    _host = host;
}

  HostStatusModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _host = json['host'] != null ? Host.fromJson(json['host']) : null;
  }
  bool? _status;
  String? _message;
  Host? _host;
HostStatusModel copyWith({  bool? status,
  String? message,
  Host? host,
}) => HostStatusModel(  status: status ?? _status,
  message: message ?? _message,
  host: host ?? _host,
);
  bool? get status => _status;
  String? get message => _message;
  Host? get host => _host;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_host != null) {
      map['host'] = _host?.toJson();
    }
    return map;
  }

}


Host hostFromJson(String str) => Host.fromJson(json.decode(str));
String hostToJson(Host data) => json.encode(data.toJson());
class Host {
  Host({
      String? id, 
      String? name, 
      String? bio, 
      String? email, 
      String? uniqueID, 
      String? password, 
      dynamic token, 
      dynamic channel, 
      String? gender, 
      String? country, 
      num? coin, 
      String? dob, 
      String? image, 
      List<String>? album, 
      String? coverImage, 
      bool? isOnline, 
      bool? isBlock, 
      bool? isBusy, 
      bool? isLive, 
      bool? isHost, 
      bool? connect, 
      num? age, 
      String? identity, 
      String? createdAt, 
      String? updatedAt, 
      String? fcmToken, 
      String? lastLogin, 
      num? loginType, 
      num? platformType,}){
    _id = id;
    _name = name;
    _bio = bio;
    _email = email;
    _uniqueID = uniqueID;
    _password = password;
    _token = token;
    _channel = channel;
    _gender = gender;
    _country = country;
    _coin = coin;
    _dob = dob;
    _image = image;
    _album = album;
    _coverImage = coverImage;
    _isOnline = isOnline;
    _isBlock = isBlock;
    _isBusy = isBusy;
    _isLive = isLive;
    _isHost = isHost;
    _connect = connect;
    _age = age;
    _identity = identity;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _fcmToken = fcmToken;
    _lastLogin = lastLogin;
    _loginType = loginType;
    _platformType = platformType;
}

  Host.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _bio = json['bio'];
    _email = json['email'];
    _uniqueID = json['uniqueID'];
    _password = json['password'];
    _token = json['token'];
    _channel = json['channel'];
    _gender = json['gender'];
    _country = json['country'];
    _coin = json['coin'];
    _dob = json['dob'];
    _image = json['image'];
    _album = json['album'] != null ? json['album'].cast<String>() : [];
    _coverImage = json['coverImage'];
    _isOnline = json['isOnline'];
    _isBlock = json['isBlock'];
    _isBusy = json['isBusy'];
    _isLive = json['isLive'];
    _isHost = json['isHost'];
    _connect = json['connect'];
    _age = json['age'];
    _identity = json['identity'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _fcmToken = json['fcm_token'];
    _lastLogin = json['lastLogin'];
    _loginType = json['loginType'];
    _platformType = json['platformType'];
  }
  String? _id;
  String? _name;
  String? _bio;
  String? _email;
  String? _uniqueID;
  String? _password;
  dynamic _token;
  dynamic _channel;
  String? _gender;
  String? _country;
  num? _coin;
  String? _dob;
  String? _image;
  List<String>? _album;
  String? _coverImage;
  bool? _isOnline;
  bool? _isBlock;
  bool? _isBusy;
  bool? _isLive;
  bool? _isHost;
  bool? _connect;
  num? _age;
  String? _identity;
  String? _createdAt;
  String? _updatedAt;
  String? _fcmToken;
  String? _lastLogin;
  num? _loginType;
  num? _platformType;
Host copyWith({  String? id,
  String? name,
  String? bio,
  String? email,
  String? uniqueID,
  String? password,
  dynamic token,
  dynamic channel,
  String? gender,
  String? country,
  num? coin,
  String? dob,
  String? image,
  List<String>? album,
  String? coverImage,
  bool? isOnline,
  bool? isBlock,
  bool? isBusy,
  bool? isLive,
  bool? isHost,
  bool? connect,
  num? age,
  String? identity,
  String? createdAt,
  String? updatedAt,
  String? fcmToken,
  String? lastLogin,
  num? loginType,
  num? platformType,
}) => Host(  id: id ?? _id,
  name: name ?? _name,
  bio: bio ?? _bio,
  email: email ?? _email,
  uniqueID: uniqueID ?? _uniqueID,
  password: password ?? _password,
  token: token ?? _token,
  channel: channel ?? _channel,
  gender: gender ?? _gender,
  country: country ?? _country,
  coin: coin ?? _coin,
  dob: dob ?? _dob,
  image: image ?? _image,
  album: album ?? _album,
  coverImage: coverImage ?? _coverImage,
  isOnline: isOnline ?? _isOnline,
  isBlock: isBlock ?? _isBlock,
  isBusy: isBusy ?? _isBusy,
  isLive: isLive ?? _isLive,
  isHost: isHost ?? _isHost,
  connect: connect ?? _connect,
  age: age ?? _age,
  identity: identity ?? _identity,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  fcmToken: fcmToken ?? _fcmToken,
  lastLogin: lastLogin ?? _lastLogin,
  loginType: loginType ?? _loginType,
  platformType: platformType ?? _platformType,
);
  String? get id => _id;
  String? get name => _name;
  String? get bio => _bio;
  String? get email => _email;
  String? get uniqueID => _uniqueID;
  String? get password => _password;
  dynamic get token => _token;
  dynamic get channel => _channel;
  String? get gender => _gender;
  String? get country => _country;
  num? get coin => _coin;
  String? get dob => _dob;
  String? get image => _image;
  List<String>? get album => _album;
  String? get coverImage => _coverImage;
  bool? get isOnline => _isOnline;
  bool? get isBlock => _isBlock;
  bool? get isBusy => _isBusy;
  bool? get isLive => _isLive;
  bool? get isHost => _isHost;
  bool? get connect => _connect;
  num? get age => _age;
  String? get identity => _identity;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get fcmToken => _fcmToken;
  String? get lastLogin => _lastLogin;
  num? get loginType => _loginType;
  num? get platformType => _platformType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['bio'] = _bio;
    map['email'] = _email;
    map['uniqueID'] = _uniqueID;
    map['password'] = _password;
    map['token'] = _token;
    map['channel'] = _channel;
    map['gender'] = _gender;
    map['country'] = _country;
    map['coin'] = _coin;
    map['dob'] = _dob;
    map['image'] = _image;
    map['album'] = _album;
    map['coverImage'] = _coverImage;
    map['isOnline'] = _isOnline;
    map['isBlock'] = _isBlock;
    map['isBusy'] = _isBusy;
    map['isLive'] = _isLive;
    map['isHost'] = _isHost;
    map['connect'] = _connect;
    map['age'] = _age;
    map['identity'] = _identity;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['fcm_token'] = _fcmToken;
    map['lastLogin'] = _lastLogin;
    map['loginType'] = _loginType;
    map['platformType'] = _platformType;
    return map;
  }

}