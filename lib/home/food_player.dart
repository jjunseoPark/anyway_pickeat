import 'package:chewie/chewie.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'food_information.dart';

class FoodPlayer extends StatefulWidget {
  const FoodPlayer({super.key});

  @override
  State<FoodPlayer> createState() => _FoodPlayerState();
}

class _FoodPlayerState extends State<FoodPlayer> {
  int currentPage = 0;
  final PageController verticalPageController = PageController(initialPage: 0, viewportFraction: 1.0);
  final PageController horizontalPageController = PageController(initialPage: 0, viewportFraction: 1.0);

  late VideoPlayerController videoController;
  ChewieController? chewieController;

  final storageRef = FirebaseStorage.instance.ref();

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    verticalPageController.dispose();
    horizontalPageController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  // 영상 재생에 필요한 함수
  Future<void> initializePlayer() async {
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

  void _handleTapDown(TapDownDetails details, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dx = details.globalPosition.dx;

    if (dx < screenWidth / 2) {
      // 왼쪽 화면을 탭한 경우
      horizontalPageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // 오른쪽 화면을 탭한 경우
      horizontalPageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: verticalPageController,
        onPageChanged: (idx) {
          setState(() {
            currentPage = idx;
          });
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onTapDown: (details) => _handleTapDown(details, context),
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: horizontalPageController,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Center(
                        child: chewieController != null &&
                            chewieController!.videoPlayerController.value.isInitialized
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
          );
        },
      ),
    );
  }
}
