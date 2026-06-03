import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoArkaPlan extends StatefulWidget {
  final String videoYolu;
  final Widget icerik;
  final Alignment hizalama; // Videonun duruşunu sağa sola hizalamak için yeni parametre

  const VideoArkaPlan({
    super.key,
    required this.videoYolu,
    required this.icerik,
    this.hizalama = Alignment.center, // Varsayılan olarak ortalanır
  });

  @override
  State<VideoArkaPlan> createState() {
    return _VideoArkaPlanState();
  }
}

class _VideoArkaPlanState extends State<VideoArkaPlan> {
  late VideoPlayerController _kontrolcu;

  @override
  void initState() {
    super.initState();
    _kontrolcu = VideoPlayerController.asset(widget.videoYolu);
    _kontrolcu.initialize().then((_) {
      _kontrolcu.setLooping(true);
      _kontrolcu.setVolume(0.0);
      _kontrolcu.play();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _kontrolcu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (_kontrolcu.value.isInitialized)
          FittedBox(
            fit: BoxFit.cover,
            alignment: widget.hizalama,
            child: SizedBox(
              width: _kontrolcu.value.size.width,
              height: _kontrolcu.value.size.height,
              child: VideoPlayer(_kontrolcu),
            ),
          )
        else
          Container(color: Colors.black),
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
        widget.icerik,
      ],
    );
  }
}
