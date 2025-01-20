import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PhayaoAirPage extends StatefulWidget {
  @override
  _PhayaoAirPageState createState() => _PhayaoAirPageState();
}


class _PhayaoAirPageState extends State<PhayaoAirPage> {

  // const PhayaoAirPage({super.key});

  Map<String, dynamic>? iqAirData;
  Map<String, dynamic>? cmuCCDCData;

  Future<void> fetchData() async {
    final iqAir = await fetchDataFromIQAir();
    final cmuCCDC = await fetchDataFromCMUCCDC();

    setState(() {
      iqAirData = iqAir;
      cmuCCDCData = cmuCCDC;
    });
  }

  Future<Map<String, dynamic>?> fetchDataFromIQAir() async {
    final String apiKey = '274c95bd-2bb3-448f-b915-03477f596c5d'; // ใส่ API Key ของคุณ
    final String url = 'http://api.airvisual.com/v2/city?city=Mae Ka&state=Phayao&country=Thailand&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']; // ส่งข้อมูลที่ต้องการกลับไป
      } else {
        print('Error from IQAir API: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching IQAir API: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchDataFromCMUCCDC() async {
    final String url = 'https://www.cmuccdc.org/api/ccdc/value/3256';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data; // ส่งข้อมูลที่ต้องการกลับไป
      } else {
        print('Error from CMU CCDC API: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching CMU CCDC API: $e');
      return null;
    }
  }
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Future<void> fetchAndSaveData() async {
  //   final String apiKey = '274c95bd-2bb3-448f-b915-03477f596c5d'; // ใส่ API Key ของคุณ
  //   final String url = 'http://api.airvisual.com/v2/city?city=Mae Ka&state=Phayao&country=Thailand&key=$apiKey';
  //   try {
  //     // ดึงข้อมูลจาก API
  //     final response = await http.get(Uri.parse(url));
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //
  //       // ข้อมูลที่ได้จาก API
  //       final airQualityData = {
  //         "city": data['data']['city'],
  //         "aqi": data['data']['current']['pollution']['aqius'],
  //         "pm25": data['data']['current']['pollution']['pm25'],
  //         "temperature": data['data']['current']['weather']['tp'],
  //         "humidity": data['data']['current']['weather']['hu'],
  //         "timestamp": FieldValue.serverTimestamp(), // เก็บเวลาใน Firestore
  //       };
  //
  //       // บันทึกข้อมูลลง Firestore
  //       await _firestore.collection('air_quality').add(airQualityData);
  //
  //       print('Data saved successfully!');
  //     } else {
  //       print('Failed to fetch data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }



  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      '/history', // เส้นทางของหน้าประวัติ
      '/',        // เส้นทางของหน้าหลัก
      '/more',    // เส้นทางของหน้าข้อมูลเพิ่มเติม
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:const Text(
          'Phayao Air',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/Login');
            },
          ),
        ],
      ),
      body: iqAirData == null || cmuCCDCData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'คุณภาพอากาศ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${iqAirData?['current']['pollution']['aqius']}',
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
                        '${cmuCCDCData?['us_title']}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700]),
                      ),
                    ],
                  ),
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
                  value: '${cmuCCDCData?['pm25']} µg/m³',
                ),
                InfoCard(
                  icon: Icons.thermostat,
                  title: 'Temperature',
                  value: '${cmuCCDCData?['temp']} °C',
                ),
                InfoCard(
                  icon: Icons.water_drop,
                  title: 'Humidity',
                  value: '${cmuCCDCData?['humid']}%',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '${cmuCCDCData?['log_datetime']}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
              padding:const EdgeInsets.all(40),
              child: Row(
                children: [
                  Icon(Icons.person, color: Colors.green, size: 48),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      '${cmuCCDCData?['th_caption']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
              MaterialPageRoute(builder: (context) => PhayaoAirPage()),
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
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}