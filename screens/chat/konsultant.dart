// screens/chat/konsultant.dart
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:projek_cerminajaib/provider/container_provider.dart';
import 'package:projek_cerminajaib/screens/chat/tambah.dart';

class Konsultant extends StatefulWidget {
  @override
  State<Konsultant> createState() => _KonsultantState();
}

class _KonsultantState extends State<Konsultant> {
  final List<Map<String, dynamic>> favoriteDoctors = [];

  void toggleFavorite(Map<String, dynamic> doctor) {
    final isFavorited = favoriteDoctors.contains(doctor);
    setState(() {
      isFavorited
          ? favoriteDoctors.remove(doctor)
          : favoriteDoctors.add(doctor);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorited
              ? '❌ ${doctor['name']} dihapus dari favorite.'
              : '✅ ${doctor['name']} ditambahkan ke favorite.',
        ),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _bukaDialogTambahDokter() {
    showDialog(
      context: context,
      builder: (_) => Tambah(onDokterAdded: () => setState(() {})),
    );
  }

  Widget buildDoctorList(List<Map<String, dynamic>> data) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final d = data[index];
        final isFav = favoriteDoctors.contains(d);
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.greenAccent),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  d['image'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          d['name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.check_circle,
                          color: Colors.greenAccent,
                          size: 18,
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(d['specialty'], style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 4),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          i < d['rating'] ? Icons.star : Icons.star_border,
                          color: Colors.orange,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.grey,
                ),
                onPressed: () => toggleFavorite(d),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Kontak'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          bottom: TabBar(tabs: [Tab(text: 'Kontak'), Tab(text: 'Favorite')]),
        ),
        body: TabBarView(
          children: [
            buildDoctorList(doctors),
            buildDoctorList(favoriteDoctors),
          ],
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          backgroundColor: Colors.green,
          children: [
            SpeedDialChild(
              child: Icon(Icons.add),
              label: 'Tambah Dokter',
              onTap: _bukaDialogTambahDokter,
            ),
          ],
        ),
      ),
    );
  }
}
