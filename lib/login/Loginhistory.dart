import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Loginhistory extends StatelessWidget {
  // ฟังก์ชันในการเลือกสีของการ์ดตามค่า AQI
  Color _getAQIColor(int aqi) {
    if (aqi <= 50) {
      return Colors.green[400]!; // AQI 0-50 สีเขียวเข้ม
    } else if (aqi <= 100) {
      return Colors.yellow[400]!; // AQI 51-100 สีเหลืองเข้ม
    } else if (aqi <= 150) {
      return Colors.orange[400]!; // AQI 101-150 สีส้มเข้ม
    } else if (aqi <= 200) {
      return Colors.red[400]!; // AQI 151-200 สีแดงเข้ม
    } else {
      return Colors.purple[400]!; // AQI > 200 สีม่วงเข้ม
    }
  }

  // ฟังก์ชันในการเลือกไอคอนตามค่า AQI
  IconData _getAQIIcon(int aqi) {
    if (aqi <= 50) {
      return Icons.sentiment_satisfied_alt; // Icon สีเขียว
    } else if (aqi <= 100) {
      return Icons.sentiment_neutral; // Icon สีเหลือง
    } else if (aqi <= 150) {
      return Icons.sentiment_dissatisfied; // Icon สีส้ม
    } else if (aqi <= 200) {
      return Icons.sentiment_very_dissatisfied; // Icon สีแดง
    } else {
      return Icons.warning; // Icon สีม่วง
    }
  }

  // ฟังก์ชันในการเลือกสีข้อความ
  Color _getTextColor(int aqi) {
    if (aqi <= 50) {
      return Colors.black; // สีข้อความดำ
    } else if (aqi <= 100) {
      return Colors.black; // สีข้อความดำ
    } else if (aqi <= 150) {
      return Colors.black; // สีข้อความขาว
    } else if (aqi <= 200) {
      return Colors.black; // สีข้อความขาว
    } else {
      return Colors.black; // สีข้อความขาว
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.white, // เปลี่ยนสี AppBar เป็นขาว
        iconTheme: const IconThemeData(color: Colors.black), // เปลี่ยนสีไอคอนใน AppBar เป็นสีดำ
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('air_quality')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index].data();
              final aqi = data['iqair_aqi'] ?? 0; // ตรวจสอบว่า aqi เป็น null หรือไม่

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _getAQIColor(aqi).withOpacity(0.7), // สีเข้มขึ้น
                        _getAQIColor(aqi), // สีเข้ม
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        title: Text(
                          '${data['iqair_city']} - AQI: $aqi',
                          style: TextStyle(
                            fontSize: 30, // Increased font size
                            fontWeight: FontWeight.bold,
                            color: _getTextColor(aqi), // ใช้สีข้อความตาม AQI
                          ),
                        ),
                        subtitle: Text(
                              'PM 2.5 : ${data['cmuccdc_pm25']} µg/m³\n'
                              '${data['cmuccdc_location']}\n'
                              'Date : ${data['cmuccdc_log_datetime']}',
                          style: TextStyle(
                            fontSize: 16, // Increased font size for subtitle
                            color: _getTextColor(aqi).withOpacity(0.7), // สีข้อความที่อ่อนกว่าสำหรับรายละเอียด
                          ),
                        ),
                        leading: Icon(
                          _getAQIIcon(aqi),
                          size: 40,
                          color: Colors.white, // ไอคอนขาวเพื่อความโดดเด่น
                        ),
                      ),
                      Divider(color: Colors.grey[300], height: 1),  // เพิ่มเส้นแบ่งเล็กๆ
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.blue, size: 20),
                            SizedBox(width: 8),
                            Text(
                              data['cmuccdc_location'],
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18), // Increased font size for location
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // เปลี่ยนสี BottomNavigationBar เป็นขาว
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
        selectedItemColor: Colors.black, // สีของปุ่มที่เลือก
        unselectedItemColor: Colors.grey, // สีของปุ่มที่ไม่ได้เลือก
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/LoginPhayaoAirPage');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/Loginmore');
          }
        },
      ),
    );
  }
}
