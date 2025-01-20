import 'package:application/AQIPage.dart';
import 'package:application/Notification.dart';
import 'package:application/PhayaoAirPage.dart';
import 'package:application/contact.dart';
import 'package:flutter/material.dart';




class AdditionalPage extends StatelessWidget {
  final pages = [
    '/history', // เส้นทางของหน้าประวัติ
    '/',        // เส้นทางของหน้าหลัก
    '/more',    // เส้นทางของหน้าข้อมูลเพิ่มเติม
  ];
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
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/Login');
            },
          ),
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
              Navigator.push(
                  context,
              MaterialPageRoute(builder: (context) => const NotificationSettingsPage()),
              );
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
          // ListTile(
          //   title:const Text('เกี่ยวกับ'),
          //   leading:const Icon(Icons.info_outline, color: Colors.red),  // Added color here
          //   trailing:const Icon(Icons.arrow_forward, color: Colors.green),  // Added color here
          //   onTap: () {
          //     // Navigate to the About page (to be created)
          //   },
          // ),
          // const Divider(),
          // ListTile(
          //   title:const Text('คู่มือการใช้งาน'),
          //   leading:const Icon(Icons.book, color: Colors.teal),  // Added color here
          //   trailing:const Icon(Icons.arrow_forward, color: Colors.green),  // Added color here
          //   onTap: () {
          //     // Navigate to the User Guide page (to be created)
          //   },
          // ),
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
          } else {
            Navigator.pushNamed(context, pages[index]);
          }
        },
      ),
    );
  }
}


