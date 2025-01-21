import 'package:application/login/LoginPhayaoAirPage.dart';
import 'package:flutter/material.dart';

class LogincontactPage extends StatelessWidget {
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
              Navigator.pushNamed(context, '/profile');
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
      body:const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ข้อมูลติดต่อ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'กรมอนามัย กระทรวงสาธารณสุข',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Items under กรมอนามัย กระทรวงสาธารณสุข
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.blue),
              title: Text('ที่อยู่'),
              subtitle: Text('88/22 หมู่ 4 ถนนติวานนท์'),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.green),
              title: Text('โทรศัพท์'),
              subtitle: Text('0-2590-4345'),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.orange),
              title: Text('อีเมล'),
              subtitle: Text('hiadoh@gmail.com'),
            ),
            SizedBox(height: 16),
            Text(
              'โรงพยาบาลพะเยาราม',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Items under โรงพยาบาลพะเยา ราม
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.red),
              title: Text('ที่อยู่'),
              subtitle: Text('88/22 หมู่ 4 ถนนติวานนท์'),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.purple),
              title: Text('โทรศัพท์'),
              subtitle: Text('054-411111-14'),
            ),
            ListTile(
              leading: Icon(Icons.facebook, color: Colors.blueAccent),
              title: Text('Facebook'),
              subtitle: Text('โรงพยาบาลพะเยา ราม'),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items:const [
      //     BottomNavigationBarItem(icon: Icon(Icons.history), label: 'ประวัติ'),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
      //     BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'เพิ่มเติม'),
      //   ],
      //   currentIndex: 1,
      //   onTap: (index) {
      //     Navigator.pop(context);
      //   },
      // ),

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
              MaterialPageRoute(builder: (context) => LoginPhayaoAirPage()),
                  (route) => false,
            );
          } else if (index == 0) {
            Navigator.pushNamed(context, '/Loginhistory');
          } else {
            Navigator.pushNamed(context, '/Longinmore');
          }
        },// นำทางไปตามหน้าที่ตรงกับดัชนี
      ),
    );
  }
}
