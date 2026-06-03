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

class AnaMenuSayfasi extends StatefulWidget {
  const AnaMenuSayfasi({super.key});

  @override
  State<AnaMenuSayfasi> createState() {
    return _AnaMenuSayfasiState();
  }
}

class _AnaMenuSayfasiState extends State<AnaMenuSayfasi> {
  int seciliSayfaIndeksi = 0;

  final List<Widget> sayfalar = [
    const AnaSayfa(),
    const AtikNoktalariSayfasi(),
    const NeKurtardimSayfasi(),
    const AtikBankasiSayfasi(),
    const HakkimizdaSayfasi(),
    const AyarlarSayfasi(),
  ];

  void sayfayiDegistir(int index) {
    setState(() {
      seciliSayfaIndeksi = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Alt menünün arkasını şeffaf yapmak için
      body: sayfalar[seciliSayfaIndeksi],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          border: const Border(top: BorderSide(color: Colors.white24, width: 1)),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: seciliSayfaIndeksi,
          onTap: sayfayiDegistir,
          selectedItemColor: Colors.greenAccent,
          unselectedItemColor: Colors.white54,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Harita'),
            BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'Tasarruf'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Bankası'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Hakkında'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ayarlar'),
          ],
        ),
      ),
    );
  }
}
