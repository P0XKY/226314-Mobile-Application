import 'package:application/PhayaoAirPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/profile',
      routes: {
        '/profile': (context) => ProfilePage(),
        // เพิ่ม route อื่น ๆ ถ้าจำเป็น
      },
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('โปรไฟล์'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/Login');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              width: 100.0, // กำหนดขนาดรูปภาพ
              height: 100.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/profile.jpg'), // เปลี่ยนเป็นพาธรูปของคุณ
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),// เพิ่มรูปภาพตรงกลาง
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: const Row(
              children: [
                Text(
                  'ข้อมูลส่วนตัว',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const ListTile(
            title: Text('ชื่อผู้ใช้: John Doe'),
            leading: Icon(Icons.person, color: Colors.blue),
          ),
          const Divider(),
          const ListTile(
            title: Text('อีเมล: john.doe@example.com'),
            leading: Icon(Icons.email, color: Colors.orange),
          ),
          const Divider(),
          ListTile(
            title: const Text('เปลี่ยนรหัสผ่าน'),
            leading: const Icon(Icons.lock, color: Colors.red),
            trailing: const Icon(Icons.arrow_forward, color: Colors.green),
            onTap: () {
              // Navigate to the Change Password page
            },
          ),
        ],
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
          } else if (index == 0) {
            Navigator.pushNamed(context, '/history');
          } else {
            Navigator.pushNamed(context, '/more');
          }
        },
      ),
    );
  }
}