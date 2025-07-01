// widgets/doctorlist.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/Home/doctordetail.dart';
import 'package:projek_cerminajaib/provider/container_provider.dart'; // untuk akses ke 'doctors'

class DoctorList extends StatelessWidget {
  final String specialty;

  const DoctorList({super.key, required this.specialty});

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = doctors
        .where((doc) => doc['specialty'] == specialty)
        .toList();

    if (filteredDoctors.isEmpty) {
      return const Center(child: Text('Tidak ada dokter tersedia.'));
    }

    return ListView.builder(
      itemCount: filteredDoctors.length,
      itemBuilder: (context, index) {
        final doctor = filteredDoctors[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.greenAccent),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  doctor['image'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          doctor['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.greenAccent,
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor['specialty'],
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(5, (starIndex) {
                        return Icon(
                          starIndex < doctor['rating']
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.orange,
                          size: 18,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.greenAccent,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Doctordetail(
                        name: doctor['name'],
                        specialty: doctor['specialty'],
                        description: doctor['description'],
                        imageUrl: doctor['image'],
                        rating: doctor['rating'],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
