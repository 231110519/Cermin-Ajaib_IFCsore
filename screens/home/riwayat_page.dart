import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projek_cerminajaib/provider/container_provider.dart';
import 'package:projek_cerminajaib/screens/Home/chat_page.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  static const chatType = 'chat';
  static const callType = 'call';

  @override
  Widget build(BuildContext context) {
    final history = context.watch<ContainerProvider>().history;
    final chatHistory = _filterHistory(history, chatType);
    final callHistory = _filterHistory(history, callType);

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
              onPressed: () => _showDeleteConfirmation(context),
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
            _ChatHistoryList(chatHistory: chatHistory),
            _GenericHistoryList(items: callHistory, emptyMessage: 'Belum ada riwayat telepon'),
          ],
        ),
      ),
    );
  }

  List<Map<String, String>> _filterHistory(List<Map<String, String>> history, String type) {
    return history.where((item) => item['type'] == type).toList();
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Semua Riwayat?'),
        content: const Text('Apakah kamu yakin ingin menghapus semua riwayat?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              context.read<ContainerProvider>().clearHistory();
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _showKonsultasiMethodSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Wrap(
        children: [
          _buildKonsultasiTile(context, Icons.chat, 'Konsultasi via Chat'),
          _buildKonsultasiTile(context, Icons.phone, 'Konsultasi via Telepon'),
          _buildKonsultasiTile(context, Icons.video_call, 'Konsultasi via Video Call'),
        ],
      ),
    );
  }

  ListTile _buildKonsultasiTile(BuildContext context, IconData icon, String label) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pilih $label')));
      },
    );
  }
}

// Widget: Daftar riwayat chat
class _ChatHistoryList extends StatelessWidget {
  final List<Map<String, String>> chatHistory;

  const _ChatHistoryList({required this.chatHistory});

  static final doctors = [
    {'name': 'Dr. Fendy Angkasa', 'image': 'assets/images/category/dokter/fendy.jpg'},
    {'name': 'Dr. Kendrick Salim', 'image': 'assets/images/category/dokter/kendrick.jpg'},
    {'name': 'Dr. Luis Aprilliansen', 'image': 'assets/images/category/dokter/luis.jpg'},
    {'name': 'Dr. Fandy Sanusi', 'image': 'assets/images/category/dokter/fandy.jpg'},
    {'name': 'Dr. Osfredo', 'image': 'assets/images/category/dokter/fredo.jpg'},
    {'name': 'Dr. Kent Denise', 'image': 'assets/images/category/dokter/kent.jpg'},
    {'name': 'Dr. Nicky', 'image': 'assets/images/category/dokter/nicky.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    if (chatHistory.isEmpty) {
      return const Center(child: Text('Belum ada riwayat chat'));
    }

    return ListView.separated(
      itemCount: chatHistory.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final item = chatHistory[index];
        final name = item['name'] ?? '';
        final doctor = doctors.firstWhere(
          (d) => d['name'] == name,
          orElse: () => {'image': 'assets/images/default_avatar.png'},
        );

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(doctor['image']!),
            radius: 24,
          ),
          title: Text(name),
          subtitle: const Text('Riwayat chat'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ChatPage(doctorName: name)),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<ContainerProvider>().removeHistoryItemByName(name);
            },
          ),
        );
      },
    );
  }
}

// Widget: Daftar riwayat selain chat (telepon, dll)
class _GenericHistoryList extends StatelessWidget {
  final List<Map<String, String>> items;
  final String emptyMessage;

  const _GenericHistoryList({required this.items, required this.emptyMessage});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(child: Text(emptyMessage));
    }

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final item = items[index];
        final desc = item['description'] ?? '';
        final type = item['type'] ?? '';

        return ListTile(
          leading: Icon(
            type == 'chat' ? Icons.chat : Icons.phone,
            color: type == 'chat' ? Colors.blue : Colors.green,
          ),
          title: Text(desc),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<ContainerProvider>().removeHistoryItemByDescription(desc);
            },
          ),
        );
      },
    );
  }
}
