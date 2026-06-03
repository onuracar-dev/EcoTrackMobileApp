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

  Widget ayarBasligi(String baslik) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 20.0, bottom: 8.0),
      child: Text(
        baslik,
        style: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.greenAccent,
        ),
      ),
    );
  }

  // Tıklanabilir, backend'i olmayan ayar satırları için yardımcı widget
  Widget ayarSatiri({
    required IconData ikon,
    required String baslik,
    String? altBilgi,
    Color renk = Colors.white,
  }) {
    return ListTile(
      leading: Icon(ikon, color: renk == Colors.white ? Colors.greenAccent : renk),
      title: Text(baslik, style: TextStyle(color: renk)),
      subtitle: altBilgi != null ? Text(altBilgi, style: const TextStyle(color: Colors.white60)) : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.white54),
      onTap: () {
        // Backend olmadığı için kullanıcıya bilgi veren küçük bir uyarı gösteriyoruz
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"$baslik" özelliği yakında aktif edilecektir.'),
            backgroundColor: Colors.black87,
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoArkaPlan(
        videoYolu: 'assets/videos/settings.mp4',
        hizalama: const Alignment(-0.45,0.0),
        icerik: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Ayarlar',
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  children: [
                    
                    // --- 1. KATEGORİ: HESAP BİLGİLERİM ---
                    ayarBasligi('Hesap Bilgilerim'),
                    camKutu(
                      icerik: Column(
                        children: [
                          ayarSatiri(
                            ikon: Icons.person,
                            baslik: 'Profil Detayları',
                            altBilgi: 'Ad, Soyad, Profil Resmi',
                          ),
                          const Divider(color: Colors.white12, height: 1),
                          ayarSatiri(
                            ikon: Icons.email,
                            baslik: 'E-posta Değiştir',
                            altBilgi: 'onur@example.com',
                          ),
                          const Divider(color: Colors.white12, height: 1),
                          ayarSatiri(
                            ikon: Icons.phone,
                            baslik: 'Telefon Numarası',
                            altBilgi: '+90 555 555 55 55',
                          ),
                        ],
                      ),
                    ),

                    // --- 2. KATEGORİ: ARAYÜZ TERCİHLERİ ---
                    ayarBasligi('Arayüz Tercihleri'),
                    camKutu(
                      icerik: Column(
                        children: [
                          SwitchListTile(
                            title: const Text('Karanlık Mod', style: TextStyle(color: Colors.white)),
                            subtitle: const Text('Göz sağlığınız için koyu tema', style: TextStyle(color: Colors.white60)),
                            activeThumbColor: Colors.greenAccent,
                            activeTrackColor: Colors.green.withOpacity(0.35),
                            value: karanlikMod,
                            onChanged: (deger) {
                              setState(() {
                                karanlikMod = deger;
                              });
                            },
                          ),
                          const Divider(color: Colors.white12, height: 1),
                          SwitchListTile(
                            title: const Text('Bildirimler', style: TextStyle(color: Colors.white)),
                            subtitle: const Text('Önemli duyurulardan haberdar olun', style: TextStyle(color: Colors.white60)),
                            activeThumbColor: Colors.greenAccent,
                            activeTrackColor: Colors.green.withOpacity(0.35),
                            value: bildirimler,
                            onChanged: (deger) {
                              setState(() {
                                bildirimler = deger;
                              });
                            },
                          ),
                          const Divider(color: Colors.white12, height: 1),
                          SwitchListTile(
                            title: const Text('Otomatik Güncellemeler', style: TextStyle(color: Colors.white)),
                            activeThumbColor: Colors.greenAccent,
                            activeTrackColor: Colors.green.withOpacity(0.35),
                            value: otomatikGuncelleme,
                            onChanged: (deger) {
                              setState(() {
                                otomatikGuncelleme = deger;
                              });
                            },
                          ),
                          const Divider(color: Colors.white12, height: 1),
                          ayarSatiri(
                            ikon: Icons.language,
                            baslik: 'Uygulama Dili',
                            altBilgi: 'Türkçe',
                          ),
                          const Divider(color: Colors.white12, height: 1),
                          ayarSatiri(
                            ikon: Icons.color_lens,
                            baslik: 'Tema Rengi',
                            altBilgi: 'Zümrüt Yeşili (Varsayılan)',
                          ),
                        ],
                      ),
                    ),