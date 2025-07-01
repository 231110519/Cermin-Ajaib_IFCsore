// widgets/navigation_drawer.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/profil/profil_page.dart';
import 'package:projek_cerminajaib/screens/Home/riwayat_page.dart';
import 'package:projek_cerminajaib/widgets/logout_bottomsheet.dart'; // jangan lupa import ini

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Nama Pengguna'),
            accountEmail: const Text('user@email.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profil.jpg'),
            ),
            decoration: const BoxDecoration(color: Colors.green),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Beranda'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Riwayat'),
            onTap: () {
              Navigator.pop(context); // tutup drawer dulu
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RiwayatPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilPage()),
              );
            },
          ),
          
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context); // tutup drawer dulu
              showLogoutBottomSheet(context); // tampilkan konfirmasi logout
            },
          ),
        ],
      ),
    );
  }
}
