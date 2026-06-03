import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/video_arka_plan.dart';

// Atık noktası verilerini tutmak için basit bir veri modeli
class AtikNoktasi {
  final String isim;
  final LatLng konum;
  final List<String> turler; // Örn: ['Plastik', 'Kağıt', 'Cam', 'Organik']
  final String detay;

  const AtikNoktasi({
    required this.isim,
    required this.konum,
    required this.turler,
    required this.detay,
  });
}

class AtikNoktalariSayfasi extends StatefulWidget {
  const AtikNoktalariSayfasi({super.key});

  @override
  State<AtikNoktalariSayfasi> createState() => _AtikNoktalariSayfasiState();
}

class _AtikNoktalariSayfasiState extends State<AtikNoktalariSayfasi> {
  // Tüm atık noktalarının listesi
  final List<AtikNoktasi> tumNoktalar = const [
    AtikNoktasi(
      isim: 'Atakum Sahil Geri Dönüşüm',
      konum: LatLng(41.3320, 36.2650),
      turler: ['Organik'],
      detay: 'Organik & Gıda Atıkları\nÇalışma: 08:00 - 18:00',
    ),
    AtikNoktasi(
      isim: 'Ömürevleri Mobil İstasyon',
      konum: LatLng(41.3250, 36.2750),
      turler: ['Cam', 'Kağıt', 'Plastik'],
      detay: 'Cam, Kağıt, Plastik\nÇalışma: 08:00 - 18:00',
    ),
  ];

  // Filtre kategorileri
  final List<String> kategoriler = const [
    'Tümü',
    'Plastik',
    'Kağıt',
    'Cam',
    'Organik',
  ];

  // Seçili olan aktif filtre
  String secilenKategori = 'Tümü';

  // Google Haritalar uygulamasını açan basit fonksiyon
  void yolTarifiAc(LatLng konum) async {
    final Uri url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${konum.latitude},${konum.longitude}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }