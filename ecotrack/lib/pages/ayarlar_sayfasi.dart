import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/video_arka_plan.dart';
import 'dart:ui';

class AyarlarSayfasi extends StatefulWidget {
  const AyarlarSayfasi({super.key});

  @override
  State<AyarlarSayfasi> createState() {
    return _AyarlarSayfasiState();
  }
}

class _AyarlarSayfasiState extends State<AyarlarSayfasi> {
  // Arayüz Tercihleri durumları
  bool karanlikMod = true;
  bool bildirimler = true;
  bool otomatikGuncelleme = true;

  // Oturum ve Güvenlik durumları
  bool ikiAdimliDogrulama = false;

  // Ortak şeffaf (cam) panel tasarımı
  Widget camKutu({required Widget icerik}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: icerik,
        ),
      ),
    );
  }