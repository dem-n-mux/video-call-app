import 'package:get/get.dart';

class UserLiveStreamingCommentProfile extends GetxController {

  dynamic selectedGiftIndex;
  dynamic selectedTab;

  dynamic followUnFollow;
  dynamic indicator;
  @override
  void onInit() {

    selectedGiftIndex = 0.obs;
    selectedTab = 1.obs;


    followUnFollow = true;
    indicator = false;
    // TODO: implement onInit
    super.onInit();
  }

  void changeValue() {
    indicator = true;
    Future.delayed(
      const Duration(seconds: 1),
          () {
        if (followUnFollow == true) {
          followUnFollow = false;
        } else {
          followUnFollow = true;
        }
        indicator = false;
        update();
      },
    );
    update();
  }
}
