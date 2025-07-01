// screens/profil/settings_page.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/Home/home.dart';
import 'package:provider/provider.dart';
import 'package:projek_cerminajaib/provider/theme_provider.dart';
import 'package:projek_cerminajaib/screens/profil/tentang.dart';
import 'package:projek_cerminajaib/screens/profil/data_kesehatan_page.dart';
import 'package:projek_cerminajaib/widgets/setting_card_item.dart';
import 'package:projek_cerminajaib/widgets/info_tooltip_icon.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    String selectedLanguage = 'Indonesia';

    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan'), leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        ),),
      
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Akun & Data Kesehatan
          Row(
            children: const [
              Text(
                'Akun & Data Kesehatan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 6),
              InfoTooltipIcon(
                message: 'Data tentang riwayat dan kondisi kesehatan Anda',
              ),
            ],
          ),
          const SizedBox(height: 8),
          SettingCardItem(
            icon: Icons.favorite,
            title: 'Data Kesehatan',
            subtitle: 'Lihat dan kelola rekam medis Anda',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DataKesehatanPage()),
              );
            },
          ),
          const SettingCardItem(
            icon: Icons.history,
            title: 'Riwayat Konsultasi',
            subtitle: 'Lihat riwayat chat dan jadwal dokter',
          ),

          const SizedBox(height: 24),

          // Preferensi Aplikasi
          Row(
            children: const [
              Text(
                'Preferensi Aplikasi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 6),
              InfoTooltipIcon(
                message: 'Pengaturan tema, bahasa, dan notifikasi',
              ),
            ],
          ),
          const SizedBox(height: 8),
          const SettingCardItem(
            icon: Icons.notifications,
            title: 'Notifikasi',
            subtitle: 'Atur pengingat harian & konsultasi',
          ),
          SettingCardItem(
            icon: Icons.dark_mode,
            title: 'Mode Gelap',
            subtitle: 'Aktifkan tampilan malam',
            isSwitch: true,
            switchValue: themeProvider.isDarkMode,
            onSwitchChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
          SettingCardItem(
            icon: Icons.language,
            title: 'Bahasa',
            subtitle: 'Pilih bahasa aplikasi',
            isDropdown: true,
            dropdownValue: selectedLanguage,
            onDropdownChanged: (value) {
              // Tambahkan logika ubah bahasa di sini jika diinginkan
            },
          ),

          const SizedBox(height: 24),

          // Privasi & Bantuan
          Row(
            children: const [
              Text(
                'Privasi & Bantuan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 6),
              InfoTooltipIcon(
                message: 'Kebijakan privasi dan informasi aplikasi',
              ),
            ],
          ),
          const SizedBox(height: 8),
          const SettingCardItem(
            icon: Icons.privacy_tip,
            title: 'Privasi & Keamanan',
            subtitle: 'Atur izin akses data medis Anda',
          ),
          SettingCardItem(
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
            subtitle: 'Versi, pengembang, dan kontak bantuan',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TentangPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
