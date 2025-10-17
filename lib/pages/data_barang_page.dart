import 'package:flutter/material.dart';

class DataBarangPage extends StatefulWidget {
  const DataBarangPage({super.key});

  @override
  State<DataBarangPage> createState() => _DataBarangPageState();
}

class _DataBarangPageState extends State<DataBarangPage> {
  final List<Map<String, String>> _barangList = [
    {'nama': 'Laptop', 'kondisi': 'Baik', 'tanggal': '12-10-2025'},
    {'nama': 'Proyektor', 'kondisi': 'Baik', 'tanggal': '13-10-2025'},
    {'nama': 'Speaker', 'kondisi': 'Rusak', 'tanggal': '13-10-2025'},
    {'nama': 'Kabel HDMI', 'kondisi': 'Baik', 'tanggal': '14-10-2025'},
    {'nama': 'Kursi Guru', 'kondisi': 'Baik', 'tanggal': '14-10-2025'},
  ];

  final TextEditingController _namaC = TextEditingController();
  final TextEditingController _kondisiC = TextEditingController();
  final TextEditingController _tanggalC = TextEditingController();


  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        String formatted =
            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
        _tanggalC.text = formatted;
      });
    }
  }

  void _tambahBarang() {
    final nama = _namaC.text.trim();
    final kondisi = _kondisiC.text.trim();
    final tanggal = _tanggalC.text.trim();

    if (nama.isNotEmpty && kondisi.isNotEmpty && tanggal.isNotEmpty) {
      setState(() {
        _barangList.add({'nama': nama, 'kondisi': kondisi, 'tanggal': tanggal});
      });
      _namaC.clear();
      _kondisiC.clear();
      _tanggalC.clear();
      Navigator.pop(context);
    }
  }

  void _showTambahDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Barang'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _namaC,
                decoration: const InputDecoration(labelText: 'Nama Barang'),
              ),
              TextField(
                controller: _kondisiC,
                decoration: const InputDecoration(labelText: 'Kondisi Barang'),
              ),
              TextField(
                controller: _tanggalC,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Tanggal',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => _pilihTanggal(context),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: _tambahBarang,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  void _hapusBarang(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Barang'),
          content: Text(
            'Apakah kamu yakin ingin menghapus barang "${_barangList[index]['nama']}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _barangList.removeAt(index);
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Barang Sarpras'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: _barangList.length,
        itemBuilder: (context, index) {
          final barang = _barangList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.inventory_2, color: Colors.teal),
              title: Text(barang['nama'] ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kondisi: ${barang['kondisi']}'),
                  Text('Tanggal: ${barang['tanggal']}'),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () => _hapusBarang(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: _showTambahDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
