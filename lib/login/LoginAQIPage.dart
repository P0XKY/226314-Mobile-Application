import 'package:flutter/material.dart';

class AQIPage extends StatelessWidget {
  final pages = [
    '/Loginhistory',
    '/LoginPhayaoAirPage',
    '/Loginmore',
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
      body:const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ข้อมูล AQI',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'ดัชนีคุณภาพอากาศของประเทศไทยแบ่งออกเป็น5ระดับ ตั้งแต่ 0 ถึงมากกว่า 200 แต่ละระดับใช้สีแทนผลกระทบต่อสุขภาพ โดยค่าดัชนี 100 หมายถึงมาตรฐานคุณภาพอากาศ หากค่าสูงเกิน 100 แสดงว่ามลพิษทางอากาศเกินมาตรฐาน และอาจเริ่มส่งผลกระทบต่อสุขภาพประชาชนในวันนั้น:',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            Column(
              children: [
                ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.green),
                  title: Text('0 - 50'),
                  subtitle: Text('คุณภาพอากาศดี เหมาะสำหรับกิจกรรมกลางแจ้ง'),
                ),
                ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.yellow),
                  title: Text('51 - 100'),
                  subtitle: Text('คุณภาพอากาศปานกลาง สำหรับผู้ที่มีโรคประจำตัว'),
                ),
                ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.orange),
                  title: Text('101 - 150'),
                  subtitle: Text('ควรหลีกเลี่ยงกิจกรรมกลางแจ้งสำหรับผู้ป่วย'),
                ),
                ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.red),
                  title: Text('151 - 200'),
                  subtitle: Text('ไม่เหมาะสำหรับกิจกรรมกลางแจ้งทุกกลุ่ม'),
                ),
                ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.purple),
                  title: Text('มากกว่า 200'),
                  subtitle: Text('อันตรายต่อสุขภาพอย่างมาก'),
                ),
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
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
          Navigator.pushNamed(context, pages[index]); // นำทางไปตามหน้าที่ตรงกับดัชนี
        },
      ),
    );
  }
}