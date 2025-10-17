import 'package:flutter/material.dart';

class PengembalianPage extends StatefulWidget {
  const PengembalianPage({super.key});

  @override
  State<PengembalianPage> createState() => _PengembalianPageState();
}

class _PengembalianPageState extends State<PengembalianPage> {
  final TextEditingController _namaPeminjamC = TextEditingController();
  final TextEditingController _namaBarangC = TextEditingController();
  final TextEditingController _tanggalPinjamC = TextEditingController();
  final TextEditingController _tanggalKembaliC = TextEditingController();
  String kondisiBarang = 'Baik';

  final List<Map<String, String>> _dataPengembalian = [];

  void _tambahPengembalian() {
    final nama = _namaPeminjamC.text.trim();
    final barang = _namaBarangC.text.trim();
    final tglPinjam = _tanggalPinjamC.text.trim();
    final tglKembali = _tanggalKembaliC.text.trim();

    if (nama.isEmpty ||
        barang.isEmpty ||
        tglPinjam.isEmpty ||
        tglKembali.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Semua data harus diisi!')));
      return;
    }

    setState(() {
      _dataPengembalian.add({
        'nama': nama,
        'barang': barang,
        'tglPinjam': tglPinjam,
        'tglKembali': tglKembali,
        'kondisi': kondisiBarang,
      });
    });

    _namaPeminjamC.clear();
    _namaBarangC.clear();
    _tanggalPinjamC.clear();
    _tanggalKembaliC.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data pengembalian berhasil ditambahkan!')),
    );
  }

  @override
  void dispose() {
    _namaPeminjamC.dispose();
    _namaBarangC.dispose();
    _tanggalPinjamC.dispose();
    _tanggalKembaliC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengembalian Barang'),
        backgroundColor: const Color.fromARGB(255, 215, 96, 159),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
           
            TextField(
              controller: _namaPeminjamC,
              decoration: const InputDecoration(
                labelText: 'Nama Peminjam',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _namaBarangC,
              decoration: const InputDecoration(
                labelText: 'Nama Barang',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _tanggalPinjamC,
              decoration: const InputDecoration(
                labelText: 'Tanggal Pinjam',
                hintText: 'cth: 10-10-2025',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _tanggalKembaliC,
              decoration: const InputDecoration(
                labelText: 'Tanggal Kembali',
                hintText: 'cth: 13-10-2025',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: kondisiBarang,
              items: const [
                DropdownMenuItem(value: 'Baik', child: Text('Baik')),
                DropdownMenuItem(value: 'Rusak', child: Text('Rusak')),
                DropdownMenuItem(value: 'Hilang', child: Text('Hilang')),
              ],
              decoration: const InputDecoration(
                labelText: 'Kondisi Barang Saat Dikembalikan',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) {
                if (v != null) setState(() => kondisiBarang = v);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _tambahPengembalian,
              icon: const Icon(Icons.add),
              label: const Text('Tambah Pengembalian'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 162, 29, 100),
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 20,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const Text(
              'Riwayat Pengembalian',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _dataPengembalian.isEmpty
                  ? const Center(child: Text('Belum ada data pengembalian.'))
                  : ListView.builder(
                      itemCount: _dataPengembalian.length,
                      itemBuilder: (context, index) {
                        final d = _dataPengembalian[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: const Icon(Icons.assignment_turned_in),
                            title: Text(d['barang']!),
                            subtitle: Text(
                              'Peminjam: ${d['nama']}\nPinjam: ${d['tglPinjam']} | Kembali: ${d['tglKembali']}\nKondisi: ${d['kondisi']}',
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
