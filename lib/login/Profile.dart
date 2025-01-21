import 'package:application/PhayaoAirPage.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('โปรไฟล์', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // รูปโปรไฟล์
            Center(
              child: Container(
                margin: const EdgeInsets.all(16.0),
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/profile.jpg'), // เปลี่ยนเป็นพาธรูปของคุณ
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4), // Change the shadow position
                    ),
                  ],
                ),
              ),
            ),
            // ข้อมูลส่วนตัว
            const Text(
              'ข้อมูลส่วนตัว',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
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
            const Divider(),
            // ปุ่มสำหรับ logout
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/Login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // เปลี่ยนสีพื้นหลังของปุ่ม
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
