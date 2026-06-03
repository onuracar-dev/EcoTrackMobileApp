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