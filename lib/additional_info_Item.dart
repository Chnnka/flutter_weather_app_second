import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String percentage;
  const AdditionalInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 5),
          Text(
            percentage,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
