import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const NotificationSettingsPage(),
//     );
//   }
// }

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  _NotificationSettingsPageState createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  String notificationText = 'แจ้งเตือนเมื่อ AQI มากกว่า 50';
  final pages = [
    '/loginhistory', // เส้นทางของหน้าประวัติ
    '/LoginPhayaoAirPage',        // เส้นทางของหน้าหลัก
    '/Loginmore',    // เส้นทางของหน้าข้อมูลเพิ่มเติม
  ];
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> aqiLevels = [
      {'color': Colors.green, 'label': 'ดี 0 - 50'},
      {'color': Colors.yellow, 'label': 'ปานกลาง 51 - 100'},
      {'color': Colors.orange, 'label': 'ไม่ดี 101 - 150'},
      {'color': Colors.red, 'label': 'แย่ 151 - 200'},
      {'color': Colors.purple, 'label': 'แย่มาก มากกว่า 200'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Phayao Air',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'การตั้งค่าการแจ้งเตือน',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'กำหนดคุณภาพอากาศ',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              notificationText,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: aqiLevels.map((level) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      notificationText = 'แจ้งเตือนเมื่อ AQI อยู่ในระดับ ${level['label']}';
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: level['color'],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList(),
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
          Navigator.pushNamed(context, pages[index]); // นำทางไปตามหน้าที่ตรงกับดัชนี
        },
      ),
    );
  }
}
