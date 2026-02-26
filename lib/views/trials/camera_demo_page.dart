import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class CameraDemoPage extends StatefulWidget {
  const CameraDemoPage({super.key});

  @override
  State<CameraDemoPage> createState() => _CameraDemoPageState();
}

class _CameraDemoPageState extends State<CameraDemoPage> {
  final ImagePicker _picker = ImagePicker();

  File? _imageFile;
  File? _videoFile;
  VideoPlayerController? _videoController;

  Future<void> _takePhoto() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (file == null) return;

    _clearVideo();
    setState(() {
      _imageFile = File(file.path);
    });
  }

  Future<void> _recordVideo() async {
    final XFile? file = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(seconds: 30),
    );

    if (file == null) return;

    _clearImage();

    _videoFile = File(file.path);
    _videoController = VideoPlayerController.file(_videoFile!)
      ..initialize().then((_) {
        setState(() {});
        _videoController?.play();
      });
  }

  void _clearImage() {
    _imageFile = null;
  }

  void _clearVideo() {
    _videoController?.dispose();
    _videoController = null;
    _videoFile = null;
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('iOS 相机权限示例')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _takePhoto,
                    child: const Text('拍照'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _recordVideo,
                    child: const Text('录视频'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Expanded(
              child: Center(
                child: _buildPreview(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview() {
    if (_imageFile != null) {
      return Image.file(_imageFile!);
    }

    if (_videoController != null &&
        _videoController!.value.isInitialized) {
      return AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio,
        child: VideoPlayer(_videoController!),
      );
    }

    return const Text('暂无内容');
  }
}
