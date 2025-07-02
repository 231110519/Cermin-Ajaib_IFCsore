// screens/Home/doctordetail.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projek_cerminajaib/provider/container_provider.dart';
import 'package:projek_cerminajaib/screens/Home/chat_page.dart';

import 'package:projek_cerminajaib/screens/Home/call_page.dart';

class Doctordetail extends StatelessWidget {
  final String name;
  final String specialty;
  final String description;
  final String imageUrl;
  final double rating;

  const Doctordetail({
    super.key,
    required this.name,
    required this.specialty,
    required this.description,
    required this.imageUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(imageUrl),
            ),
            title: Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(specialty),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                return Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.orange,
                  size: 20,
                );
              }),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Deskripsi'),
            subtitle: Text(description),
          ),
          const Divider(),
          const ListTile(
            title: Text('Jadwal Konsultasi'),
            subtitle: Text('Senin - Jumat: 09:00 AM - 05:00 PM'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.chat, color: Colors.blue),
            title: const Text('Chat dengan Dokter'),
            onTap: () {
              Provider.of<ContainerProvider>(
                context,
                listen: false,
              ).addChatToHistory({
                'type': 'chat',
                'name': name,
                'imageUrl': imageUrl,
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(doctorName: name),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone, color: Colors.green),
            title: const Text('Telepon Dokter'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Konfirmasi'),
                    content: Text('Apakah Anda yakin ingin menelepon Dr. $name?'),
                    actions: [
                      TextButton(
                        child: const Text('Tidak'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Ya'),
                        onPressed: () {
                          Navigator.of(context).pop();

                          Provider.of<ContainerProvider>(
                            context,
                            listen: false,
                          ).addCallToHistory('Telepon ke Dr. $name');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CallPage(doctorName: name),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
