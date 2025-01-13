import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // AQI box
          box1(
            '40\nดี',
            350.0,
            200.0,
            Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 48,
          ),
          // PM2.5, Temperature, Humidity
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                box(
                  'PM 2.5\n4.9 µg/m³',
                  100.0,
                  100.0,
                  Colors.white,
                  textColor: Colors.black,
                ),
                box(
                  'Temperature\n32 °C',
                  100.0,
                  100.0,
                  Colors.pink,
                  textColor: Colors.white,
                ),
                box(
                  'Humidity\n52 %',
                  100.0,
                  100.0,
                  Colors.blueAccent,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
          // Last update
          const Text(
            "อัปเดตล่าสุด 1 มกราคม 2025",
            style: TextStyle(fontSize: 16),
          ),
          const Text(
            "เวลา 15:00 น.",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          // Recommendation box
          const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: const Text(
                "คำแนะนำ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          box2(
            'คุณภาพอากาศน่าพึงพอใจและไม่มีความเสี่ยง',
            350.0,
            100.0,
            Colors.greenAccent,
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }

  // Box with rounded corners and customizable style
  Widget box1(
      String text,
      double w,
      double h,
      Color color, {
        Color textColor = Colors.black,
        double fontSize = 16,
      }) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
    );
  }

  // Box for recommendation and other smaller boxes
  Widget box2(
      String text,
      double w,
      double h,
      Color color, {
        Color textColor = Colors.black,
        double fontSize = 16,
      }) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Add an icon to the left
          const Icon(
            Icons.eco, // Replace with your desired icon
            color: Colors.green, // Icon color
            size: 36, // Icon size
          ),
          const SizedBox(width: 10), // Spacing between icon and text
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: TextStyle(color: textColor, fontSize: fontSize),
            ),
          ),
        ],
      ),
    );
  }


  // General box widget for PM2.5, Temperature, etc.
  Widget box(
      String text,
      double w,
      double h,
      Color color, {
        Color textColor = Colors.black,
        double fontSize = 14,
      }) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
    );
  }
}