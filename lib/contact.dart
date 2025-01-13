import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Phayao Air'),
        centerTitle: true,  // Centers the title
        leading: IconButton(
          icon:const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child:const Icon(Icons.person, color: Colors.blue),
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
      bottomNavigationBar: BottomNavigationBar(
        items:const [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'ประวัติ'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'เพิ่มเติม'),
        ],
        currentIndex: 1,
        onTap: (index) {
          Navigator.pop(context);
        },
      ),
    );
  }
}
