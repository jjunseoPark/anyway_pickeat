import 'package:chewie/chewie.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  final storageRef = FirebaseStorage.instance.ref();


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

    final pathReference = await storageRef.child("menu_video/021.mp4").getDownloadURL();
    
    videoController = VideoPlayerController.networkUrl(Uri.parse(pathReference));
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
        color: Colors.black,
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
                Container(
                  color: Colors.white,
                  child: Center(
                    child: chewieController != null &&
                        chewieController!
                            .videoPlayerController.value.isInitialized
                        ? Chewie(
                      controller: chewieController!,
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
                  ),
                ),

                FoodInformation(),
              ],
            );
          },
        ),
      ),
    );
  }
}
