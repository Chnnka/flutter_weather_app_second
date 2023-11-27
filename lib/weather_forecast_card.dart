import 'package:flutter/material.dart';

class WeatherForecastCard extends StatefulWidget {
  const WeatherForecastCard({super.key});

  @override
  State<WeatherForecastCard> createState() => _WeatherForecastCardState();
}

class _WeatherForecastCardState extends State<WeatherForecastCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: const Column(
          children: [
            Text(
              '09:00AM',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Icon(
              Icons.cloud,
              size: 35,
            ),
            SizedBox(height: 5),
            Text(
              '27 °C',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
