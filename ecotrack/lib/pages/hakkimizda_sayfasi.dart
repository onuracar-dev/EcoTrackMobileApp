import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/video_arka_plan.dart';
import 'dart:ui';

class HakkimizdaSayfasi extends StatefulWidget {
  const HakkimizdaSayfasi({super.key});

  @override
  State<HakkimizdaSayfasi> createState() => _HakkimizdaSayfasiState();
}

class _HakkimizdaSayfasiState extends State<HakkimizdaSayfasi> {
  // Form alanları için controller'lar (Metin denetleyicileri)
  final TextEditingController _isimController = TextEditingController();
  final TextEditingController _epostaController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();
  final TextEditingController _mesajController = TextEditingController();

  @override
  void dispose() {
    // Bellek sızıntısını önlemek için controller'ları kapatıyoruz
    _isimController.dispose();
    _epostaController.dispose();
    _telefonController.dispose();
    _mesajController.dispose();
    super.dispose();
  }

  // Gönder butonuna basıldığında çalışan fonksiyon
  void _formuGonder() {
    final String isim = _isimController.text.trim();
    final String eposta = _epostaController.text.trim();
    final String telefon = _telefonController.text.trim();
    final String mesaj = _mesajController.text.trim();

    // Basit bir boş alan kontrolü
    if (isim.isEmpty || eposta.isEmpty || telefon.isEmpty || mesaj.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen tüm alanları doldurunuz!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Başarılı bildirim mesajı
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Teşekkürler $isim! Şikayet ve öneriniz başarıyla alındı.'),
        backgroundColor: Colors.green,
      ),
    );

    // Formu temizle
    _isimController.clear();
    _epostaController.clear();
    _telefonController.clear();
    _mesajController.clear();
  }

  // Ortak şeffaf (cam) bilgi kutusu widget'ı
  Widget camKutu({required String baslik, required String icerik}) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                baslik,
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                icerik,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Giriş alanları için ortak şeffaf tasarım widget'ı
  Widget girdiAlani({
    required TextEditingController controller,
    required String etiket,
    required IconData ikon,
    int maxSatir = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        maxLines: maxSatir,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: etiket,
          labelStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(ikon, color: Colors.greenAccent),
          filled: true,
          fillColor: Colors.black38,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white24, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.greenAccent, width: 2),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoArkaPlan(
        videoYolu: 'assets/videos/about.mp4',
        hizalama: const Alignment(0.5, 0.0),
        icerik: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'Hakkımızda',
                    style: GoogleFonts.outfit(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                camKutu(
                  baslik: 'Biz Kimiz?',
                  icerik: 'EcoTrack, çevre dostu yaşam tarzını destekleyen bir platformdur. Misyonumuz, insanların çevre üzerindeki etkisini azaltmalarına yardımcı olmaktır.',
                ),
                const SizedBox(height: 15),
                camKutu(
                  baslik: 'Vizyonumuz',
                  icerik: 'Gelecekte, herkesin sürdürülebilir bir yaşam tarzını benimseyerek gezegenimizi koruduğu bir dünya hayal ediyoruz.',
                ),
                const SizedBox(height: 15),
                camKutu(
                  baslik: 'Değerlerimiz',
                  icerik: 'Çevre bilinci, topluluk desteği ve sürekli gelişim, EcoTrack\'in temel değerleridir.',
                ),
                const SizedBox(height: 25),

                // İletişim Formu Başlığı
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'İletişim & Öneri Formu',
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),