import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // กล่องคุณภาพอากาศ
          Container(
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'คุณภาพอากาศ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          '40',
                          style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                        Text(
                          'AQI',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                     Text(
                      'ดี',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // การ์ดแสดงข้อมูล
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              InfoCard(
                icon: Icons.cloud,
                title: 'PM 2.5',
                value: '4.9 µg/m³',
              ),
              InfoCard(
                icon: Icons.thermostat,
                title: 'Temperature',
                value: '32 °C',
              ),
              InfoCard(
                icon: Icons.water_drop,
                title: 'Humidity',
                value: '52%',
              ),
            ],
          ),
          const SizedBox(height: 16),

          // คำแนะนำ
          Container(
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: const Row(
              children: [
                Icon(Icons.person, color: Colors.green, size: 48),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'คุณภาพอากาศน่าพึงพอใจและไม่มีความเสี่ยง',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// การ์ดแสดงข้อมูลย่อย
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.blue),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
