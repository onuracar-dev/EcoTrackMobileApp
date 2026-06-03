import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/video_arka_plan.dart';

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoArkaPlan(
        videoYolu: 'assets/videos/home.mp4',
        icerik: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gelecek Dönüşümle Başlar',
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Atıklarınızı değer katan birer enerjiye dönüştürün',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
