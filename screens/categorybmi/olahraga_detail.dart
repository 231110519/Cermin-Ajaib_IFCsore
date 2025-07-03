// screens/CategoryBMI/olahraga_detail.dart
import 'package:flutter/material.dart';

class OlahragaDetail extends StatefulWidget {
  final String category;
  final String bmiStatus;

  const OlahragaDetail({
    super.key,
    required this.category,
    required this.bmiStatus,
  });

  @override
  State<OlahragaDetail> createState() => _OlahragaDetailState();
}

class _OlahragaDetailState extends State<OlahragaDetail> {
  String _difficulty = 'Mudah';
  late List<String> exercises;

  @override
  void initState() {
    super.initState();
    exercises = getExercises(widget.category, widget.bmiStatus, _difficulty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} - Latihan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Tingkat Kesulitan:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _difficulty,
              onChanged: (value) {
                setState(() {
                  _difficulty = value!;
                  exercises = getExercises(
                    widget.category,
                    widget.bmiStatus,
                    _difficulty,
                  );
                });
              },
              items:
                  ['Mudah', 'Sedang', 'Sulit']
                      .map(
                        (difficulty) => DropdownMenuItem<String>(
                          value: difficulty,
                          child: Text(difficulty),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Latihan yang bisa Anda coba:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  return _buildExerciseCard(exercises[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseCard(String exercise) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(exercise, style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  List<String> getExercises(
    String category,
    String bmiStatus,
    String difficulty,
  ) {
    switch (category) {
      case 'Yoga':
        if (bmiStatus == 'UnderWeight') {
          return difficulty == 'Mudah'
              ? ['Yoga untuk relaksasi', 'Latihan pernapasan']
              : difficulty == 'Sedang'
              ? ['Posisi pohon', 'Tree pose']
              : ['Warrior pose', 'Warrior II pose'];
        } else if (bmiStatus == 'Normal') {
          return difficulty == 'Mudah'
              ? ['Cat-cow pose', 'Cobra pose']
              : difficulty == 'Sedang'
              ? ['Warrior pose', 'Triangle pose']
              : ['Chair pose', 'Lotus pose'];
        } else {
          return ['Latihan tidak tersedia'];
        }
      case 'Cardio':
        if (bmiStatus == 'UnderWeight') {
          return difficulty == 'Mudah'
              ? ['Bersepeda santai', 'Jogging ringan']
              : difficulty == 'Sedang'
              ? ['Lari ringan', 'Bersepeda cepat']
              : ['HIIT dengan lompat tali', 'Sprint'];
        } else if (bmiStatus == 'Normal') {
          return difficulty == 'Mudah'
              ? ['Jogging ringan', 'Bersepeda normal']
              : difficulty == 'Sedang'
              ? ['Skipping', 'HIIT (High-intensity interval training)']
              : ['Sprint', 'HIIT berintensitas tinggi'];
        } else {
          return ['Latihan tidak tersedia'];
        }
      case 'Stretching':
        return difficulty == 'Mudah'
            ? ['Quadriceps stretch', 'Hamstring stretch']
            : difficulty == 'Sedang'
            ? ['Triceps stretch', 'Chest stretch']
            : ['Hip flexor stretch', 'Spinal twist'];
      default:
        return ['Latihan tidak tersedia'];
    }
  }
}
