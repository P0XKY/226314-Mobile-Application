import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class LoginPhayaoAirPage extends StatefulWidget {
  @override
  _LoginPhayaoAirPageState createState() => _LoginPhayaoAirPageState();
}

class _LoginPhayaoAirPageState extends State<LoginPhayaoAirPage> {
  // Map<String, dynamic>? iqAirData;
  // Map<String, dynamic>? cmuCCDCData;


  Color getAqiColor(int aqi) {
    if (aqi <= 50) {
      return Colors.green;
    } else if (aqi <= 100) {
      return Colors.yellow;
    } else if (aqi <= 150) {
      return Colors.orange;
    } else if (aqi <= 200) {
      return Colors.red;
    } else {
      return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      '/Loginhistory',
      '/LoginPhayaoAirPage',
      '/Loginmore',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Phayao Air',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.grey),
        elevation: 0,
        automaticallyImplyLeading: false, // ปิดปุ่มย้อนกลับใน AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.grey),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
          .collection('air_quality')
          .orderBy('timestamp', descending: true) // จัดเรียงตามฟิลด์ timestamp จากใหม่ไปเก่า
          .limit(1) // จำกัดให้ดึงเอกสารล่าสุดเพียง 1 รายการ
          .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Data Found'));
          }

          final data = snapshot.data!.docs.first.data();
          final iqAirData = data;
          final cmuCCDCData = data;

          int aqi = iqAirData['iqair_aqi'] ?? 0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // AQI Card with Gradient Background
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        getAqiColor(aqi).withOpacity(0.4),
                        getAqiColor(aqi),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5), // Border color with opacity
                      width: 0.5, // Border width
                    ),
                  ),
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: const Text(
                          'คุณภาพอากาศ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center, // จัดตำแหน่งในแนวแกนขวางให้อยู่กึ่งกลาง
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // เว้นระยะห่างระหว่างคอลัมน์
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${iqAirData['iqair_aqi']}',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: getAqiColor(aqi), // สีขึ้นกับค่าที่ส่งมา
                                ),
                              ),
                              const SizedBox(height: 4), // เพิ่มช่องว่างระหว่างข้อความ
                              const Text(
                                'AQI',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16), // เพิ่มช่องว่างระหว่าง Column และข้อความ
                          Expanded(
                            child: Text(
                              '${cmuCCDCData['cmuccdc_location']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InfoCard(
                      icon: Icons.cloud,
                      title: 'PM 2.5',
                      value: '${cmuCCDCData['cmuccdc_pm25']} µg/m³',
                    ),
                    InfoCard(
                      icon: Icons.thermostat,
                      title: 'Temp',
                      value: '${cmuCCDCData['iqair_temperature']} °C',
                    ),
                    InfoCard(
                      icon: Icons.water_drop,
                      title: 'Humidity',
                      value: '${cmuCCDCData['iqair_humidity']} %',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '${cmuCCDCData['cmuccdc_log_datetime']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),

                const SizedBox(height: 16),
                // Footer Section with Gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        getAqiColor(aqi).withOpacity(0.6),
                        getAqiColor(aqi).withOpacity(1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 0.5,
                    ),
                  ),
                  margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [Text("คำแนะนำ"),
                      Row(
                        children: [
                          const Icon(Icons.person, color: Colors.green, size: 48),
                          const SizedBox(width: 60),
                          Expanded(
                            child: Text(
                              '${cmuCCDCData['cmuccdc_caption']}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'ประวัติ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'เพิ่มเติม',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPhayaoAirPage()),
                  (route) => false,
            );
          } else {
            Navigator.pushNamed(context, pages[index]);
          }
        },
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  InfoCard({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5), // Border color with opacity
          width: 0.5, // Border width
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.blue),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
