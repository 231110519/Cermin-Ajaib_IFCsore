// screens/chat/tambah.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/provider/container_provider.dart';

class Tambah extends StatefulWidget {
  final VoidCallback onDokterAdded;

  const Tambah({super.key, required this.onDokterAdded});

  @override
  State<Tambah> createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  String name = '';
  String specialty = '';
  int rating = 0;
  String image = 'assets/images/default.jpg';
  bool isLoading = false;

  void _simpanDokter() async {
    if (name.isEmpty || specialty.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Nama dan Spesialis tidak boleh kosong')),
      );
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 2)); // Simulasi loading

    doctors.add({
      'name': name,
      'specialty': specialty,
      'rating': rating.clamp(0, 5),
      'image': image,
    });

    setState(() => isLoading = false);
    widget.onDokterAdded();
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('✅ Dokter berhasil ditambahkan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tambah Dokter'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nama Dokter'),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Spesialis'),
              onChanged: (value) => specialty = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Rating (0-5)'),
              keyboardType: TextInputType.number,
              onChanged: (value) => rating = int.tryParse(value) ?? 0,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Path Gambar'),
              onChanged: (value) {
                if (value.trim().isNotEmpty) image = value;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Batal'),
        ),
        ElevatedButton(
          onPressed: isLoading ? null : _simpanDokter,
          child: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text('Simpan'),
        ),
      ],
    );
  }
}
