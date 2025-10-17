import 'package:flutter/material.dart';

class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Aplikasi Inventaris Sarpras dibuat untuk membantu pengelolaan '
            'sarana dan prasarana di lingkungan sekolah.\n\n'
            'Dengan aplikasi ini, proses pencatatan, peminjaman, dan pengembalian '
            'barang menjadi lebih cepat, akurat, dan efisien.\n\n'
            'Versi 1.0.0\n Dibuat oleh siswa RPL SMKN 8 Malang.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
