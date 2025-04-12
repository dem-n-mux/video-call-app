import 'dart:io';

import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';

class DummyHostModel {
  String personName;
  String country;
  void Function()? onTap;
  String personImage;
  String gender;
  String isOnline;
  String iD;
  String view;
  String age;
  bool? live;
  bool? online;
  bool? busy;
  String message;
  String time;
  String pendingMessage;
  bool isActive;
  final List<StoryModelData> stories;

  DummyHostModel(
      {required this.personName,
      required this.country,
      this.onTap,
      required this.personImage,
      required this.isOnline,
      required this.view,
      required this.age,
      this.busy,
      this.live,
      this.online,
      required this.gender,
      required this.iD,
      required this.message,
      required this.time,
      required this.pendingMessage,
      required this.isActive,
      required this.stories});

  factory DummyHostModel.fromMap(Map<String, dynamic> data) {
    return DummyHostModel(
        personName: data["personName"],
        country: data["country"],
        personImage: data["personImage"],
        isOnline: data["isOnline"],
        view: data["view"],
        age: data["age"],
        gender: data["gender"],
        iD: data["iD"],
        message: data["message"],
        time: data["time"],
        pendingMessage: data["pendingMessage"],
        isActive: data["isActive"],
        stories: []);
  }
}

class StoryModelData {
  final String imageUrl;

  StoryModelData({required this.imageUrl});
}

List<Map<String, dynamic>> dummyChatList = [
  {
    "personImage": AppImages.homeProfileModel1,
    "personName": "Zara",
    "message": "Hello...",
    "time": "8:57 am",
    "pendingMessage": "5",
    "country": "Brazil",
    "view": "150",
    "age": "24",
    "gender": "F",
    "isOnline": "Online",
    "iD": "1",
  },
  {
    "personImage": AppImages.homeProfileModel2,
    "personName": "Ria",
    "message": "Hello...",
    "time": "8:57 am",
    "pendingMessage": "5",
    "country": "U.K",
    "view": "25",
    "age": "22",
    "gender": "F",
    "isOnline": "busy",
    "iD": "2",
  },
  {
    "personImage": AppImages.homeProfileModel3,
    "personName": "Tokyo",
    "message": "Hello...",
    "time": "8:57 am",
    "pendingMessage": "5",
    "country": "L.A",
    "view": "90",
    "age": "26",
    "gender": "F",
    "isOnline": 'live',
    "iD": "2",
  },
  {
    "personImage": AppImages.homeProfileModel4,
    "personName": "Miami",
    "message": "Hello...",
    "time": "8:57 am",
    "pendingMessage": "5",
    "country": "UAE",
    "view": "130",
    "age": "25",
    "gender": "F",
    "isOnline": "Online",
    "iD": "2",
  },
  {
    "personImage": AppImages.homeProfileModel5,
    "personName": "Ketty",
    "message": "Hello...",
    "time": "8:57 am",
    "pendingMessage": "5",
    "country": "Canada",
    "view": "72",
    "age": "21",
    "gender": "F",
    "isOnline": "Live",
    "iD": "2",
  }
];

List<DummyHostModel> dummyHostList = [
  DummyHostModel(
      personName: "Zara",
      onTap: () {},
      personImage: AppImages.homeProfileModel1,
      isOnline: 'Online',
      view: '150',
      age: '24',
      country: "Brazil",
      iD: '8523697',
      online: true,
      gender: 'F',
      message: "Hello...",
      time: "8:57 am",
      pendingMessage: '5',
      isActive: false,
      stories: [
        StoryModelData(imageUrl: AppImages.storyModel12),
        StoryModelData(imageUrl: AppImages.storyModel13),
        StoryModelData(imageUrl: AppImages.storyModel14),
      ]),
  DummyHostModel(
    personName: "Ria",
    onTap: () {},
    personImage: AppImages.homeProfileModel2,
    isOnline: 'Busy',
    view: '50',
    age: '22',
    country: "U.K",
    iD: '9924310',
    busy: true,
    gender: 'F',
    message: "Hii...",
    time: "Yesterday",
    pendingMessage: '4',
    isActive: false,
    stories: [
      StoryModelData(imageUrl: AppImages.storyModel21),
      StoryModelData(imageUrl: AppImages.storyModel22),
    ],
  ),
  DummyHostModel(
    personName: "Tokyo",
    onTap: () {},
    personImage: AppImages.homeProfileModel3,
    isOnline: 'Live',
    view: '90',
    age: '26',
    country: "L.A",
    iD: '9016767',
    gender: 'F',
    message: "How Are You??",
    time: "2 days ago",
    pendingMessage: '3',
    isActive: false,
    stories: [
      StoryModelData(imageUrl: AppImages.storyModel31),
    ],
  ),
  DummyHostModel(
    personName: "Miami",
    onTap: () {},
    personImage: AppImages.homeProfileModel4,
    isOnline: 'Online',
    view: '130',
    age: '25',
    country: "UAE",
    iD: '7562051',
    live: true,
    gender: 'F',
    message: "Good Morning",
    time: "2 days ago",
    pendingMessage: '2',
    isActive: false,
    stories: [
      StoryModelData(imageUrl: AppImages.storyModel41),
      StoryModelData(imageUrl: AppImages.storyModel42),
      StoryModelData(imageUrl: AppImages.storyModel43),
    ],
  ),
  DummyHostModel(
    personName: "Ketty",
    onTap: () {},
    personImage: AppImages.homeProfileModel5,
    isOnline: 'Live',
    view: '72',
    age: '21',
    country: "Canada",
    iD: '5893421',
    online: true,
    gender: 'F',
    message: "Have a great Day",
    time: "3 days ago",
    pendingMessage: '1',
    isActive: false,
    stories: [
      StoryModelData(imageUrl: AppImages.storyModel51),
      StoryModelData(imageUrl: AppImages.storyModel52),
    ],
  ),
];

class DummyChatModel {
  int type;
  String message;
  String time;
  File? assetFile;
  DummyChatModel({
    required this.message,
    required this.type,
    required this.time,
    this.assetFile,
  });
}

