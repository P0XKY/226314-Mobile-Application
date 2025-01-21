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
    Timer.periodic(Duration(minutes: 60), (Timer t) {
      fetchDataAndSave();
    });
    fetchDataAndSave();
  }

  Future<void> fetchDataAndSave() async {
    try {
      await saveDataToFirestore();
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<Map<String, dynamic>> fetchAirQualityData() async {
    final response = await http.get(
      Uri.parse('http://api.airvisual.com/v2/city?city=Mae Ka&state=Phayao&country=Thailand&key=e22157db-193f-40df-ae76-a54c7844953e'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed Firebase IQAIR');
    }
  }

  Future<Map<String, dynamic>> fetchAirQualityDataCMU() async {
    final response = await http.get(
      Uri.parse('https://www.cmuccdc.org/api/ccdc/value/3256'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch data from CMU CCDC');
    }
  }

  Future<void> saveDataToFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final iqAirData = await fetchAirQualityData();
      final cmuCCDCData = await fetchAirQualityDataCMU();

      await firestore.collection('air_quality').add({
        'iqair_city': iqAirData['data']['city'],
        'iqair_state': iqAirData['data']['state'],
        'iqair_country': iqAirData['data']['country'],
        'iqair_aqi': iqAirData['data']['current']['pollution']['aqius'],
        'iqair_temperature': iqAirData['data']['current']['weather']['tp'],
        'iqair_humidity': iqAirData['data']['current']['weather']['hu'],
        'cmuccdc_pm25': cmuCCDCData['pm25'],
        'cmuccdc_location': cmuCCDCData['us_title'],
        'cmuccdc_caption': cmuCCDCData['th_caption'],
        'cmuccdc_log_datetime': cmuCCDCData['log_datetime'],
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Data saved to Firestore");
    } catch (error) {
      print("Failed to save data to Firestore: $error");
    }
  }

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
      '/history',
      '/',
      '/more',
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
              Navigator.pushNamed(context, '/Login');
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${iqAirData['iqair_aqi']}',
                                style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: getAqiColor(aqi)),
                              ),
                              const Text(
                                '       AQI',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Text(
                            '${cmuCCDCData['cmuccdc_location']}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:Colors.black),
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

// InfoCard widget สำหรับการแสดงข้อมูลต่าง ๆ
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
