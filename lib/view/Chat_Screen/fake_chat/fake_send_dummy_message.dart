import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:just_audio/just_audio.dart';

class FakeSendDummyMessage extends StatefulWidget {
  final String message;
  final String time;
  final int type;
  final File? assetFile;

  const FakeSendDummyMessage({
    Key? key,
    required this.message,
    required this.time,
    required this.type,
    this.assetFile,
  }) : super(key: key);

  @override
  State<FakeSendDummyMessage> createState() => _FakeSendDummyMessageState();
}

class _FakeSendDummyMessageState extends State<FakeSendDummyMessage> {
  final player = AudioPlayer();
  Duration? duration;

  @override
  void initState() {
    super.initState();
    if (widget.type == 4) {
      player.setFilePath(widget.assetFile!.path).then((value) {
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
                    (widget.type == 1)
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: (widget.message.length <= 7) ? 45 : 10, top: 12, bottom: 20),
                            child: Text(
                              widget.message,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff0E0C16),
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                              ),
                            ))
                        : (widget.type == 2)
                            ? Padding(
                                padding: const EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
                                child: SizedBox(
                                  height: 280,
                                  width: 215,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(13),
                                      bottomLeft: Radius.circular(13),
                                      topRight: Radius.circular(13),
                                    ),
                                    child: FadeInImage(
                                      placeholder: const AssetImage(
                                        AppIcons.logoPlaceholder,
                                      ),
                                      image: FileImage(widget.assetFile!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ))
                            : (widget.type == 3)
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: (widget.message.length <= 7) ? 45 : 10, top: 12, bottom: 20),
                                    child: Image(
                                      image: NetworkImage(widget.message),
                                      height: 60,
                                      width: 60,
                                    ),
                                  )
                                : (widget.type == 4)
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: (widget.message.length <= 7) ? 45 : 10,
                                            top: 12,
                                            bottom: 20),
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
                                                    child: const Icon(Icons.play_arrow, color: Colors.white),
                                                  );
                                                } else if (playing != true) {
                                                  return GestureDetector(
                                                    onTap: player.play,
                                                    child: const Icon(Icons.play_arrow, color: Colors.white),
                                                  );
                                                } else if (processingState != ProcessingState.completed) {
                                                  return GestureDetector(
                                                    onTap: player.pause,
                                                    child: const Icon(Icons.pause, color: Colors.white),
                                                  );
                                                } else {
                                                  return GestureDetector(
                                                    child: const Icon(Icons.replay, color: Colors.white),
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
                                                          color: Colors.white,
                                                          backgroundColor: Colors.grey.shade400,
                                                          value: snapshot.data!.inMilliseconds /
                                                              (duration?.inMilliseconds ?? 1),
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
                                    : const SizedBox(),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Text(
                        widget.time,
                        style: const TextStyle(
                          fontFamily: 'amidum',
                          color: Colors.black,
                          fontSize: 8,
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
              // image: DecorationImage(image: NetworkImage(widget.profileImage), fit: BoxFit.cover),
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
