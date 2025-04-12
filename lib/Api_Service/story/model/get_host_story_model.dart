import 'dart:convert';

GetHostStoryModel getHostStoryModelFromJson(String str) => GetHostStoryModel.fromJson(json.decode(str));
String getHostStoryModelToJson(GetHostStoryModel data) => json.encode(data.toJson());
class GetHostStoryModel {
  GetHostStoryModel({
      bool? status, 
      String? message, 
      List<Story>? story,}){
    _status = status;
    _message = message;
    _story = story;
}

  GetHostStoryModel.fromJson(dynamic json) {
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
GetHostStoryModel copyWith({  bool? status,
  String? message,
  List<Story>? story,
}) => GetHostStoryModel(  status: status ?? _status,
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
      List<HostStory>? hostStory, 
      String? id, 
      String? hostName, 
      String? hostImage,}){
    _hostStory = hostStory;
    _id = id;
    _hostName = hostName;
    _hostImage = hostImage;
}

  Story.fromJson(dynamic json) {
    if (json['hostStory'] != null) {
      _hostStory = [];
      json['hostStory'].forEach((v) {
        _hostStory?.add(HostStory.fromJson(v));
      });
    }
    _id = json['_id'];
    _hostName = json['hostName'];
    _hostImage = json['hostImage'];
  }
  List<HostStory>? _hostStory;
  String? _id;
  String? _hostName;
  String? _hostImage;
Story copyWith({  List<HostStory>? hostStory,
  String? id,
  String? hostName,
  String? hostImage,
}) => Story(  hostStory: hostStory ?? _hostStory,
  id: id ?? _id,
  hostName: hostName ?? _hostName,
  hostImage: hostImage ?? _hostImage,
);
  List<HostStory>? get hostStory => _hostStory;
  String? get id => _id;
  String? get hostName => _hostName;
  String? get hostImage => _hostImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_hostStory != null) {
      map['hostStory'] = _hostStory?.map((v) => v.toJson()).toList();
    }
    map['_id'] = _id;
    map['hostName'] = _hostName;
    map['hostImage'] = _hostImage;
    return map;
  }

}


HostStory hostStoryFromJson(String str) => HostStory.fromJson(json.decode(str));
String hostStoryToJson(HostStory data) => json.encode(data.toJson());
class HostStory {
  HostStory({
      String? id, 
      dynamic image, 
      dynamic video, 
      num? view, 
      String? hostId, 
      String? date, 
      bool? isView,}){
    _id = id;
    _image = image;
    _video = video;
    _view = view;
    _hostId = hostId;
    _date = date;
    _isView = isView;
}

  HostStory.fromJson(dynamic json) {
    _id = json['_id'];
    _image = json['image'];
    _video = json['video'];
    _view = json['view'];
    _hostId = json['hostId'];
    _date = json['date'];
    _isView = json['isView'];
  }
  String? _id;
  dynamic _image;
  dynamic _video;
  num? _view;
  String? _hostId;
  String? _date;
  bool? _isView;
HostStory copyWith({  String? id,
  dynamic image,
  dynamic video,
  num? view,
  String? hostId,
  String? date,
  bool? isView,
}) => HostStory(  id: id ?? _id,
  image: image ?? _image,
  video: video ?? _video,
  view: view ?? _view,
  hostId: hostId ?? _hostId,
  date: date ?? _date,
  isView: isView ?? _isView,
);
  String? get id => _id;
  dynamic get image => _image;
  dynamic get video => _video;
  num? get view => _view;
  String? get hostId => _hostId;
  String? get date => _date;
  bool? get isView => _isView;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['image'] = _image;
    map['video'] = _video;
    map['view'] = _view;
    map['hostId'] = _hostId;
    map['date'] = _date;
    map['isView'] = _isView;
    return map;
  }

}