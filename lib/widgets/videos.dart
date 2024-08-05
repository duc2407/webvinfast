import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Videos extends StatefulWidget {
  const Videos({super.key});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  late VideoPlayerController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/videos/video1.mp4',
    )..initialize().then((_) {
        setState(() {
          _isLoading = false;
          _controller.play();
          _controller.setLooping(true); // Tự động phát video
        });
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
        print('Error initializing video player: $error');
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              ),
      ),
      // floatingActionButton: !_isLoading
      //     ? FloatingActionButton(
      //         onPressed: () {
      //           setState(() {
      //             _controller.value.isPlaying
      //                 ? _controller.pause()
      //                 : _controller.play();
      //           });
      //         },
      //         child: Icon(
      //           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //         ),
      //       )
      //     : null,
    );
  }
}
