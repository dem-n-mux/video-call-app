import 'dart:convert';

GetCoinPlanModel getCoinPlanModelFromJson(String str) =>
    GetCoinPlanModel.fromJson(json.decode(str));

String getCoinPlanModelToJson(GetCoinPlanModel data) =>
    json.encode(data.toJson());

class GetCoinPlanModel {
  GetCoinPlanModel({
    bool? status,
    String? message,
    List<CoinPlan>? coinPlan,
  }) {
    _status = status;
    _message = message;
    _coinPlan = coinPlan;
  }

  GetCoinPlanModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['coinPlan'] != null) {
      _coinPlan = [];
      json['coinPlan'].forEach((v) {
        _coinPlan?.add(CoinPlan.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<CoinPlan>? _coinPlan;

  GetCoinPlanModel copyWith({
    bool? status,
    String? message,
    List<CoinPlan>? coinPlan,
  }) =>
      GetCoinPlanModel(
        status: status ?? _status,
        message: message ?? _message,
        coinPlan: coinPlan ?? _coinPlan,
      );

  bool? get status => _status;

  String? get message => _message;

  List<CoinPlan>? get coinPlan => _coinPlan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_coinPlan != null) {
      map['coinPlan'] = _coinPlan?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

CoinPlan coinPlanFromJson(String str) => CoinPlan.fromJson(json.decode(str));

String coinPlanToJson(CoinPlan data) => json.encode(data.toJson());

class CoinPlan {
  CoinPlan({
    String? id,
    num? extraCoin,
    num? planLevel,
    num? platFormType,
    bool? isActive,
    num? coin,
    num? dollar,
    String? productKey,
    String? tag,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _extraCoin = extraCoin;
    _planLevel = planLevel;
    _platFormType = platFormType;
    _isActive = isActive;
    _coin = coin;
    _dollar = dollar;
    _productKey = productKey;
    _tag = tag;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  CoinPlan.fromJson(dynamic json) {
    _id = json['_id'];
    _extraCoin = json['extraCoin'];
    _planLevel = json['planLevel'];
    _platFormType = json['platFormType'];
    _isActive = json['isActive'];
    _coin = json['coin'];
    _dollar = json['dollar'];
    _productKey = json['productKey'];
    _tag = json['tag'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  num? _extraCoin;
  num? _planLevel;
  num? _platFormType;
  bool? _isActive;
  num? _coin;
  num? _dollar;
  String? _productKey;
  String? _tag;
  String? _createdAt;
  String? _updatedAt;

  CoinPlan copyWith({
    String? id,
    num? extraCoin,
    num? planLevel,
    num? platFormType,
    bool? isActive,
    num? coin,
    num? dollar,
    String? productKey,
    String? tag,
    String? createdAt,
    String? updatedAt,
  }) =>
      CoinPlan(
        id: id ?? _id,
        extraCoin: extraCoin ?? _extraCoin,
        planLevel: planLevel ?? _planLevel,
        platFormType: platFormType ?? _platFormType,
        isActive: isActive ?? _isActive,
        coin: coin ?? _coin,
        dollar: dollar ?? _dollar,
        productKey: productKey ?? _productKey,
        tag: tag ?? _tag,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;

  num? get extraCoin => _extraCoin;

  num? get planLevel => _planLevel;

  num? get platFormType => _platFormType;

  bool? get isActive => _isActive;

  num? get coin => _coin;

  num? get dollar => _dollar;

  String? get productKey => _productKey;

  String? get tag => _tag;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['extraCoin'] = _extraCoin;
    map['planLevel'] = _planLevel;
    map['platFormType'] = _platFormType;
    map['isActive'] = _isActive;
    map['coin'] = _coin;
    map['dollar'] = _dollar;
    map['productKey'] = _productKey;
    map['tag'] = _tag;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
