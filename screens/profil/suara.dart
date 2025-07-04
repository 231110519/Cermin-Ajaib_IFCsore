// screens/profil/suara.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/profil/settings_page.dart';

class Suara extends StatefulWidget {
  @override
  _SuaraState createState() => _SuaraState();
}

class _SuaraState extends State<Suara> {
  double mediaVolume = 30;
  double ringtoneVolume = 40;
  double notificationVolume = 0;
  double alarmVolume = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // putih plong
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(
          'Pengaturan suara',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _motivationalBanner(),
          SizedBox(height: 16),
          _sliderCard(
            label: "Musik Relaksasi",
            value: mediaVolume,
            iconOn: Icons.self_improvement,
            iconOff: Icons.volume_off,
            onChanged: (v) => setState(() => mediaVolume = v),
          ),
          _sliderCard(
            label: "Notifikasi News",
            value: ringtoneVolume,
            iconOn: Icons.notifications_active,
            iconOff: Icons.notifications_off,
            onChanged: (v) => setState(() => ringtoneVolume = v),
          ),
          _sliderCard(
            label: "Notifikasi Harian",
            value: notificationVolume,
            iconOn: Icons.notifications,
            iconOff: Icons.notifications_off,
            onChanged: (v) => setState(() => notificationVolume = v),
          ),
          _sliderCard(
            label: "Alarm Pengingat",
            value: alarmVolume,
            iconOn: Icons.alarm_on,
            iconOff: Icons.alarm_off,
            onChanged: (v) => setState(() => alarmVolume = v),
          ),
        ],
      ),
    );
  }

  Widget _motivationalBanner() => Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 2,
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.spa, color: Colors.black, size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              '“Kesehatan dimulai dari ketenangan batin.”',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _sliderCard({
    required String label,
    required double value,
    required IconData iconOn,
    required IconData iconOff,
    required ValueChanged<double> onChanged,
  }) {
    IconData currentIcon = value > 0 ? iconOn : iconOff;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(currentIcon, color: Colors.black),
                SizedBox(width: 12),
                Expanded(child: Text(label, style: TextStyle(fontSize: 16))),
                Text('${value.toInt()}'),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.black,
                inactiveTrackColor: Colors.black26,
                thumbColor: Colors.black,
                overlayColor: Colors.black12,
                valueIndicatorColor: Colors.black,
                showValueIndicator: ShowValueIndicator.always,
                valueIndicatorTextStyle: TextStyle(color: Colors.white),
              ),
              child: Slider(
                value: value,
                onChanged: onChanged,
                min: 0,
                max: 100,
                divisions: 100,
                label: value.round().toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
