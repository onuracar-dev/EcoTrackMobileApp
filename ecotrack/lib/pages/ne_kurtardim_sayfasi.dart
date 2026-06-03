import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/video_arka_plan.dart';
import 'dart:ui'; // BackdropFilter için

class NeKurtardimSayfasi extends StatefulWidget {
  const NeKurtardimSayfasi({super.key});

  @override
  State<NeKurtardimSayfasi> createState() {
    return _NeKurtardimSayfasiState();
  }
}

class _NeKurtardimSayfasiState extends State<NeKurtardimSayfasi> {
  double plastik = 0;
  double kagit = 0;
  double cam = 0;
  double metal = 0;

  double agacSayisi = 0;
  double suMiktari = 0;
  double co2Miktari = 0;

  void hesapla() {
    setState(() {
      agacSayisi = (kagit * 0.017) + (plastik * 0.0001) + (cam * 0.0002) + (metal * 0.0003);
      suMiktari = (plastik * 3) + (kagit * 26) + (cam * 1.2) + (metal * 5);
      co2Miktari = (plastik * 0.08) + (kagit * 0.90) + (cam * 0.30) + (metal * 0.50);
    });
  }