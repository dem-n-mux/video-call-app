import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoCallController extends GetxController {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  Future initializePlayer() async {
    videoPlayerController =
        VideoPlayerController.asset("assets/video/video_3.mp4");
    await Future.wait([videoPlayerController.initialize()]);
    chewieController = ChewieController(
      allowMuting: true,
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: true,
      aspectRatio: 0.5,
    );
    update();
  }
}
