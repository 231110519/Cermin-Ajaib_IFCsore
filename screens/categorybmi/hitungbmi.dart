// screens/CategoryBMI/hitungbmi.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/CategoryBMI/diet.dart';
import 'package:projek_cerminajaib/screens/CategoryBMI/olahraga.dart';

class Hitungbmi extends StatefulWidget {
  const Hitungbmi({super.key});

  @override
  State<Hitungbmi> createState() => OlahragaBMI();
}

class OlahragaBMI extends State<Hitungbmi> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String _gender = 'Pria';
  double? _bmi;
  String _status = "";
  String _recommendation = "";

  void _calculateBMI() {
    final h = double.tryParse(_heightController.text);
    final w = double.tryParse(_weightController.text);
    if (h == null || w == null || h <= 0) return;

    final bmi = w / ((h / 100) * (h / 100));
    String status, recommendation;

    if (bmi < 18.5) {
      status = "UnderWeight";
      recommendation = "Tambah massa otot & konsumsi kalori sehat.";
    } else if (bmi < 24.9) {
      status = "Normal";
      recommendation = "Pertahankan gaya hidup sehat & olahraga.";
    } else if (bmi < 29.9) {
      status = "OverWeight";
      recommendation = "Turunkan berat dengan olahraga & diet.";
    } else if (bmi < 34.9) {
      status = "Obesitas";
      recommendation = "Turunkan berat dengan olahraga & diet.";
    } else {
      status = "Extremely Obese"; 
      recommendation = "Fokus pada pembakaran kalori & pola makan sehat.";
    }

    setState(() {
      _bmi = bmi;
      _status = status;
      _recommendation = recommendation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hitung BMI"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Image.asset(
              'assets/images/category/BMI/beratnormal.jpeg',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _gender,
              decoration: InputDecoration(
                labelText: "Gender",
                prefixIcon: Icon(Icons.person, color: Colors.greenAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items:
                  ['Pria', 'Wanita']
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
              onChanged: (val) => setState(() => _gender = val!),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Tinggi Badan (cm)",
                prefixIcon: Icon(Icons.height, color: Colors.greenAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Berat Badan (kg)",
                prefixIcon: Icon(
                  Icons.monitor_weight,
                  color: Colors.greenAccent,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _calculateBMI,
              icon: const Icon(Icons.calculate),
              label: const Text("Hitung BMI"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_bmi != null)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.green[50],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BMI Anda: ${_bmi!.toStringAsFixed(1)}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Status: $_status",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(_recommendation, textAlign: TextAlign.left),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 10,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          Olahraga(bmiStatus: _status), 
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.fitness_center,
                              color: Colors.greenAccent,
                            ),
                            label: const Text("Olahraga"),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DietPlannerPage(),
                                ),
                              );
                            },
                            icon: Icon(Icons.restaurant_menu),
                            label: Text('Lihat Diet'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
