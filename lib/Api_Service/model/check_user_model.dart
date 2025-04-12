// To parse this JSON data, do
//
//     final checkUserModel = checkUserModelFromJson(jsonString);

import 'dart:convert';

CheckUserModel checkUserModelFromJson(String str) => CheckUserModel.fromJson(json.decode(str));

String checkUserModelToJson(CheckUserModel data) => json.encode(data.toJson());

class CheckUserModel {
  bool? status;
  String? message;
  User? user;
  bool? isProfile;

  CheckUserModel({
    this.status,
    this.message,
    this.user,
    this.isProfile,
  });

  factory CheckUserModel.fromJson(Map<String, dynamic> json) => CheckUserModel(
    status: json["status"],
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    isProfile: json["isProfile"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "user": user?.toJson(),
    "isProfile": isProfile,
  };
}

class User {
  CurrentLocationCoordinates? currentLocationCoordinates;
  Plan? plan;
  String? id;
  String? name;
  String? bio;
  String? email;
  String? password;
  String? gender;
  // DateTime? dob;
  String? image;
  String? country;
  String? birthPlace;
  String? currentLocation;
  int? platformType;
  dynamic mobileNumber;
  bool? isOnline;
  bool? isBusy;
  bool? isBlock;
  bool? isHost;
  bool? isSignup;
  bool? isLive;
  dynamic token;
  dynamic channel;
  dynamic liveStreamingId;
  int? agoraUid;
  bool? isCoinPlan;
  int? coin;
  int? purchasedCoin;
  bool? isVip;
  bool? isPurchased;
  String? uniqueId;
  String? date;
  String? identity;
  int? loginType;
  String? fcmToken;
  String? lastLogin;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? age;

  User({
    this.currentLocationCoordinates,
    this.plan,
    this.id,
    this.name,
    this.bio,
    this.email,
    this.password,
    this.gender,
    // this.dob,
    this.image,
    this.country,
    this.birthPlace,
    this.currentLocation,
    this.platformType,
    this.mobileNumber,
    this.isOnline,
    this.isBusy,
    this.isBlock,
    this.isHost,
    this.isSignup,
    this.isLive,
    this.token,
    this.channel,
    this.liveStreamingId,
    this.agoraUid,
    this.isCoinPlan,
    this.coin,
    this.purchasedCoin,
    this.isVip,
    this.isPurchased,
    this.uniqueId,
    this.date,
    this.identity,
    this.loginType,
    this.fcmToken,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    currentLocationCoordinates: json["currentLocationCoordinates"] == null ? null : CurrentLocationCoordinates.fromJson(json["currentLocationCoordinates"]),
    plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
    id: json["_id"],
    name: json["name"],
    bio: json["bio"],
    email: json["email"],
    password: json["password"],
    gender: json["gender"],
    // dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    image: json["image"],
    country: json["country"],
    birthPlace: json["birthPlace"],
    currentLocation: json["currentLocation"],
    platformType: json["platformType"],
    mobileNumber: json["mobileNumber"],
    isOnline: json["isOnline"],
    isBusy: json["isBusy"],
    isBlock: json["isBlock"],
    isHost: json["isHost"],
    isSignup: json["isSignup"],
    isLive: json["isLive"],
    token: json["token"],
    channel: json["channel"],
    liveStreamingId: json["liveStreamingId"],
    agoraUid: json["agoraUid"],
    isCoinPlan: json["isCoinPlan"],
    coin: json["coin"],
    purchasedCoin: json["purchasedCoin"],
    isVip: json["isVIP"],
    isPurchased: json["isPurchased"],
    uniqueId: json["uniqueID"],
    date: json["date"],
    identity: json["identity"],
    loginType: json["loginType"],
    fcmToken: json["fcm_token"],
    lastLogin: json["lastLogin"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    age: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "currentLocationCoordinates": currentLocationCoordinates?.toJson(),
    "plan": plan?.toJson(),
    "_id": id,
    "name": name,
    "bio": bio,
    "email": email,
    "password": password,
    "gender": gender,
    // "dob": dob?.toIso8601String(),
    "image": image,
    "country": country,
    "birthPlace": birthPlace,
    "currentLocation": currentLocation,
    "platformType": platformType,
    "mobileNumber": mobileNumber,
    "isOnline": isOnline,
    "isBusy": isBusy,
    "isBlock": isBlock,
    "isHost": isHost,
    "isSignup": isSignup,
    "isLive": isLive,
    "token": token,
    "channel": channel,
    "liveStreamingId": liveStreamingId,
    "agoraUid": agoraUid,
    "isCoinPlan": isCoinPlan,
    "coin": coin,
    "purchasedCoin": purchasedCoin,
    "isVIP": isVip,
    "isPurchased": isPurchased,
    "uniqueID": uniqueId,
    "date": date,
    "identity": identity,
    "loginType": loginType,
    "fcm_token": fcmToken,
    "lastLogin": lastLogin,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "age": age,
  };
}

class CurrentLocationCoordinates {
  String? latitude;
  String? longitude;

  CurrentLocationCoordinates({
    this.latitude,
    this.longitude,
  });

  factory CurrentLocationCoordinates.fromJson(Map<String, dynamic> json) => CurrentLocationCoordinates(
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Plan {
  dynamic planStartDate;
  dynamic planId;

  Plan({
    this.planStartDate,
    this.planId,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    planStartDate: json["planStartDate"],
    planId: json["planId"],
  );

  Map<String, dynamic> toJson() => {
    "planStartDate": planStartDate,
    "planId": planId,
  };
}
