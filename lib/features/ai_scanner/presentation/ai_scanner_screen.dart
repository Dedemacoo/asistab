import 'package:flutter/material.dart';

class AiScannerScreen extends StatelessWidget {
  const AiScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Kamera arkaplanı
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Belge Tara', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          // Kamera View (Örnek boşluk)
          Center(
            child: Icon(Icons.camera_alt, color: Colors.white.withOpacity(0.2), size: 100),
          ),
          
          // Çerçeve
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),

          // Alt menü
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(bottom: 50, top: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.black.withOpacity(0.0)],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo_library, color: Colors.white, size: 32),
                    onPressed: () {},
                  ),
                  GestureDetector(
                    onTap: () {
                      // Fotoğraf çek ve AI analizine yolla
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: Center(
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.flash_off, color: Colors.white, size: 32),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
