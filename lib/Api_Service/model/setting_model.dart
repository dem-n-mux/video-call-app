// To parse this JSON data, do
//
//     final settingModel = settingModelFromJson(jsonString);

import 'dart:convert';

SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel {
  bool? status;
  String? message;
  Setting? setting;

  SettingModel({
    this.status,
    this.message,
    this.setting,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
    status: json["status"],
    message: json["message"],
    setting: json["setting"] == null ? null : Setting.fromJson(json["setting"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "setting": setting?.toJson(),
  };
}

class Setting {
  bool? flutterWaveSwitch;
  String? flutterWaveId;
  String? id;
  String? agoraKey;
  String? agoraCertificate;
  String? privacyPolicyLink;
  String? privacyPolicyText;
  String? termAndCondition;
  String? googlePlayEmail;
  String? googlePlayKey;
  bool? googlePlaySwitch;
  bool? stripeSwitch;
  String? stripePublishableKey;
  String? stripeSecretKey;
  bool? isAppActive;
  String? welcomeMessage;
  String? razorPayId;
  bool? razorPaySwitch;
  String? razorSecretKey;
  int? chargeForRandomCall;
  int? chargeForPrivateCall;
  int? coinPerDollar;
  int? coinCharge;
  List<String>? paymentGateway;
  int? withdrawLimit;
  String? link;
  bool? isFake;
  PrivateKey? privateKey;
  String? redirectAppUrl;
  String? redirectMessage;

  Setting({
    this.flutterWaveSwitch,
    this.flutterWaveId,
    this.id,
    this.agoraKey,
    this.agoraCertificate,
    this.privacyPolicyLink,
    this.privacyPolicyText,
    this.termAndCondition,
    this.googlePlayEmail,
    this.googlePlayKey,
    this.googlePlaySwitch,
    this.stripeSwitch,
    this.stripePublishableKey,
    this.stripeSecretKey,
    this.isAppActive,
    this.welcomeMessage,
    this.razorPayId,
    this.razorPaySwitch,
    this.razorSecretKey,
    this.chargeForRandomCall,
    this.chargeForPrivateCall,
    this.coinPerDollar,
    this.coinCharge,
    this.paymentGateway,
    this.withdrawLimit,
    this.link,
    this.isFake,
    this.privateKey,
    this.redirectAppUrl,
    this.redirectMessage,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
    flutterWaveSwitch: json["flutterWaveSwitch"],
    flutterWaveId: json["flutterWaveId"],
    id: json["_id"],
    agoraKey: json["agoraKey"],
    agoraCertificate: json["agoraCertificate"],
    privacyPolicyLink: json["privacyPolicyLink"],
    privacyPolicyText: json["privacyPolicyText"],
    termAndCondition: json["termAndCondition"],
    googlePlayEmail: json["googlePlayEmail"],
    googlePlayKey: json["googlePlayKey"],
    googlePlaySwitch: json["googlePlaySwitch"],
    stripeSwitch: json["stripeSwitch"],
    stripePublishableKey: json["stripePublishableKey"],
    stripeSecretKey: json["stripeSecretKey"],
    isAppActive: json["isAppActive"],
    welcomeMessage: json["welcomeMessage"],
    razorPayId: json["razorPayId"],
    razorPaySwitch: json["razorPaySwitch"],
    razorSecretKey: json["razorSecretKey"],
    chargeForRandomCall: json["chargeForRandomCall"],
    chargeForPrivateCall: json["chargeForPrivateCall"],
    coinPerDollar: json["coinPerDollar"],
    coinCharge: json["coinCharge"],
    paymentGateway: json["paymentGateway"] == null ? [] : List<String>.from(json["paymentGateway"]!.map((x) => x)),
    withdrawLimit: json["withdrawLimit"],
    link: json["link"],
    isFake: json["isFake"],
    privateKey: json["privateKey"] == null ? null : PrivateKey.fromJson(json["privateKey"]),
    redirectAppUrl: json["redirectAppUrl"],
    redirectMessage: json["redirectMessage"],
  );

  Map<String, dynamic> toJson() => {
    "flutterWaveSwitch": flutterWaveSwitch,
    "flutterWaveId": flutterWaveId,
    "_id": id,
    "agoraKey": agoraKey,
    "agoraCertificate": agoraCertificate,
    "privacyPolicyLink": privacyPolicyLink,
    "privacyPolicyText": privacyPolicyText,
    "termAndCondition": termAndCondition,
    "googlePlayEmail": googlePlayEmail,
    "googlePlayKey": googlePlayKey,
    "googlePlaySwitch": googlePlaySwitch,
    "stripeSwitch": stripeSwitch,
    "stripePublishableKey": stripePublishableKey,
    "stripeSecretKey": stripeSecretKey,
    "isAppActive": isAppActive,
    "welcomeMessage": welcomeMessage,
    "razorPayId": razorPayId,
    "razorPaySwitch": razorPaySwitch,
    "razorSecretKey": razorSecretKey,
    "chargeForRandomCall": chargeForRandomCall,
    "chargeForPrivateCall": chargeForPrivateCall,
    "coinPerDollar": coinPerDollar,
    "coinCharge": coinCharge,
    "paymentGateway": paymentGateway == null ? [] : List<dynamic>.from(paymentGateway!.map((x) => x)),
    "withdrawLimit": withdrawLimit,
    "link": link,
    "isFake": isFake,
    "privateKey": privateKey?.toJson(),
    "redirectAppUrl": redirectAppUrl,
    "redirectMessage": redirectMessage,
  };
}

class PrivateKey {
  String? type;
  String? projectId;
  String? privateKeyId;
  String? privateKey;
  String? clientEmail;
  String? clientId;
  String? authUri;
  String? tokenUri;
  String? authProviderX509CertUrl;
  String? clientX509CertUrl;
  String? universeDomain;

  PrivateKey({
    this.type,
    this.projectId,
    this.privateKeyId,
    this.privateKey,
    this.clientEmail,
    this.clientId,
    this.authUri,
    this.tokenUri,
    this.authProviderX509CertUrl,
    this.clientX509CertUrl,
    this.universeDomain,
  });

  factory PrivateKey.fromJson(Map<String, dynamic> json) => PrivateKey(
    type: json["type"],
    projectId: json["project_id"],
    privateKeyId: json["private_key_id"],
    privateKey: json["private_key"],
    clientEmail: json["client_email"],
    clientId: json["client_id"],
    authUri: json["auth_uri"],
    tokenUri: json["token_uri"],
    authProviderX509CertUrl: json["auth_provider_x509_cert_url"],
    clientX509CertUrl: json["client_x509_cert_url"],
    universeDomain: json["universe_domain"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "project_id": projectId,
    "private_key_id": privateKeyId,
    "private_key": privateKey,
    "client_email": clientEmail,
    "client_id": clientId,
    "auth_uri": authUri,
    "token_uri": tokenUri,
    "auth_provider_x509_cert_url": authProviderX509CertUrl,
    "client_x509_cert_url": clientX509CertUrl,
    "universe_domain": universeDomain,
  };
}
