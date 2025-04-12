class CreateStoryModel {
  bool? status;
  String? message;
  Story? story;

  CreateStoryModel({this.status, this.message, this.story});

  CreateStoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    story = json['story'] != null ? Story.fromJson(json['story']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (story != null) {
      data['story'] = story!.toJson();
    }
    return data;
  }
}

class Story {
  String? image;
  Null video;
  int? view;
  String? sId;
  String? hostId;
  String? date;
  String? createdAt;
  String? updatedAt;

  Story(
      {this.image,
        this.video,
        this.view,
        this.sId,
        this.hostId,
        this.date,
        this.createdAt,
        this.updatedAt});

  Story.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    video = json['video'];
    view = json['view'];
    sId = json['_id'];
    hostId = json['hostId'];
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['video'] = video;
    data['view'] = view;
    data['_id'] = sId;
    data['hostId'] = hostId;
    data['date'] = date;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}