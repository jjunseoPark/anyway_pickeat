import 'package:chewie/chewie.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickeat/model/shops.dart';
import 'package:video_player/video_player.dart';

import '../analytic_config.dart';

class FoodPlayer extends StatefulWidget {
  final Shop shop;

  const FoodPlayer({super.key, required this.shop});

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
      store_name: widget.shop.store_name,
    );
  }

  @override
  void dispose() {
    videoController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    try {
      final pathReference = await storageRef
          .child("menu_video/${widget.shop.menu_id}.mp4")
          .getDownloadURL();

      videoController =
          VideoPlayerController.networkUrl(Uri.parse(pathReference));

      videoController.setVolume(0.0);

      await videoController.initialize();
      createChewieController();

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          chewieController = null;
        });
      }
    }
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
      child: Stack(
        children: [
          ClipRect(
            child: OverflowBox(
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: MediaQuery.of(context).size.aspectRatio,
                child: Image.asset(
                  'assets/menu_thumb/${widget.shop.menu_id}.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (chewieController != null &&
              chewieController!.videoPlayerController.value.isInitialized)
            AspectRatio(
              aspectRatio: MediaQuery.of(context).size.aspectRatio,
              child: ClipRect(
                child: OverflowBox(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width/ chewieController!.videoPlayerController.value.aspectRatio,
                      child: Chewie(
                        controller: chewieController!,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

