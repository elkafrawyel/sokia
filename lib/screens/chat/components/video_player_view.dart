import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sokia_app/controllers/chat_controller.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  final String mUrl;
  final bool local, uploading;

  VideoPlayerView({
    this.mUrl,
    this.local,
    this.uploading,
  });

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      autoPlay: false,
      autoInitialize: true,
      videoPlayerController: widget.local
          ? VideoPlayerController.file(File(widget.mUrl))
          : VideoPlayerController.network(widget.mUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: FlickVideoPlayer(
            flickManager: flickManager,
            preferredDeviceOrientationFullscreen: [
              DeviceOrientation.portraitUp,
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ],
          ),
        ),
        _uploadingView()
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    flickManager.dispose();
  }

  _uploadingView() {
    // upload placeholder
    return GetBuilder<ChatController>(
      id: 'upload',
      builder: (controller) {
        return PositionedDirectional(
          top: 0.0,
          start: 0.0,
          end: 0.0,
          bottom: 0.0,
          child: Visibility(
            visible: widget.uploading,
            child: InkWell(
              onTap: null,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularPercentIndicator(
                    radius: 70.0,
                    lineWidth: 5.0,
                    percent: 1.0,
                    animationDuration: 1000,
                    animation: true,
                    center: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${controller.uploadProgress} %',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    progressColor: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
