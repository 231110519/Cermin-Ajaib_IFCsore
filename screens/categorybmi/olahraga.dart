// screens/CategoryBMI/olahraga.dart

import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/CategoryBMI/olahraga_detail.dart';

class Olahraga extends StatefulWidget {
  final String bmiStatus;

  const Olahraga({super.key, required this.bmiStatus});

  @override
  State<Olahraga> createState() => _OlahragaState();
}

class _OlahragaState extends State<Olahraga> {
  String? selectedCategory;

  final List<Map<String, String>> categories = [
    {'name': 'Yoga', 'icon': '🧘'},
    {'name': 'Cardio', 'icon': '🏃'},
    {'name': 'Stretching', 'icon': '🤸'},
    {'name': 'Strength', 'icon': '🏋️'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Jenis Olahraga'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Silakan pilih jenis olahraga yang ingin dilakukan:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children:
                    categories.map((item) {
                      final isSelected = selectedCategory == item['name'];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = item['name'];
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? Colors.greenAccent
                                    : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              if (isSelected)
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.5),
                                  blurRadius: 6,
                                  offset: const Offset(2, 4),
                                ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item['icon']!,
                                style: const TextStyle(fontSize: 48),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item['name']!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  selectedCategory == null
                      ? null
                      : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => OlahragaDetail(
                                  category: selectedCategory!,
                                  bmiStatus: widget.bmiStatus,
                                ),
                          ),
                        );
                      },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
