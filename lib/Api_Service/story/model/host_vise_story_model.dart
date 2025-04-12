import 'dart:convert';

HostViseStoryModel hostViseStoryModelFromJson(String str) => HostViseStoryModel.fromJson(json.decode(str));
String hostViseStoryModelToJson(HostViseStoryModel data) => json.encode(data.toJson());
class HostViseStoryModel {
  HostViseStoryModel({
      bool? status, 
      String? message, 
      List<Story>? story,}){
    _status = status;
    _message = message;
    _story = story;
}

  HostViseStoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['story'] != null) {
      _story = [];
      json['story'].forEach((v) {
        _story?.add(Story.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Story>? _story;
HostViseStoryModel copyWith({  bool? status,
  String? message,
  List<Story>? story,
}) => HostViseStoryModel(  status: status ?? _status,
  message: message ?? _message,
  story: story ?? _story,
);
  bool? get status => _status;
  String? get message => _message;
  List<Story>? get story => _story;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_story != null) {
      map['story'] = _story?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


Story storyFromJson(String str) => Story.fromJson(json.decode(str));
String storyToJson(Story data) => json.encode(data.toJson());
class Story {
  Story({
      String? id, 
      String? image, 
      dynamic video, 
      num? view, 
      String? hostId, 
      String? date, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _image = image;
    _video = video;
    _view = view;
    _hostId = hostId;
    _date = date;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Story.fromJson(dynamic json) {
    _id = json['_id'];
    _image = json['image'];
    _video = json['video'];
    _view = json['view'];
    _hostId = json['hostId'];
    _date = json['date'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _image;
  dynamic _video;
  num? _view;
  String? _hostId;
  String? _date;
  String? _createdAt;
  String? _updatedAt;
Story copyWith({  String? id,
  String? image,
  dynamic video,
  num? view,
  String? hostId,
  String? date,
  String? createdAt,
  String? updatedAt,
}) => Story(  id: id ?? _id,
  image: image ?? _image,
  video: video ?? _video,
  view: view ?? _view,
  hostId: hostId ?? _hostId,
  date: date ?? _date,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get image => _image;
  dynamic get video => _video;
  num? get view => _view;
  String? get hostId => _hostId;
  String? get date => _date;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['image'] = _image;
    map['video'] = _video;
    map['view'] = _view;
    map['hostId'] = _hostId;
    map['date'] = _date;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}