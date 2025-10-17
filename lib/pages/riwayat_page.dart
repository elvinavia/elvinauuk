import 'package:flutter/material.dart';

class RiwayatPage extends StatelessWidget {
  final List<Map<String, String>> riwayatList;

  const RiwayatPage({super.key, required this.riwayatList});

  @override
  Widget build(BuildContext context) {
    if (riwayatList.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat Peminjaman'),
          backgroundColor: const Color.fromARGB(255, 166, 135, 219),
        ),
        body: const Center(child: Text('Belum ada riwayat peminjaman.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Peminjaman'),
        backgroundColor: const Color.fromARGB(255, 230, 113, 202),
      ),
      body: ListView.builder(
        itemCount: riwayatList.length,
        itemBuilder: (context, index) {
          final item = riwayatList[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.history, color: Colors.purple),
              title: Text(item['nama'] ?? 'Barang tidak diketahui'),
              subtitle: Text('Peminjam: ${item['peminjam'] ?? '-'}'),
              trailing: Text(item['tanggal'] ?? '-'),
            ),
          );
        },
      ),
    );
  }
}
