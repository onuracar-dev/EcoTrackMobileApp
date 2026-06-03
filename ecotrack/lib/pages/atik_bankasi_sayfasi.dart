import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/video_arka_plan.dart';
import 'dart:ui';

class AtikBankasiSayfasi extends StatefulWidget {
  const AtikBankasiSayfasi({super.key});

  @override
  State<AtikBankasiSayfasi> createState() {
    return _AtikBankasiSayfasiState();
  }
}

class _AtikBankasiSayfasiState extends State<AtikBankasiSayfasi> {
  final List<Map<String, String>> veritabani = [
    { "name": "Pet Şişe", "category": "plastik", "points": "15 Puan/Adet", "desc": "Plastik su/alkolsüz içecek şişeleri ve kapakları." },
    { "name": "Naylon Poşet", "category": "plastik", "points": "5 Puan/Adet", "desc": "Yırtılmamış temiz market poşetleri." },
    { "name": "Karton Koli", "category": "kağıt", "points": "25 Puan/Kg", "desc": "Kuru, katlanmış temiz karton kutular." },
    { "name": "Gazete & Defter", "category": "kağıt", "points": "20 Puan/Kg", "desc": "Okunmuş gazeteler, eski okul defterleri." },
    { "name": "Cam Kavanoz", "category": "cam", "points": "20 Puan/Adet", "desc": "Temizlenmiş boş cam kavanozlar." },
    { "name": "Maden Suyu Şişesi", "category": "cam", "points": "15 Puan/Adet", "desc": "Kırılmamış yeşil/beyaz cam içecek şişeleri." },
    { "name": "Alüminyum Kutu", "category": "metal", "points": "30 Puan/Adet", "desc": "Alüminyum içecek kutuları." },
    { "name": "Konserve Kutusu", "category": "metal", "points": "25 Puan/Adet", "desc": "Temiz yıkanmış konserve ve salça tenekeleri." }
  ];

  List<Map<String, String>> aramaSonuclari = [];

  @override
  void initState() {
    super.initState();
    aramaSonuclari = veritabani;
  }

    void aramaYap(String arananKelime) {
    List<Map<String, String>> geciciListe = [];
    
    if (arananKelime.isEmpty) {
      geciciListe = veritabani;
    } else {
      String kucukHarfliArama = arananKelime.toLowerCase();
      
      for (int i = 0; i < veritabani.length; i++) {
        String isim = veritabani[i]["name"]!.toLowerCase();
        String kategori = veritabani[i]["category"]!.toLowerCase();
        
        if (isim.contains(kucukHarfliArama) || kategori.contains(kucukHarfliArama)) {
          geciciListe.add(veritabani[i]);
        }
      }
    }

    setState(() {
      aramaSonuclari = geciciListe;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoArkaPlan(
        videoYolu: 'assets/videos/bank.mp4',
        icerik: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Atık Bankası',
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Atık türü yazın...',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.black54,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                  ),
                  onChanged: (deger) {
                    aramaYap(deger);
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: aramaSonuclari.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            color: Colors.white.withOpacity(0.1),
                            child: ListTile(
                              title: Text(
                                aramaSonuclari[index]["name"]!,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                aramaSonuclari[index]["desc"]!,
                                style: const TextStyle(color: Colors.white70),
                              ),
                              trailing: Text(
                                aramaSonuclari[index]["points"]!,
                                style: const TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
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
