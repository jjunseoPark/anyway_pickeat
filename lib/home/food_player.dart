import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pickeat/const/color.dart';
import 'package:video_player/video_player.dart';

import 'food_information.dart';

class FoodPlayer extends StatefulWidget {
  const FoodPlayer({super.key});

  @override
  State<FoodPlayer> createState() => _FoodPlayerState();
}

class _FoodPlayerState extends State<FoodPlayer> {
  int currentPage = 0;
  final PageController pageViewController =
      PageController(initialPage: 0, viewportFraction: 1.0);

  late VideoPlayerController videoController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    initializePlyaer();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlyaer() async {
    videoController = VideoPlayerController.asset("assets/011.mp4");
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
      aspectRatio: MediaQuery.of(context).size.aspectRatio,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white10,
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          controller: pageViewController,
          onPageChanged: (idx) {
            setState(() {
              currentPage = idx;
            });
          },
          itemBuilder: (context, index) {
            return Stack(
              children: [
                // Container(
                //   color: Colors.white,
                //   child: Center(
                //     child: chewieController != null &&
                //         chewieController!
                //             .videoPlayerController.value.isInitialized
                //         ? Chewie(
                //       controller: chewieController!,
                //     )
                //         : const Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         CircularProgressIndicator(),
                //         SizedBox(
                //           height: 20,
                //         ),
                //         Text("loading"),
                //       ],
                //     ),
                //   ),
                // ),

                FoodInformation(),
              ],
            );
          },
        ),
      ),
    );
  }
}
