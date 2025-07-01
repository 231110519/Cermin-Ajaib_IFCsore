import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projek_cerminajaib/provider/container_provider.dart';
import 'package:projek_cerminajaib/screens/Home/chat_page.dart';

// Data dokter
final List<Map<String, dynamic>> doctors = [
  {
    'name': 'Dr. Fendy Angkasa',
    'image': 'assets/images/category/dokter/fendy.jpg',
  },
  {
    'name': 'Dr. Kendrick Salim',
    'image': 'assets/images/category/dokter/kendrick.jpg',
  },
  {
    'name': 'Dr. Luis Aprilliansen',
    'image': 'assets/images/category/dokter/luis.jpg',
  },
  {
    'name': 'Dr. Fandy Sanusi',
    'image': 'assets/images/category/dokter/fandy.jpg',
  },
  {
    'name': 'Dr. Osfredo',
    'image': 'assets/images/category/dokter/fredo.jpg',
  },
  {
    'name': 'Dr. Kent Denise',
    'image': 'assets/images/category/dokter/kent.jpg',
  },
  {
    'name': 'Dr. Nicky',
    'image': 'assets/images/category/dokter/nicky.jpg',
  },
];

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final history = Provider.of<ContainerProvider>(context).history;

    final chatHistory = history.where((item) => item['type'] == 'chat').toList();
    final callHistory = history.where((item) => item['type'] == 'call').toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat Konsultasi'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.chat), text: 'Chat'),
              Tab(icon: Icon(Icons.phone), text: 'Telepon'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_forever),
              tooltip: 'Hapus Semua Riwayat',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Hapus Semua Riwayat?'),
                    content: const Text('Apakah kamu yakin ingin menghapus semua riwayat?'),
                    actions: [
                      TextButton(
                        child: const Text('Batal'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text('Hapus'),
                        onPressed: () {
                          Provider.of<ContainerProvider>(context, listen: false).clearHistory();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              tooltip: 'Pilih Metode Konsultasi',
              onPressed: () => _showKonsultasiMethodSheet(context),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _buildChatList(context, chatHistory),
            _buildList(context, callHistory, 'Belum ada riwayat telepon'),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList(BuildContext context, List<Map<String, String>> items) {
    if (items.isEmpty) {
      return const Center(child: Text('Belum ada riwayat chat'));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final doctorName = item['name'] ?? '';

        final doctor = doctors.firstWhere(
          (d) => d['name'] == doctorName,
          orElse: () => {'image': 'assets/images/default_avatar.png'},
        );

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(doctor['image']),
            radius: 24,
          ),
          title: Text(doctorName),
          subtitle: const Text('Riwayat chat'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(doctorName: doctorName),
              ),
            );
          },
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Provider.of<ContainerProvider>(context, listen: false)
                  .removeHistoryItemByName(doctorName);
            },
          ),
        );
      },
    );
  }

  Widget _buildList(BuildContext context, List<Map<String, String>> items, String emptyMessage) {
    if (items.isEmpty) {
      return Center(child: Text(emptyMessage));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final description = items[index]['description'] ?? '';
        final type = items[index]['type'] ?? '';
        return ListTile(
          leading: Icon(
            type == 'chat' ? Icons.chat : Icons.phone,
            color: type == 'chat' ? Colors.blue : Colors.green,
          ),
          title: Text(description),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Provider.of<ContainerProvider>(context, listen: false)
                  .removeHistoryItemByDescription(description);
            },
          ),
        );
      },
    );
  }

  void _showKonsultasiMethodSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Konsultasi via Chat'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pilih Konsultasi via Chat')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Konsultasi via Telepon'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pilih Konsultasi via Telepon')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_call),
              title: const Text('Konsultasi via Video Call'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pilih Konsultasi via Video Call')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
