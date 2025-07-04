import 'package:flutter/material.dart';

class PrivasiKeamananPage extends StatefulWidget {
  const PrivasiKeamananPage({super.key});

  @override
  State<PrivasiKeamananPage> createState() => _PrivasiKeamananPageState();
}

class _PrivasiKeamananPageState extends State<PrivasiKeamananPage> {
  bool _enkripsiAktif = true;
  bool _izinBerbagi = false;
  double _tingkatPrivasi = 3;

  void _konfirmasiHapusAkun() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Hapus Akun?'),
            content: const Text(
              'Apakah kamu yakin ingin menghapus akun dan semua datamu secara permanen?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Akun berhasil dihapus')),
                  );
                  // Tambahkan logika hapus akun jika diperlukan
                },
                child: const Text('Hapus', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privasi & Keamanan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Pengaturan Privasi',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),

          // Enkripsi Data
          SwitchListTile(
            title: const Text('Enkripsi Data Medis'),
            subtitle: const Text(
              'Data disimpan dengan enkripsi untuk keamanan ekstra',
            ),
            value: _enkripsiAktif,
            onChanged: (value) {
              setState(() {
                _enkripsiAktif = value;
              });
            },
            secondary: const Tooltip(
              message: 'Meningkatkan keamanan data medis Anda',
              child: Icon(Icons.lock),
            ),
          ),

          // Izin Berbagi Data
          SwitchListTile(
            title: const Text('Izin Berbagi Data'),
            subtitle: const Text('Izinkan dokter melihat data kesehatan Anda'),
            value: _izinBerbagi,
            onChanged: (value) {
              setState(() {
                _izinBerbagi = value;
              });
            },
            secondary: const Tooltip(
              message:
                  'Diperlukan agar dokter dapat memberikan diagnosis lebih baik',
              child: Icon(Icons.share),
            ),
          ),

          const SizedBox(height: 20),
          const Text(
            'Tingkat Privasi',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),

          // Slider tingkat privasi
          Tooltip(
            message:
                'Sesuaikan seberapa banyak data yang dapat digunakan untuk personalisasi',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Slider(
                  value: _tingkatPrivasi,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: 'Level ${_tingkatPrivasi.round()}',
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      _tingkatPrivasi = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Text('Minimal'), Text('Maksimal')],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            icon: const Icon(Icons.delete_forever),
            label: const Text('Hapus Akun'),
            onPressed: _konfirmasiHapusAkun,
          ),
        ],
      ),
    );
  }
}
