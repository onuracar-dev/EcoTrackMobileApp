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

    @override
  Widget build(BuildContext context) {
    // Seçilen kategoriye göre noktaları filtrele
    List<AtikNoktasi> filtrelenmisNoktalar = [];
    
    if (secilenKategori == 'Tümü') {
      // Eğer "Tümü" seçiliyse, listedeki her şeyi göster
      filtrelenmisNoktalar = tumNoktalar;
    } else {
      // Değilse, sadece seçilen kategoriyi içeren noktaları göster
      for (var nokta in tumNoktalar) {
        if (nokta.turler.contains(secilenKategori)) {
          filtrelenmisNoktalar.add(nokta);
        }
      }
    }

    // Filtrelenmiş noktalardan harita marker'larını (harita ikonlarını) oluştur
    List<Marker> haritaIsaretleri = [];
    for (var nokta in filtrelenmisNoktalar) {
      haritaIsaretleri.add(
        Marker(
          point: nokta.konum,
          child: const Icon(
            Icons.location_on,
            color: Colors.green,
            size: 40,
          ),
        ),
      );
    }

    return Scaffold(
      body: VideoArkaPlan(
        videoYolu: 'assets/videos/maps.mp4',
        icerik: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Atık Noktaları',
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              
              // Kategori Filtre Butonları (Yatay Kaydırılabilir)
              Container(
                height: 45,
                margin: const EdgeInsets.only(bottom: 16.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: kategoriler.length,
                  itemBuilder: (context, index) {
                    String kategori = kategoriler[index];
                    bool aktifMi = (secilenKategori == kategori);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          secilenKategori = kategori;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          // Aktif olana göre farklı renk ve saydamlık (Cam tasarımı)
                          color: aktifMi 
                              ? Colors.green.withOpacity(0.35) 
                              : Colors.black45,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: aktifMi ? Colors.greenAccent : Colors.white24,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            kategori,
                            style: TextStyle(
                              color: aktifMi ? Colors.white : Colors.white70,
                              fontWeight: aktifMi ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Harita Alanı
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white24, width: 2),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: FlutterMap(
                    options: const MapOptions(
                      initialCenter: LatLng(41.3284, 36.2699),
                      initialZoom: 14.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
                        subdomains: const ['a', 'b', 'c', 'd'],
                        userAgentPackageName: 'com.example.ecotrack',
                      ),
                      MarkerLayer(
                        markers: haritaIsaretleri,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Alt Kısımdaki Detay Kartları Listesi
              Expanded(
                flex: 1,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: filtrelenmisNoktalar.length,
                  itemBuilder: (context, index) {
                    final nokta = filtrelenmisNoktalar[index];
                    return Card(
                      color: Colors.black54,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        leading: const Icon(Icons.location_on, color: Colors.greenAccent),
                        title: Text(nokta.isim, style: const TextStyle(color: Colors.white)),
                        subtitle: Text(nokta.detay, style: const TextStyle(color: Colors.white70)),
                        trailing: IconButton(
                          icon: const Icon(Icons.directions, color: Colors.greenAccent),
                          onPressed: () {
                            yolTarifiAc(nokta.konum);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
