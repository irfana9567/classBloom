import 'package:classbloom/feature/home/course_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key,this.title, this.description, this.video});
  final String? title;
  final String? description;
  final String? video;
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  bool _isNextButtonEnabled = false;

  // Network Video URL
  final String videoUrl =
      'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4';

  @override
  void initState() {
    super.initState();

    // Initialize the VideoPlayerController for Network Video
    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });

    // Initialize ChewieController with video controls
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: false,
      looping: false,
      showControls: true,
      customControls: MaterialControls(), // You can also create your own custom controls if needed
    );

    // Check video completion and enable next button
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        setState(() {
          _isNextButtonEnabled = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }

  void _rewind() {
    final currentPosition = _controller.value.position;
    final rewindPosition = currentPosition - const Duration(seconds: 10);
    _controller.seekTo(rewindPosition >= Duration.zero ? rewindPosition : Duration.zero);
  }

  void _forward() {
    final currentPosition = _controller.value.position;
    final forwardPosition = currentPosition + const Duration(seconds: 10);
    _controller.seekTo(forwardPosition <= _controller.value.duration
        ? forwardPosition
        : _controller.value.duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(widget.title!)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Video Player
          _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Chewie(
              controller: _chewieController,
            ),
          )
              : const Center(child: CircularProgressIndicator()),

          // Controls for Rewind, Play/Pause, Forward
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.replay_10),
                  onPressed: _rewind,
                ),
                IconButton(
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.forward_10),
                  onPressed: _forward,
                ),
              ],
            ),
          ),

          // Title and Description of the Video
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  widget.title!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  widget.description!,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          // Next Video Button (enabled after the video finishes)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: _isNextButtonEnabled
                  ? () {
               Navigator.pop(context);
              }
                  : null,
              child: const Text('Next Video'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  _isNextButtonEnabled ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
