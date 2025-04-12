// To parse this JSON data, do
//
//     final getUserModel = getUserModelFromJson(jsonString);

import 'dart:convert';

GetUserModel getUserModelFromJson(String str) => GetUserModel.fromJson(json.decode(str));

String getUserModelToJson(GetUserModel data) => json.encode(data.toJson());

class GetUserModel {
  bool? status;
  String? message;
  FindUser? findUser;

  GetUserModel({
    this.status,
    this.message,
    this.findUser,
  });

  factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
    status: json["status"],
    message: json["message"],
    findUser: json["findUser"] == null ? null : FindUser.fromJson(json["findUser"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "findUser": findUser?.toJson(),
  };
}

class FindUser {
  Plan? plan;
  String? id;
  String? name;
  String? bio;
  String? email;
  String? password;
  dynamic token;
  dynamic channel;
  String? gender;
  String? dob;
  String? image;
  String? country;
  int? platformType;
  bool? isOnline;
  bool? isBusy;
  bool? isBlock;
  bool? isHost;
  bool? isSignup;
  bool? isCoinPlan;
  dynamic liveStreamingId;
  int? agoraUid;
  int? coin;
  int? purchasedCoin;
  dynamic mobileNumber;
  String? uniqueId;
  String? date;
  String? identity;
  int? loginType;
  String? fcmToken;
  String? lastLogin;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? age;

  FindUser({
    this.plan,
    this.id,
    this.name,
    this.bio,
    this.email,
    this.password,
    this.token,
    this.channel,
    this.gender,
    this.dob,
    this.image,
    this.country,
    this.platformType,
    this.isOnline,
    this.isBusy,
    this.isBlock,
    this.isHost,
    this.isSignup,
    this.isCoinPlan,
    this.liveStreamingId,
    this.agoraUid,
    this.coin,
    this.purchasedCoin,
    this.mobileNumber,
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

  factory FindUser.fromJson(Map<String, dynamic> json) => FindUser(
    plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
    id: json["_id"],
    name: json["name"],
    bio: json["bio"],
    email: json["email"],
    password: json["password"],
    token: json["token"],
    channel: json["channel"],
    gender: json["gender"],
    dob: json["dob"],
    image: json["image"],
    country: json["country"],
    platformType: json["platformType"],
    isOnline: json["isOnline"],
    isBusy: json["isBusy"],
    isBlock: json["isBlock"],
    isHost: json["isHost"],
    isSignup: json["isSignup"],
    isCoinPlan: json["isCoinPlan"],
    liveStreamingId: json["liveStreamingId"],
    agoraUid: json["agoraUid"],
    coin: json["coin"],
    purchasedCoin: json["purchasedCoin"],
    mobileNumber: json["mobileNumber"],
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
    "plan": plan?.toJson(),
    "_id": id,
    "name": name,
    "bio": bio,
    "email": email,
    "password": password,
    "token": token,
    "channel": channel,
    "gender": gender,
    "dob": dob,
    "image": image,
    "country": country,
    "platformType": platformType,
    "isOnline": isOnline,
    "isBusy": isBusy,
    "isBlock": isBlock,
    "isHost": isHost,
    "isSignup": isSignup,
    "isCoinPlan": isCoinPlan,
    "liveStreamingId": liveStreamingId,
    "agoraUid": agoraUid,
    "coin": coin,
    "purchasedCoin": purchasedCoin,
    "mobileNumber": mobileNumber,
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

class Plan {
  dynamic planStartDate;
  dynamic coinPlanId;

  Plan({
    this.planStartDate,
    this.coinPlanId,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    planStartDate: json["planStartDate"],
    coinPlanId: json["coinPlanId"],
  );

  Map<String, dynamic> toJson() => {
    "planStartDate": planStartDate,
    "coinPlanId": coinPlanId,
  };
}
