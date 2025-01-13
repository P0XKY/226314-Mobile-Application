import 'package:flutter/material.dart';

import 'AQIPage.dart';
import 'contact.dart';


class AdditionalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Phayao Air'),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, color: Colors.blue),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize:const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          // Remove the background container here
          Container(
            padding:const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            // Removed the color property
            child: const Row(
              children: [
                Text(
                  'ข้อมูลเพิ่มเติม',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('ข้อมูล AQI'),
            leading: const Icon(Icons.air, color: Colors.blue),  // Added color here
            trailing: const Icon(Icons.arrow_forward, color: Colors.green),  // Added color here
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AQIPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('การตั้งค่าการแจ้งเตือน'),
            leading: const Icon(Icons.notifications, color: Colors.orange),  // Added color here
            trailing: const Icon(Icons.arrow_forward, color: Colors.green),  // Added color here
            onTap: () {
              // Navigate to the notification settings page (to be created)
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('ข้อมูลติดต่อ'),
            leading: const Icon(Icons.contact_phone, color: Colors.purple),  // Added color here
            trailing: const Icon(Icons.arrow_forward, color: Colors.green),  // Added color here
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            title:const Text('เกี่ยวกับ'),
            leading:const Icon(Icons.info_outline, color: Colors.red),  // Added color here
            trailing:const Icon(Icons.arrow_forward, color: Colors.green),  // Added color here
            onTap: () {
              // Navigate to the About page (to be created)
            },
          ),
          const Divider(),
          ListTile(
            title:const Text('คู่มือการใช้งาน'),
            leading:const Icon(Icons.book, color: Colors.teal),  // Added color here
            trailing:const Icon(Icons.arrow_forward, color: Colors.green),  // Added color here
            onTap: () {
              // Navigate to the User Guide page (to be created)
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:const [
          BottomNavigationBarItem(icon: Icon(Icons.history, color: Colors.blue), label: 'ประวัติ'),
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.blue), label: 'หน้าหลัก'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz, color: Colors.blue), label: 'เพิ่มเติม'),
        ],
        currentIndex: 1,
        onTap: (index) {
          // Handle navigation (if needed)
        },
      ),
    );
  }
}


