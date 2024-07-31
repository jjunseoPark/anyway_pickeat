import 'package:chewie/chewie.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickeat/model/shops.dart';
import 'package:video_player/video_player.dart';

import '../analytic_config.dart';

class FoodPlayer extends StatefulWidget {

  Shop shop;

  FoodPlayer({super.key, required this.shop});

  @override
  State<FoodPlayer> createState() => _FoodPlayerState();
}

class _FoodPlayerState extends State<FoodPlayer> {

  late VideoPlayerController videoController;
  ChewieController? chewieController;

  final storageRef = FirebaseStorage.instance.ref();

  @override
  void initState() {
    super.initState();
    initializePlayer();

    Analytics_config().play_video(
        menu_name: widget.shop.menu_name,
        menu_price: widget.shop.menu_price,
        store_rating_naver: widget.shop.store_rating_naver,
        store_rating_kakao: widget.shop.store_rating_kakao,
        store_name: widget.shop.store_name);
  }

  @override
  void dispose() {
    videoController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  // 영상 재생에 필요한 함수
  Future<void> initializePlayer() async {
    final pathReference = await storageRef
        .child("menu_video/${widget.shop.menu_id}.mp4")
        .getDownloadURL();

    videoController =
        VideoPlayerController.networkUrl(Uri.parse(pathReference));
    await Future.wait([videoController.initialize()]);
    createChewieController();
    setState(() {});
  }

  void createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: videoController,
      autoPlay: true,
      looping: true,
      showControls: false,
      aspectRatio: videoController.value.aspectRatio,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: chewieController != null &&
          chewieController!.videoPlayerController.value.isInitialized
          ? AspectRatio(
        aspectRatio: MediaQuery.of(context).size.aspectRatio,
        child: ClipRect(
          child: OverflowBox(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width /
                    chewieController!
                        .videoPlayerController.value.aspectRatio,
                child: Chewie(
                  controller: chewieController!,
                ),
              ),
            ),
          ),
        ),
      )
          : const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 20,
          ),
          Text("loading"),
        ],
      ),
    );
  }
}
