import 'package:flutter/material.dart';
import 'tentang_page.dart';
import 'riwayat_page.dart';
import 'login_page.dart';
import 'pengembalian_page.dart';
import 'data_barang_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> _barangList = [
    {'nama': 'Laptop', 'kondisi': 'Baik'},
    {'nama': 'Proyektor', 'kondisi': 'Baik'},
    {'nama': 'Sound', 'kondisi': 'Baik'},
  ];

  final List<Map<String, String>> _riwayatList = [];

  Color _kondisiColor(String? kondisi) {
    switch (kondisi) {
      case 'Baik':
        return Colors.green;
      case 'Rusak':
        return Colors.orange;
      case 'Hilang':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<void> _showTambahDialog() async {
    final TextEditingController namaC = TextEditingController();
    String kondisi = 'Baik';

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text('Tambah Barang'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: namaC,
                      decoration: const InputDecoration(
                        labelText: 'Nama Barang',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: kondisi,
                      items: const [
                        DropdownMenuItem(value: 'Baik', child: Text('Baik')),
                        DropdownMenuItem(value: 'Rusak', child: Text('Rusak')),
                        DropdownMenuItem(
                          value: 'Hilang',
                          child: Text('Hilang'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Kondisi',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) {
                        if (v != null) setState(() => kondisi = v);
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final nama = namaC.text.trim();
                    if (nama.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Nama barang tidak boleh kosong'),
                        ),
                      );
                      return;
                    }
                    Navigator.of(
                      context,
                    ).pop({'nama': nama, 'kondisi': kondisi});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 94, 3, 130),
                  ),
                  child: const Text('Simpan'),
                ),
              ],
            );
          },
        );
      },
    );

    namaC.dispose();
    if (result != null) {
      if (!mounted) return;
      setState(() => _barangList.add(result));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Barang berhasil ditambahkan')),
      );
    }
  }

  Future<void> _showPinjamDialog(int index) async {
    final TextEditingController peminjamC = TextEditingController();

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pinjam "${_barangList[index]['nama']}"'),
        content: TextField(
          controller: peminjamC,
          decoration: const InputDecoration(
            labelText: 'Nama Peminjam',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final peminjam = peminjamC.text.trim();
              if (peminjam.isNotEmpty) {
                Navigator.pop(context, {
                  'nama': _barangList[index]['nama']!,
                  'peminjam': peminjam,
                  'tanggal': DateTime.now().toString().substring(0, 16),
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 9, 9, 9),
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() => _riwayatList.add(result));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Barang "${result['nama']}" dipinjam oleh ${result['peminjam']}',
          ),
        ),
      );
    }
  }

  Future<void> _showHapusDialog(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Yakin ingin menghapus "${_barangList[index]['nama']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final removed = _barangList[index]['nama'];
      setState(() => _barangList.removeAt(index));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Terhapus: $removed')));
    }
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventaris Sarpras'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 213, 72, 171),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 143, 61, 133),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.inventory, color: Colors.white, size: 44),
                  SizedBox(height: 8),
                  Text(
                    'Menu Inventaris',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () => Navigator.pop(context),
            ),

            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Data Barang'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DataBarangPage()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Riwayat Peminjaman'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RiwayatPage(riwayatList: _riwayatList),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.assignment_turned_in),
              title: const Text('Pengembalian Barang'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PengembalianPage()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Tentang'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TentangPage()),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 146, 114, 156),
                  Color.fromARGB(255, 162, 99, 176),
                ],
              ),
            ),
            child: const Text(
              'Daftar Barang',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: _barangList.isEmpty
                ? const Center(child: Text('Belum ada data barang.'))
                : ListView.builder(
                    itemCount: _barangList.length,
                    itemBuilder: (context, index) {
                      final item = _barangList[index];
                      final nama = item['nama'] ?? '-';
                      final kondisi = item['kondisi'] ?? 'Baik';
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 8,
                        ),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: _kondisiColor(kondisi),
                            child: const Icon(
                              Icons.inventory,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            nama,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text('Kondisi: $kondisi'),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.history,
                                  color: Color.fromARGB(255, 132, 124, 133),
                                ),
                                onPressed: () => _showPinjamDialog(index),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _showHapusDialog(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showTambahDialog,
        backgroundColor: const Color.fromARGB(255, 213, 188, 201),
        tooltip: 'Tambah Barang',
        child: const Icon(Icons.add),
      ),
    );
  }
}
