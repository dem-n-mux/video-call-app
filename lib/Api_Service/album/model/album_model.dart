import 'dart:convert';

AlbumModel albumModelFromJson(String str) =>
    AlbumModel.fromJson(json.decode(str));

String albumModelToJson(AlbumModel data) => json.encode(data.toJson());

class AlbumModel {
  AlbumModel({
    bool? status,
    String? message,
    List<String>? imageData,
  }) {
    _status = status;
    _message = message;
    _imageData = imageData;
  }

  AlbumModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _imageData =
        json['imageData'] != null ? json['imageData'].cast<String>() : [];
  }

  bool? _status;
  String? _message;
  List<String>? _imageData;

  AlbumModel copyWith({
    bool? status,
    String? message,
    List<String>? imageData,
  }) =>
      AlbumModel(
        status: status ?? _status,
        message: message ?? _message,
        imageData: imageData ?? _imageData,
      );

  bool? get status => _status;

  String? get message => _message;

  List<String>? get imageData => _imageData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['imageData'] = _imageData;
    return map;
  }
}
