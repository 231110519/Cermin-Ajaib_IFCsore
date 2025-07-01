// widget/health_setting_item.dart
import 'package:flutter/material.dart';

class HealthSettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSwitch;
  final bool isDropdown;
  final VoidCallback? onTap;

  const HealthSettingItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isSwitch = false,
    this.isDropdown = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.teal),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ),
            if (isSwitch)
              Switch(
                value: true,
                onChanged: (val) {}, // integrasikan nanti
                activeColor: Colors.teal,
              ),
            if (isDropdown)
              DropdownButton<String>(
                value: 'Indonesia',
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down),
                items: const [
                  DropdownMenuItem(
                    value: 'Indonesia',
                    child: Text('Indonesia'),
                  ),
                  DropdownMenuItem(value: 'English', child: Text('English')),
                ],
                onChanged: (val) {},
              ),
          ],
        ),
      ),
    );
  }
}
