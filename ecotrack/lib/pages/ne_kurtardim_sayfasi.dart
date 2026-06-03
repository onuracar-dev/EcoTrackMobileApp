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

  Widget camKutu({required Widget icerik}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: icerik,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoArkaPlan(
        videoYolu: 'assets/videos/save.mp4',
        icerik: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Ne Kurtardım',
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                camKutu(
                  icerik: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Plastik (kg)',
                          labelStyle: TextStyle(color: Colors.white70),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                        ),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        onChanged: (deger) {
                          if (deger.isNotEmpty) {
                            plastik = double.parse(deger);
                          } else {
                            plastik = 0;
                          }
                          hesapla();
                        },
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Kağıt (kg)',
                          labelStyle: TextStyle(color: Colors.white70),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                        ),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        onChanged: (deger) {
                          if (deger.isNotEmpty) {
                            kagit = double.parse(deger);
                          } else {
                            kagit = 0;
                          }
                          hesapla();
                        },
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Cam (kg)',
                          labelStyle: TextStyle(color: Colors.white70),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                        ),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        onChanged: (deger) {
                          if (deger.isNotEmpty) {
                            cam = double.parse(deger);
                          } else {
                            cam = 0;
                          }
                          hesapla();
                        },
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Metal (kg)',
                          labelStyle: TextStyle(color: Colors.white70),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                        ),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        onChanged: (deger) {
                          if (deger.isNotEmpty) {
                            metal = double.parse(deger);
                          } else {
                            metal = 0;
                          }
                          hesapla();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                camKutu(
                  icerik: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Ekolojik Tasarrufunuz',
                        style: GoogleFonts.outfit(fontSize: 22, color: Colors.greenAccent),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Text('🌳 Ağaç: ${agacSayisi.toStringAsFixed(3)} adet', style: const TextStyle(color: Colors.white, fontSize: 16)),
                      const SizedBox(height: 10),
                      Text('💧 Su: ${suMiktari.toStringAsFixed(0)} litre', style: const TextStyle(color: Colors.white, fontSize: 16)),
                      const SizedBox(height: 10),
                      Text('☁️ CO2: ${co2Miktari.toStringAsFixed(1)} kg', style: const TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
