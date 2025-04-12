import 'dart:convert';

StoryViewModel storyViewModelFromJson(String str) => StoryViewModel.fromJson(json.decode(str));
String storyViewModelToJson(StoryViewModel data) => json.encode(data.toJson());
class StoryViewModel {
  StoryViewModel({
      bool? status, 
      String? message, 
      ViewStory? viewStory,}){
    _status = status;
    _message = message;
    _viewStory = viewStory;
}

  StoryViewModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _viewStory = json['viewStory'] != null ? ViewStory.fromJson(json['viewStory']) : null;
  }
  bool? _status;
  String? _message;
  ViewStory? _viewStory;
StoryViewModel copyWith({  bool? status,
  String? message,
  ViewStory? viewStory,
}) => StoryViewModel(  status: status ?? _status,
  message: message ?? _message,
  viewStory: viewStory ?? _viewStory,
);
  bool? get status => _status;
  String? get message => _message;
  ViewStory? get viewStory => _viewStory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_viewStory != null) {
      map['viewStory'] = _viewStory?.toJson();
    }
    return map;
  }

}


ViewStory viewStoryFromJson(String str) => ViewStory.fromJson(json.decode(str));
String viewStoryToJson(ViewStory data) => json.encode(data.toJson());
class ViewStory {
  ViewStory({
      String? id, 
      String? userId, 
      String? storyId, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _userId = userId;
    _storyId = storyId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  ViewStory.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    _storyId = json['storyId'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _userId;
  String? _storyId;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
ViewStory copyWith({  String? id,
  String? userId,
  String? storyId,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => ViewStory(  id: id ?? _id,
  userId: userId ?? _userId,
  storyId: storyId ?? _storyId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get storyId => _storyId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userId'] = _userId;
    map['storyId'] = _storyId;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}