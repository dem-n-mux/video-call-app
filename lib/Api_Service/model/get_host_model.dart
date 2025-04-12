import 'dart:convert';
GetHostModel getHostModelFromJson(String str) => GetHostModel.fromJson(json.decode(str));
String getHostModelToJson(GetHostModel data) => json.encode(data.toJson());
class GetHostModel {
  GetHostModel({
      bool? status, 
      String? message, 
      Host? host,}){
    _status = status;
    _message = message;
    _host = host;
}

  GetHostModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _host = json['host'] != null ? Host.fromJson(json['host']) : null;
  }
  bool? _status;
  String? _message;
  Host? _host;
GetHostModel copyWith({  bool? status,
  String? message,
  Host? host,
}) => GetHostModel(  status: status ?? _status,
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
      dynamic mobileNumber, 
      String? uniqueID, 
      String? password, 
      String? token, 
      String? channel, 
      String? gender, 
      String? country, 
      int? coin, 
      String? dob, 
      String? image, 
      List<String>? album, 
      String? coverImage, 
      bool? isOnline, 
      bool? isBlock, 
      bool? isBusy, 
      bool? isLive, 
      bool? isHost, 
      bool? isConnect, 
      int? withdrawalCoin, 
      int? receiveCoin, 
      int? receiveGift, 
      int? callCharge, 
      String? liveStreamingId, 
      int? agoraUid, 
      int? age, 
      String? identity, 
      String? createdAt, 
      String? updatedAt, 
      String? date, 
      String? fcmToken, 
      String? lastLogin, 
      int? loginType, 
      int? platformType, 
      Rate? rate,}){
    _id = id;
    _name = name;
    _bio = bio;
    _email = email;
    _mobileNumber = mobileNumber;
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
    _isConnect = isConnect;
    _withdrawalCoin = withdrawalCoin;
    _receiveCoin = receiveCoin;
    _receiveGift = receiveGift;
    _callCharge = callCharge;
    _liveStreamingId = liveStreamingId;
    _agoraUid = agoraUid;
    _age = age;
    _identity = identity;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _date = date;
    _fcmToken = fcmToken;
    _lastLogin = lastLogin;
    _loginType = loginType;
    _platformType = platformType;
    _rate = rate;
}

  Host.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _bio = json['bio'];
    _email = json['email'];
    _mobileNumber = json['mobileNumber'];
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
    _isConnect = json['isConnect'];
    _withdrawalCoin = json['withdrawalCoin'];
    _receiveCoin = json['receiveCoin'];
    _receiveGift = json['receiveGift'];
    _callCharge = json['callCharge'];
    _liveStreamingId = json['liveStreamingId'];
    _agoraUid = json['agoraUid'];
    _age = json['age'];
    _identity = json['identity'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _date = json['date'];
    _fcmToken = json['fcm_token'];
    _lastLogin = json['lastLogin'];
    _loginType = json['loginType'];
    _platformType = json['platformType'];
    _rate = json['rate'] != null ? Rate.fromJson(json['rate']) : null;
  }
  String? _id;
  String? _name;
  String? _bio;
  String? _email;
  dynamic _mobileNumber;
  String? _uniqueID;
  String? _password;
  String? _token;
  String? _channel;
  String? _gender;
  String? _country;
  int? _coin;
  String? _dob;
  String? _image;
  List<String>? _album;
  String? _coverImage;
  bool? _isOnline;
  bool? _isBlock;
  bool? _isBusy;
  bool? _isLive;
  bool? _isHost;
  bool? _isConnect;
  int? _withdrawalCoin;
  int? _receiveCoin;
  int? _receiveGift;
  int? _callCharge;
  String? _liveStreamingId;
  int? _agoraUid;
  int? _age;
  String? _identity;
  String? _createdAt;
  String? _updatedAt;
  String? _date;
  String? _fcmToken;
  String? _lastLogin;
  int? _loginType;
  int? _platformType;
  Rate? _rate;
Host copyWith({  String? id,
  String? name,
  String? bio,
  String? email,
  dynamic mobileNumber,
  String? uniqueID,
  String? password,
  String? token,
  String? channel,
  String? gender,
  String? country,
  int? coin,
  String? dob,
  String? image,
  List<String>? album,
  String? coverImage,
  bool? isOnline,
  bool? isBlock,
  bool? isBusy,
  bool? isLive,
  bool? isHost,
  bool? isConnect,
  int? withdrawalCoin,
  int? receiveCoin,
  int? receiveGift,
  int? callCharge,
  String? liveStreamingId,
  int? agoraUid,
  int? age,
  String? identity,
  String? createdAt,
  String? updatedAt,
  String? date,
  String? fcmToken,
  String? lastLogin,
  int? loginType,
  int? platformType,
  Rate? rate,
}) => Host(  id: id ?? _id,
  name: name ?? _name,
  bio: bio ?? _bio,
  email: email ?? _email,
  mobileNumber: mobileNumber ?? _mobileNumber,
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
  isConnect: isConnect ?? _isConnect,
  withdrawalCoin: withdrawalCoin ?? _withdrawalCoin,
  receiveCoin: receiveCoin ?? _receiveCoin,
  receiveGift: receiveGift ?? _receiveGift,
  callCharge: callCharge ?? _callCharge,
  liveStreamingId: liveStreamingId ?? _liveStreamingId,
  agoraUid: agoraUid ?? _agoraUid,
  age: age ?? _age,
  identity: identity ?? _identity,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  date: date ?? _date,
  fcmToken: fcmToken ?? _fcmToken,
  lastLogin: lastLogin ?? _lastLogin,
  loginType: loginType ?? _loginType,
  platformType: platformType ?? _platformType,
  rate: rate ?? _rate,
);
  String? get id => _id;
  String? get name => _name;
  String? get bio => _bio;
  String? get email => _email;
  dynamic get mobileNumber => _mobileNumber;
  String? get uniqueID => _uniqueID;
  String? get password => _password;
  String? get token => _token;
  String? get channel => _channel;
  String? get gender => _gender;
  String? get country => _country;
  int? get coin => _coin;
  String? get dob => _dob;
  String? get image => _image;
  List<String>? get album => _album;
  String? get coverImage => _coverImage;
  bool? get isOnline => _isOnline;
  bool? get isBlock => _isBlock;
  bool? get isBusy => _isBusy;
  bool? get isLive => _isLive;
  bool? get isHost => _isHost;
  bool? get isConnect => _isConnect;
  int? get withdrawalCoin => _withdrawalCoin;
  int? get receiveCoin => _receiveCoin;
  int? get receiveGift => _receiveGift;
  int? get callCharge => _callCharge;
  String? get liveStreamingId => _liveStreamingId;
  int? get agoraUid => _agoraUid;
  int? get age => _age;
  String? get identity => _identity;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get date => _date;
  String? get fcmToken => _fcmToken;
  String? get lastLogin => _lastLogin;
  int? get loginType => _loginType;
  int? get platformType => _platformType;
  Rate? get rate => _rate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['bio'] = _bio;
    map['email'] = _email;
    map['mobileNumber'] = _mobileNumber;
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
    map['isConnect'] = _isConnect;
    map['withdrawalCoin'] = _withdrawalCoin;
    map['receiveCoin'] = _receiveCoin;
    map['receiveGift'] = _receiveGift;
    map['callCharge'] = _callCharge;
    map['liveStreamingId'] = _liveStreamingId;
    map['agoraUid'] = _agoraUid;
    map['age'] = _age;
    map['identity'] = _identity;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['date'] = _date;
    map['fcm_token'] = _fcmToken;
    map['lastLogin'] = _lastLogin;
    map['loginType'] = _loginType;
    map['platformType'] = _platformType;
    if (_rate != null) {
      map['rate'] = _rate?.toJson();
    }
    return map;
  }

}

Rate rateFromJson(String str) => Rate.fromJson(json.decode(str));
String rateToJson(Rate data) => json.encode(data.toJson());
class Rate {
  Rate({
      int? count, 
      int? rate, 
      double? total,}){
    _count = count;
    _rate = rate;
    _total = total;
}

  Rate.fromJson(dynamic json) {
    _count = json['count'];
    _rate = json['rate'];
    _total = json['total'];
  }
  int? _count;
  int? _rate;
  double? _total;
Rate copyWith({  int? count,
  int? rate,
  double? total,
}) => Rate(  count: count ?? _count,
  rate: rate ?? _rate,
  total: total ?? _total,
);
  int? get count => _count;
  int? get rate => _rate;
  double? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    map['rate'] = _rate;
    map['total'] = _total;
    return map;
  }

}