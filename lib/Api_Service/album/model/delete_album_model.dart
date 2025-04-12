import 'dart:convert';

DeleteAlbumModel deleteAlbumModelFromJson(String str) =>
    DeleteAlbumModel.fromJson(json.decode(str));

String deleteAlbumModelToJson(DeleteAlbumModel data) =>
    json.encode(data.toJson());

class DeleteAlbumModel {
  DeleteAlbumModel({
    bool? status,
    String? message,
    Host? host,
  }) {
    _status = status;
    _message = message;
    _host = host;
  }

  DeleteAlbumModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _host = json['host'] != null ? Host.fromJson(json['host']) : null;
  }

  bool? _status;
  String? _message;
  Host? _host;

  DeleteAlbumModel copyWith({
    bool? status,
    String? message,
    Host? host,
  }) =>
      DeleteAlbumModel(
        status: status ?? _status,
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
    bool? isConnect,
    num? withdrawalCoin,
    num? receiveCoin,
    num? receiveGift,
    num? callCharge,
    dynamic liveStreamingId,
    num? agoraUid,
    num? age,
    String? identity,
    String? createdAt,
    String? updatedAt,
    String? fcmToken,
    String? lastLogin,
    num? loginType,
    String? date,
    num? platformType,
  }) {
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
    _fcmToken = fcmToken;
    _lastLogin = lastLogin;
    _loginType = loginType;
    _date = date;
    _platformType = platformType;
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
    _fcmToken = json['fcm_token'];
    _lastLogin = json['lastLogin'];
    _loginType = json['loginType'];
    _date = json['date'];
    _platformType = json['platformType'];
  }

  String? _id;
  String? _name;
  String? _bio;
  String? _email;
  dynamic _mobileNumber;
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
  bool? _isConnect;
  num? _withdrawalCoin;
  num? _receiveCoin;
  num? _receiveGift;
  num? _callCharge;
  dynamic _liveStreamingId;
  num? _agoraUid;
  num? _age;
  String? _identity;
  String? _createdAt;
  String? _updatedAt;
  String? _fcmToken;
  String? _lastLogin;
  num? _loginType;
  String? _date;
  num? _platformType;

  Host copyWith({
    String? id,
    String? name,
    String? bio,
    String? email,
    dynamic mobileNumber,
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
    bool? isConnect,
    num? withdrawalCoin,
    num? receiveCoin,
    num? receiveGift,
    num? callCharge,
    dynamic liveStreamingId,
    num? agoraUid,
    num? age,
    String? identity,
    String? createdAt,
    String? updatedAt,
    String? fcmToken,
    String? lastLogin,
    num? loginType,
    String? date,
    num? platformType,
  }) =>
      Host(
        id: id ?? _id,
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
        fcmToken: fcmToken ?? _fcmToken,
        lastLogin: lastLogin ?? _lastLogin,
        loginType: loginType ?? _loginType,
        date: date ?? _date,
        platformType: platformType ?? _platformType,
      );

  String? get id => _id;

  String? get name => _name;

  String? get bio => _bio;

  String? get email => _email;

  dynamic get mobileNumber => _mobileNumber;

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

  bool? get isConnect => _isConnect;

  num? get withdrawalCoin => _withdrawalCoin;

  num? get receiveCoin => _receiveCoin;

  num? get receiveGift => _receiveGift;

  num? get callCharge => _callCharge;

  dynamic get liveStreamingId => _liveStreamingId;

  num? get agoraUid => _agoraUid;

  num? get age => _age;

  String? get identity => _identity;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get fcmToken => _fcmToken;

  String? get lastLogin => _lastLogin;

  num? get loginType => _loginType;

  String? get date => _date;

  num? get platformType => _platformType;

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
    map['fcm_token'] = _fcmToken;
    map['lastLogin'] = _lastLogin;
    map['loginType'] = _loginType;
    map['date'] = _date;
    map['platformType'] = _platformType;
    return map;
  }
}
