// screens/profil/profil_page.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/Home/home.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String _selectedGender = 'Laki-laki';
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Home()),
            );
          },
        ),
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            child: ClipOval(
              child: Image.asset(
                'assets/images/category/profile/user.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Nama Pengguna',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Center(
            child: Text('user@email.com', style: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(height: 24),
          const Text(
            'Jenis Kelamin',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RadioListTile<String>(
            title: const Text('Laki-laki'),
            value: 'Laki-laki',
            groupValue: _selectedGender,
            onChanged: (value) => setState(() => _selectedGender = value!),
          ),
          RadioListTile<String>(
            title: const Text('Perempuan'),
            value: 'Perempuan',
            groupValue: _selectedGender,
            onChanged: (value) => setState(() => _selectedGender = value!),
          ),
          const SizedBox(height: 16),
          const Text(
            'Tanggal Lahir',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(
              hintText: '01/01/2000',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_today),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Deskripsi Diri',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _descriptionController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Ceritakan tentang diri Anda...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const Home()),
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Keluar / Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
