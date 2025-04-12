import 'dart:io';


class UserComplain {
  late String? userClassMessage;
  late String? userClassContact;
  late File? userImage;
  late String? userTime;

  UserComplain({
    this.userClassMessage,
    this.userClassContact,
    this.userImage,
    this.userTime,
  });
}

List<UserComplain> userComplainData = [];


