import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../theme/style.dart';

class VideoPreviewScreen extends StatefulWidget {
  static const routeName = 'videoPreviewScreen';
  VideoPreviewScreen(this.videoFile);
  File videoFile;

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen>
    with SingleTickerProviderStateMixin {
  VideoPlayerController? controller;

  AnimationController? animationController;

  var isRemoveWidget = false;

  @override
  void initState() {
    controller = VideoPlayerController.file(widget.videoFile)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((_) {
        controller!.play();
      });

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 600,
      ),
    );
    animationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // controller!.value.isPlaying
    //     ? setState(() {
    //         isPlaying = true;
    //       })
    //     : setState(
    //         () {
    //           isPlaying = false;
    //         },
    //       );
    if (controller!.value.isPlaying) {
      Future.delayed(const Duration(seconds: 3)).then(
        (_) {
          setState(() {
            isRemoveWidget = true;
          });
        },
      );
    } else {
      setState(() {
        isRemoveWidget = false;
      });
    }
    print(isRemoveWidget);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: FloatingActionButton.small(
                backgroundColor: Style.isDark ? Colors.white : Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
              ),
            ),
            Center(
              child: controller!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: controller!.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                if (controller!.value.isPlaying) {
                                  controller!.pause();
                                  animationController!.reverse();
                                } else {
                                  controller!.play();
                                  animationController!.forward();
                                }
                              },
                              child: VideoPlayer(controller!)),
                          if (isRemoveWidget == false)
                            AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: animationController!,
                              size: 40,
                              color: Colors.white,
                            ),
                        ],
                      ),
                    )
                  : const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
