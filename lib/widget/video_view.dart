import 'dart:ui';

import 'package:bilibili_test/util/color.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart';

import '../util/view_util.dart';
import 'cutom_video_controller.dart' as CutomController;

/// 播放器组件
class VideoView extends StatefulWidget {
  final String url;
  final String cover;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;
  final Widget? overlayUi;
  final Widget? barrageUi; // 弹幕组建
  final VoidCallback? playCallBack;
  final VoidCallback? pauseCallBack;
  const VideoView(
      {Key? key,
      required this.url,
      required this.cover,
      this.autoPlay = false,
      this.looping = false,
      this.aspectRatio = 16.0 / 9.0,
      this.overlayUi,
      this.barrageUi,
      this.playCallBack,
      this.pauseCallBack})
      : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late ChewieController _chewieController; // chewie 播放器Controller
  late VideoPlayerController
      _videoPlayerController; // video_player 播放器 Controller

  // 封面
  get _placeHolder {
    double screenWidth = window.physicalSize.width;
    double playerHeight = screenWidth / widget.aspectRatio;
    print(
        "widget cover : ${widget.cover},screenWidth:$screenWidth,playerHeight:$playerHeight");
    return FractionallySizedBox(
      widthFactor: 1,
      child: cachedImage(widget.cover ?? "",
          width: screenWidth, height: playerHeight),
    );
  }

  get _progressColors => ChewieProgressColors(
      playedColor: primary,
      handleColor: primary,
      backgroundColor: Colors.grey,
      bufferedColor: primary[50]!);

  @override
  void initState() {
    super.initState();
    _initPlayView();
  }

  _initPlayView() {
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: widget.aspectRatio,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        placeholder: _placeHolder,
        allowPlaybackSpeedChanging: false,
        allowMuting: false,
        materialProgressColors: _progressColors,
        customControls: CutomController.MaterialControls(
          showLoadingOnInitialize: false,
          showBigPlayIcon: false,
          bottomGradient: blackLinearGradient(),
          overlayUI: widget.overlayUi,
          barrageUI: widget.barrageUi,
          playClickAction: widget.playCallBack,
          pauseClickAction: widget.pauseCallBack,
        ));
    _chewieController.addListener(_videoListener);
  }

  _videoListener() {
    Size size = MediaQuery.of(context).size;
    print("video listen:$size");

    if (size.width > size.height) {
      print("size.width:${size.width},size.height:${size.height}");
      if (!_chewieController.isFullScreen) {
        // chewieController?.enterFullScreen();
        // return;
      }
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }

  @override
  void dispose() {
    // 回收
    _chewieController.removeListener(_videoListener);
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screeWidth = MediaQuery.of(context).size.width;
    double playerHeight = screeWidth / widget.aspectRatio;

    return Container(
      width: screeWidth,
      height: playerHeight,
      color: Colors.grey,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
