import 'dart:convert';

FetchUserModel fetchUserModelFromJson(String str) =>
    FetchUserModel.fromJson(json.decode(str));

String fetchUserModelToJson(FetchUserModel data) => json.encode(data.toJson());

class FetchUserModel {
  FetchUserModel({
    bool? status,
    String? message,
    User? user,
  }) {
    _status = status;
    _message = message;
    _user = user;
  }

  FetchUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  bool? _status;
  String? _message;
  User? _user;

  FetchUserModel copyWith({
    bool? status,
    String? message,
    User? user,
  }) =>
      FetchUserModel(
        status: status ?? _status,
        message: message ?? _message,
        user: user ?? _user,
      );

  bool? get status => _status;

  String? get message => _message;

  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    num? age,
    String? id,
    String? name,
    String? bio,
    String? email,
    String? password,
    dynamic token,
    dynamic channel,
    String? gender,
    String? dob,
    String? image,
    String? country,
    num? platformType,
    num? coin,
    bool? isOnline,
    bool? isBusy,
    bool? isBlock,
    bool? isHost,
    bool? isSignup,
    String? uniqueID,
    String? identity,
    String? fcmToken,
    String? lastLogin,
    String? createdAt,
    String? updatedAt,
  }) {
    _age = age;
    _id = id;
    _name = name;
    _bio = bio;
    _email = email;
    _password = password;
    _token = token;
    _channel = channel;
    _gender = gender;
    _dob = dob;
    _image = image;
    _country = country;
    _platformType = platformType;
    _coin = coin;
    _isOnline = isOnline;
    _isBusy = isBusy;
    _isBlock = isBlock;
    _isHost = isHost;
    _isSignup = isSignup;
    _uniqueID = uniqueID;
    _identity = identity;
    _fcmToken = fcmToken;
    _lastLogin = lastLogin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  User.fromJson(dynamic json) {
    _age = json['age'];
    _id = json['_id'];
    _name = json['name'];
    _bio = json['bio'];
    _email = json['email'];
    _password = json['password'];
    _token = json['token'];
    _channel = json['channel'];
    _gender = json['gender'];
    _dob = json['dob'];
    _image = json['image'];
    _country = json['country'];
    _platformType = json['platformType'];
    _coin = json['coin'];
    _isOnline = json['isOnline'];
    _isBusy = json['isBusy'];
    _isBlock = json['isBlock'];
    _isHost = json['isHost'];
    _isSignup = json['isSignup'];
    _uniqueID = json['uniqueID'];
    _identity = json['identity'];
    _fcmToken = json['fcm_token'];
    _lastLogin = json['lastLogin'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  num? _age;
  String? _id;
  String? _name;
  String? _bio;
  String? _email;
  String? _password;
  dynamic _token;
  dynamic _channel;
  String? _gender;
  String? _dob;
  String? _image;
  String? _country;
  num? _platformType;
  num? _coin;
  bool? _isOnline;
  bool? _isBusy;
  bool? _isBlock;
  bool? _isHost;
  bool? _isSignup;
  String? _uniqueID;
  String? _identity;
  String? _fcmToken;
  String? _lastLogin;
  String? _createdAt;
  String? _updatedAt;

  User copyWith({
    num? age,
    String? id,
    String? name,
    String? bio,
    String? email,
    String? password,
    dynamic token,
    dynamic channel,
    String? gender,
    String? dob,
    String? image,
    String? country,
    num? platformType,
    num? coin,
    bool? isOnline,
    bool? isBusy,
    bool? isBlock,
    bool? isHost,
    bool? isSignup,
    String? uniqueID,
    String? identity,
    String? fcmToken,
    String? lastLogin,
    String? createdAt,
    String? updatedAt,
  }) =>
      User(
        age: age ?? _age,
        id: id ?? _id,
        name: name ?? _name,
        bio: bio ?? _bio,
        email: email ?? _email,
        password: password ?? _password,
        token: token ?? _token,
        channel: channel ?? _channel,
        gender: gender ?? _gender,
        dob: dob ?? _dob,
        image: image ?? _image,
        country: country ?? _country,
        platformType: platformType ?? _platformType,
        coin: coin ?? _coin,
        isOnline: isOnline ?? _isOnline,
        isBusy: isBusy ?? _isBusy,
        isBlock: isBlock ?? _isBlock,
        isHost: isHost ?? _isHost,
        isSignup: isSignup ?? _isSignup,
        uniqueID: uniqueID ?? _uniqueID,
        identity: identity ?? _identity,
        fcmToken: fcmToken ?? _fcmToken,
        lastLogin: lastLogin ?? _lastLogin,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get age => _age;

  String? get id => _id;

  String? get name => _name;

  String? get bio => _bio;

  String? get email => _email;

  String? get password => _password;

  dynamic get token => _token;

  dynamic get channel => _channel;

  String? get gender => _gender;

  String? get dob => _dob;

  String? get image => _image;

  String? get country => _country;

  num? get platformType => _platformType;

  num? get coin => _coin;

  bool? get isOnline => _isOnline;

  bool? get isBusy => _isBusy;

  bool? get isBlock => _isBlock;

  bool? get isHost => _isHost;

  bool? get isSignup => _isSignup;

  String? get uniqueID => _uniqueID;

  String? get identity => _identity;

  String? get fcmToken => _fcmToken;

  String? get lastLogin => _lastLogin;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['age'] = _age;
    map['_id'] = _id;
    map['name'] = _name;
    map['bio'] = _bio;
    map['email'] = _email;
    map['password'] = _password;
    map['token'] = _token;
    map['channel'] = _channel;
    map['gender'] = _gender;
    map['dob'] = _dob;
    map['image'] = _image;
    map['country'] = _country;
    map['platformType'] = _platformType;
    map['coin'] = _coin;
    map['isOnline'] = _isOnline;
    map['isBusy'] = _isBusy;
    map['isBlock'] = _isBlock;
    map['isHost'] = _isHost;
    map['isSignup'] = _isSignup;
    map['uniqueID'] = _uniqueID;
    map['identity'] = _identity;
    map['fcm_token'] = _fcmToken;
    map['lastLogin'] = _lastLogin;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
