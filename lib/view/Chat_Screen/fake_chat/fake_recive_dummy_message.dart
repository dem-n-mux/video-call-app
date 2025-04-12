import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:just_audio/just_audio.dart';

class FakeReceiveDummyMessage extends StatefulWidget {
  final String message;
  final String profileImage;
  final String? selectedImage;
  final String time;
  final int messageType;

  const FakeReceiveDummyMessage({
    Key? key,
    required this.message,
    required this.profileImage,
    this.selectedImage,
    required this.time,
    required this.messageType,
  }) : super(key: key);

  @override
  State<FakeReceiveDummyMessage> createState() => _FakeReceiveDummyMessageState();
}

class _FakeReceiveDummyMessageState extends State<FakeReceiveDummyMessage> {
  final player = AudioPlayer();
  Duration? duration;
  @override
  void initState() {
    super.initState();
    if (widget.messageType == 2) {
      player.setUrl(widget.message).then((value) {
        setState(() {
          duration = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: const BoxDecoration(
                // image: DecorationImage(image: NetworkImage(widget.profileImage), fit: BoxFit.cover),
                shape: BoxShape.circle,
                color: AppColors.pinkColor),
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.all(1.5),
            child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: CachedNetworkImage(
                  imageUrl: widget.profileImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Center(
                      child: Image.asset(
                        AppIcons.userPlaceholder,
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Center(
                      child: Image.asset(
                        AppIcons.userPlaceholder,
                      ),
                    );
                  },
                )),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 130,
              ),
              child: Card(
                elevation: 2,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15), bottomRight: Radius.circular(15), topRight: Radius.circular(15))),
                color: AppColors.pinkColor,
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Stack(
                  children: [
                    (widget.messageType == 2)
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: (widget.message.length <= 7) ? 45 : 10, top: 5, bottom: 15),
                            child: Row(
                              children: [
                                StreamBuilder<PlayerState>(
                                  stream: player.playerStateStream,
                                  builder: (context, snapshot) {
                                    final playerState = snapshot.data;
                                    final processingState = playerState?.processingState;
                                    final playing = playerState?.playing;
                                    if (processingState == ProcessingState.loading ||
                                        processingState == ProcessingState.buffering) {
                                      return GestureDetector(
                                        onTap: player.play,
                                        child: const Icon(Icons.play_arrow),
                                      );
                                    } else if (playing != true) {
                                      return GestureDetector(
                                        onTap: player.play,
                                        child: const Icon(Icons.play_arrow),
                                      );
                                    } else if (processingState != ProcessingState.completed) {
                                      return GestureDetector(
                                        onTap: player.pause,
                                        child: const Icon(Icons.pause),
                                      );
                                    } else {
                                      return GestureDetector(
                                        child: const Icon(Icons.replay),
                                        onTap: () {
                                          player.seek(Duration.zero);
                                        },
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: StreamBuilder<Duration>(
                                    stream: player.positionStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10),
                                            LinearProgressIndicator(
                                              color: AppColors.lightPinkColor,
                                              backgroundColor: Colors.grey.shade400,
                                              value: snapshot.data!.inMilliseconds / (duration?.inMilliseconds ?? 1),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              prettyDuration(snapshot.data! == Duration.zero
                                                  ? duration ?? Duration.zero
                                                  : snapshot.data!),
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return const LinearProgressIndicator();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : (widget.messageType == 1)
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: (widget.message.length <= 7) ? 45 : 10, top: 12, bottom: 20),
                                child: Text(
                                  widget.message,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    height: 1.2,
                                  ),
                                ))
                            : (widget.messageType == 0)
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: (widget.message.length <= 7) ? 45 : 10, top: 12, bottom: 20),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                      child: Image.network(widget.message, fit: BoxFit.cover),
                                    ),
                                  )
                                : (widget.messageType == 5)
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: (widget.message.length <= 7) ? 45 : 10,
                                            top: 5,
                                            bottom: 15),
                                        child: Text(
                                          widget.message,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ))
                                    : const SizedBox(),
                    Positioned(
                      bottom: 2.5,
                      right: 10,
                      child: Text(
                        widget.time,
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String prettyDuration(Duration d) {
    var min = d.inMinutes < 10 ? "0${d.inMinutes}" : d.inMinutes.toString();
    var sec = d.inSeconds < 10 ? "0${d.inSeconds}" : d.inSeconds.toString();
    return "$min:$sec";
  }
}
