import 'package:get/get.dart';

class HostStreamingCommentController extends GetxController {


  dynamic isFollow;
  dynamic isIndicator;
  @override
  void onInit() {
    isFollow = true;
    isIndicator = false;
    // TODO: implement onInit
    super.onInit();
  }

  void changeValue() {
    isIndicator = true;
    Future.delayed(
      const Duration(seconds: 1),
          () {
        if (isFollow == true) {
          isFollow = false;
        } else {
          isFollow = true;
        }
        isIndicator = false;
        update();
      },
    );
    update();
  }
}
