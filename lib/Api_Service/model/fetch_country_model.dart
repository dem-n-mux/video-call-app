import 'dart:convert';

FetchCountryModel fetchCountryModelFromJson(String str) =>
    FetchCountryModel.fromJson(json.decode(str));

String fetchCountryModelToJson(FetchCountryModel data) =>
    json.encode(data.toJson());

class FetchCountryModel {
  FetchCountryModel({
    String? status,
    String? country,
    String? countryCode,
    String? region,
    String? regionName,
    String? city,
    String? zip,
    num? lat,
    num? lon,
    String? timezone,
    String? isp,
    String? org,
    String? as,
    String? query,
  }) {
    _status = status;
    _country = country;
    _countryCode = countryCode;
    _region = region;
    _regionName = regionName;
    _city = city;
    _zip = zip;
    _lat = lat;
    _lon = lon;
    _timezone = timezone;
    _isp = isp;
    _org = org;
    _as = as;
    _query = query;
  }

  FetchCountryModel.fromJson(dynamic json) {
    _status = json['status'];
    _country = json['country'];
    _countryCode = json['countryCode'];
    _region = json['region'];
    _regionName = json['regionName'];
    _city = json['city'];
    _zip = json['zip'];
    _lat = json['lat'];
    _lon = json['lon'];
    _timezone = json['timezone'];
    _isp = json['isp'];
    _org = json['org'];
    _as = json['as'];
    _query = json['query'];
  }

  String? _status;
  String? _country;
  String? _countryCode;
  String? _region;
  String? _regionName;
  String? _city;
  String? _zip;
  num? _lat;
  num? _lon;
  String? _timezone;
  String? _isp;
  String? _org;
  String? _as;
  String? _query;

  FetchCountryModel copyWith({
    String? status,
    String? country,
    String? countryCode,
    String? region,
    String? regionName,
    String? city,
    String? zip,
    num? lat,
    num? lon,
    String? timezone,
    String? isp,
    String? org,
    String? as,
    String? query,
  }) =>
      FetchCountryModel(
        status: status ?? _status,
        country: country ?? _country,
        countryCode: countryCode ?? _countryCode,
        region: region ?? _region,
        regionName: regionName ?? _regionName,
        city: city ?? _city,
        zip: zip ?? _zip,
        lat: lat ?? _lat,
        lon: lon ?? _lon,
        timezone: timezone ?? _timezone,
        isp: isp ?? _isp,
        org: org ?? _org,
        as: as ?? _as,
        query: query ?? _query,
      );

  String? get status => _status;

  String? get country => _country;

  String? get countryCode => _countryCode;

  String? get region => _region;

  String? get regionName => _regionName;

  String? get city => _city;

  String? get zip => _zip;

  num? get lat => _lat;

  num? get lon => _lon;

  String? get timezone => _timezone;

  String? get isp => _isp;

  String? get org => _org;

  String? get as => _as;

  String? get query => _query;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['country'] = _country;
    map['countryCode'] = _countryCode;
    map['region'] = _region;
    map['regionName'] = _regionName;
    map['city'] = _city;
    map['zip'] = _zip;
    map['lat'] = _lat;
    map['lon'] = _lon;
    map['timezone'] = _timezone;
    map['isp'] = _isp;
    map['org'] = _org;
    map['as'] = _as;
    map['query'] = _query;
    return map;
  }
}
