import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/ana_sayfa.dart';
import 'pages/atik_noktalari_sayfasi.dart';
import 'pages/ne_kurtardim_sayfasi.dart';
import 'pages/atik_bankasi_sayfasi.dart';
import 'pages/hakkimizda_sayfasi.dart';
import 'pages/ayarlar_sayfasi.dart';

void main() {
  runApp(const EcoTrackUygulamasi());
}

class EcoTrackUygulamasi extends StatelessWidget {
  const EcoTrackUygulamasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      home: const AnaMenuSayfasi(),
    );
  }
}