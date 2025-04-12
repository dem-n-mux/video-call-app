import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:just_audio/just_audio.dart';
import '../settings/app_colors.dart';

class SendDummyMessage extends StatefulWidget {
  final String message;
  final String time;
  final File? image;
  final int messageType;
  final int index;

  const SendDummyMessage({
    Key? key,
    required this.message,
    this.image,
    required this.time,
    required this.messageType,
    required this.index,
  }) : super(key: key);

  @override
  State<SendDummyMessage> createState() => _SendDummyMessageState();
}

class _SendDummyMessageState extends State<SendDummyMessage> {
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 130,
              ),
              child: Card(
                elevation: 2,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15), bottomLeft: Radius.circular(15), topRight: Radius.circular(15))),
                color: AppColors.lightPinkColor,
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
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                                              color: AppColors.pinkColor,
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
                        : (widget.messageType == 3)
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: (widget.message.length <= 7) ? 45 : 10, top: 5, bottom: 15),
                                child: Text(
                                  widget.message,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff0E0C16),
                                  ),
                                ))
                            : (widget.messageType == 0)
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 3, right: (widget.message.length <= 7) ? 45 : 3, top: 3, bottom: 3),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                      child: Image.network(widget.message, errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey.withOpacity(0.3),
                                          child: const Center(child: Icon(Icons.error)),
                                        );
                                      }, fit: BoxFit.cover),
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
                                            color: Color(0xff0E0C16),
                                          ),
                                        ))
                                    : const SizedBox(),
                    Positioned(
                      bottom: 1,
                      right: 5,
                      child: Text(
                        widget.time,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 32,
            width: 32,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightPinkColor),
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.all(1.5),
            child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: CachedNetworkImage(
                  imageUrl: userImage,
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
