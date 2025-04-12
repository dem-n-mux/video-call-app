import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../app_images.dart';

class StoryModel {
  String profileName;
  String profileImage;
  bool isActive;
  String age;
  String iD;
  String country;
  final List<StoryModelData> stories;

  StoryModel(
      {required this.profileImage,
      required this.profileName,
      required this.country,
      required this.iD,
      required this.age,
      required this.stories,
      required this.isActive});
}

class StoryModelData {
  final String imageUrl;

  StoryModelData({required this.imageUrl});
}

Future<File> urlToFile(String imageUrl) async {
  var rng = Random();
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = File('$tempPath${rng.nextInt(100)}.png');
  http.Response response = await http.get(Uri.parse(imageUrl));
  await file.writeAsBytes(response.bodyBytes);
  return file;
}

List<StoryModel> storyList = [
  StoryModel(
    profileImage: AppImages.storyModel1,
    profileName: "Milly",
    stories: [
      StoryModelData(imageUrl: AppImages.storyModel12),
      StoryModelData(imageUrl: AppImages.storyModel13),
      StoryModelData(imageUrl: AppImages.storyModel14),
    ],
    isActive: false,
    age: '24',
    country: "Brazil",
    iD: '8523697',
  ),
  StoryModel(
    profileImage: AppImages.storyModel2,
    profileName: "Senorita",
    stories: [
      StoryModelData(imageUrl: AppImages.storyModel21),
      StoryModelData(imageUrl: AppImages.storyModel22),
    ],
    isActive: false,
    age: '22',
    country: "U.K",
    iD: '9924310',
  ),
  StoryModel(
    profileImage: AppImages.storyModel3,
    profileName: "Rio",
    age: '26',
    country: "L.A",
    iD: '9016767',
    stories: [
      StoryModelData(imageUrl: AppImages.storyModel31),
    ],
    isActive: false,
  ),
  StoryModel(
    profileImage: AppImages.storyModel4,
    profileName: "Angle",
    stories: [
      StoryModelData(imageUrl: AppImages.storyModel41),
      StoryModelData(imageUrl: AppImages.storyModel42),
      StoryModelData(imageUrl: AppImages.storyModel43),
    ],
    isActive: false,
    age: '25',
    country: "UAE",
    iD: '7562051',
  ),
  StoryModel(
    profileImage: AppImages.storyModel6,
    profileName: "Zara",
    stories: [StoryModelData(imageUrl: AppImages.storyModel61)],
    isActive: false,
    age: '21',
    country: "Canada",
    iD: '5893421',
  ),
];
