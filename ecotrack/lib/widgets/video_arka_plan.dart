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