import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class PhayaoAirPage1 extends StatefulWidget {
  @override
  _PhayaoAirPageState createState() => _PhayaoAirPageState();
}

class _PhayaoAirPageState extends State<PhayaoAirPage1> {
  Map<String, dynamic>? iqAirData;
  Map<String, dynamic>? cmuCCDCData;
  Timer? _timer; // Timer สำหรับการทำงานอัตโนมัติ

  @override
  void initState() {
    super.initState();
    // ดึงข้อมูลและบันทึกลง Firebase ครั้งแรกเมื่อเริ่มต้น
    fetchAndSaveData();

    // ตั้งเวลาให้ดึงข้อมูลและบันทึกซ้ำทุกๆ 1 ชั่วโมง
    _timer = Timer.periodic(Duration(minutes: 2), (timer) {
      fetchAndSaveData();
    });
  }

  @override
  void dispose() {
    // ยกเลิก Timer เมื่อปิดหน้า
    _timer?.cancel();
    super.dispose();
  }

  // ฟังก์ชันสำหรับดึงข้อมูลจาก API และบันทึกลง Firebase
  Future<void> fetchAndSaveData() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String apiKey = '274c95bd-2bb3-448f-b915-03477f596c5d'; // ใส่ API Key ของคุณ
    final String url = 'http://api.airvisual.com/v2/city?city=Mae Ka&state=Phayao&country=Thailand&key=$apiKey';

    try {
      print('Fetching data from API...');
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('API fetched successfully.');
        final data = jsonDecode(response.body);
        print('Decoded data: $data');

        final airQualityData = {
          "city": data['data']['city'],
          "aqi": data['data']['current']['pollution']['aqius'],
          "temperature": data['data']['current']['weather']['tp'],
          "humidity": data['data']['current']['weather']['hu'],
          "timestamp": FieldValue.serverTimestamp(),
        };

        await _firestore.collection('air_quality1').add(airQualityData);
        print('Data saved successfully!');
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

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
              MaterialPageRoute(builder: (context) => PhayaoAirPage1()),
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
