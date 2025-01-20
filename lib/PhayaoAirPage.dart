import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class PhayaoAirPage extends StatefulWidget {
  @override
  _PhayaoAirPageState createState() => _PhayaoAirPageState();
}

class _PhayaoAirPageState extends State<PhayaoAirPage> {
  Map<String, dynamic>? iqAirData;
  Map<String, dynamic>? cmuCCDCData;

  @override
  void initState() {
    super.initState();
    // Set a timer to run fetchDataAndSave every 5 minutes (300 seconds)
    Timer.periodic(Duration(minutes: 5), (Timer t) {
      fetchDataAndSave();
    });

    // Run it once when the app starts
    fetchDataAndSave();
  }

  Future<void> fetchDataAndSave() async {
    try {
      // เรียกใช้ฟังก์ชัน saveDataToFirestore
      await saveDataToFirestore();
    } catch (e) {
      print("Error: $e");
    }
  }

  //ดึงข้อมูล API IQAIR
  Future<Map<String, dynamic>> fetchAirQualityData() async {
    final response = await http.get(
      Uri.parse('http://api.airvisual.com/v2/city?city=Mae Ka&state=Phayao&country=Thailand&key=274c95bd-2bb3-448f-b915-03477f596c5d'),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server does not return a 200 OK response, throw an exception.
      throw Exception('Failed Firebase IQAIR');
    }
  }

  /// ดึงข้อมูลจาก API CMU CCDC
  Future<Map<String, dynamic>> fetchAirQualityDataCMU() async {
    final response = await http.get(
      Uri.parse('https://www.cmuccdc.org/api/ccdc/value/3256'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // แปลง JSON เป็น Map
    } else {
      throw Exception('Failed to fetch data from CMU CCDC');
    }
  }

  Future<void> saveDataToFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // ดึงข้อมูลจากทั้งสอง API
      final iqAirData = await fetchAirQualityData();
      final cmuCCDCData = await fetchAirQualityDataCMU();

      // สร้างเอกสารใน Firestore
      await firestore.collection('air_quality').add({
        // ข้อมูลจาก IQAir API
        'iqair_city': iqAirData['data']['city'],
        'iqair_state': iqAirData['data']['state'],
        'iqair_country': iqAirData['data']['country'],
        'iqair_aqi': iqAirData['data']['current']['pollution']['aqius'],
        'iqair_temperature': iqAirData['data']['current']['weather']['tp'],
        'iqair_humidity': iqAirData['data']['current']['weather']['hu'],

        // ข้อมูลจาก CMU CCDC API
        'cmuccdc_pm25': cmuCCDCData['pm25'],
        'cmuccdc_location': cmuCCDCData['us_title'],
        'cmuccdc_caption': cmuCCDCData['th_caption'],
        'cmuccdc_log_datetime': cmuCCDCData['log_datetime'],

        // บันทึกเวลาที่บันทึกข้อมูลลง Firestore
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("Data saved to Firestore");
    } catch (error) {
      print("Failed to save data to Firestore: $error");
    }
  }

  // Future<void> fetchData() async {
  //   final iqAir = await fetchDataFromIQAir();
  //   final cmuCCDC = await fetchDataFromCMUCCDC();
  //
  //   setState(() {
  //     iqAirData = iqAir;
  //     cmuCCDCData = cmuCCDC;
  //   });
  // }
  //
  // Future<Map<String, dynamic>?> fetchDataFromIQAir() async {
  //   final String apiKey = '274c95bd-2bb3-448f-b915-03477f596c5d'; // ใส่ API Key ของคุณ
  //   final String url = 'http://api.airvisual.com/v2/city?city=Mae Ka&state=Phayao&country=Thailand&key=$apiKey';
  //
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       return data['data']; // ส่งข้อมูลที่ต้องการกลับไป
  //     } else {
  //       print('Error from IQAir API: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error fetching IQAir API: $e');
  //     return null;
  //   }
  // }
  //
  // Future<Map<String, dynamic>?> fetchDataFromCMUCCDC() async {
  //   final String url = 'https://www.cmuccdc.org/api/ccdc/value/3256';
  //
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       return data; // ส่งข้อมูลที่ต้องการกลับไป
  //     } else {
  //       print('Error from CMU CCDC API: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error fetching CMU CCDC API: $e');
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final pages = [
      '/history', // เส้นทางของหน้าประวัติ
      '/', // เส้นทางของหน้าหลัก
      '/more', // เส้นทางของหน้าข้อมูลเพิ่มเติม
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('air_quality')/*.orderBy('timestamp', descending: true)*/.snapshots(), // ชื่อ collection จาก Firestore
        builder: (context, snapshot) {
          // เช็คสถานะการเชื่อมต่อ
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // กำลังโหลดข้อมูล
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Data Found')); // ไม่มีข้อมูล
          }

          // ดึงข้อมูลจาก snapshot
          final data = snapshot.data!.docs.first.data(); // ใช้ข้อมูลจากเอกสารแรกใน collection
          final iqAirData = data; // สมมติว่า Firestore เก็บข้อมูล iqAirData โดยตรง
          final cmuCCDCData = data; // ใช้ข้อมูลเดียวกัน (ถ้าข้อมูลแยกควรใช้ field ที่เหมาะสม)

          return SingleChildScrollView(
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${iqAirData['aqi']}', // เปลี่ยนให้แสดงค่าจาก Firestore
                                style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              const Text(
                                'AQI',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Text(
                            '${cmuCCDCData['us_title']}', // เปลี่ยนให้แสดงค่าจาก Firestore
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
                      value: '${cmuCCDCData['pm25']} µg/m³',
                    ),
                    InfoCard(
                      icon: Icons.thermostat,
                      title: 'Temperature',
                      value: '${cmuCCDCData['temperature']} °C',
                    ),
                    InfoCard(
                      icon: Icons.water_drop,
                      title: 'Humidity',
                      value: '${cmuCCDCData['humidity']} %',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '${cmuCCDCData['log_datetime']}', // ใช้ timestamp จาก Firestore
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
                  padding: const EdgeInsets.all(40),
                  child: Row(
                    children: [
                      const Icon(Icons.person, color: Colors.green, size: 48),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          '${cmuCCDCData['th_caption']}', // แสดงข้อมูลเพิ่มเติม
                          style: const TextStyle(fontSize: 16),
                        ),
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
