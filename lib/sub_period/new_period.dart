import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newmelon/menu.dart';
import 'package:newmelon/period.dart';
import 'package:newmelon/daily.dart';
import 'package:newmelon/analyze.dart';
import 'package:newmelon/summary.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class NewPeriod extends StatefulWidget {
  const NewPeriod({Key? key}) : super(key: key);

  @override
  State<NewPeriod> createState() => _NewPeriodState();
}

class _NewPeriodState extends State<NewPeriod> {
  List greenhouse = [];

  String? greenhouseName;
  String? greenhouseId;

  Future getGreenHouse() async {
    var url =
        "https://meloned.relaxlikes.com/api/greenhouse/viewgreenhouse.php";
    var response = await http.get(Uri.parse(url));
    greenhouse = json.decode(response.body);
    // return json.decode(response.body);
    // return greenhouse;
    // var jsonBody = response.body;
    // var jsonData = json.decode(jsonBody);

    // setState(() {
    //   greenhouse = jsonData;

    // });
    // print(jsonData);

    print(greenhouse);
  }

  @override
  void initState() {
    super.initState();
    getGreenHouse();
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
      /*______Top Bar________*/
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color.fromRGBO(159, 159, 54, 1),
        elevation: 0,
        title: const Text(
          'เพิ่มรอบการปลูก',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 20,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      /*______Hamburger Button______*/
      drawer: Hamburger1(sidemenu: sidemenu),

      /*______content_____*/
      body: Container(
        color: Color.fromRGBO(159, 159, 54, 1),
        child: Container(
          // width: screen_width,
          margin: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'เลือกโรงเรือน',
                  style: GoogleFonts.kanit(
                      fontSize: 18, color: Color.fromRGBO(116, 116, 39, 1)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    color: Color.fromRGBO(251, 249, 218, 1),
                    height: 50,
                    //////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////
                    /*____________________Dropdown เลือกโรงเรือน_______________________*/
                    //////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////
                    ///
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: greenhouseName,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      hint: Text('เลือกโรงเรือน',
                          style: GoogleFonts.kanit(
                              fontSize: 18,
                              color: Color.fromRGBO(116, 116, 39, 1))),
                      style: TextStyle(
                          color: Color.fromRGBO(116, 116, 39, 1), fontSize: 18),
                      onChanged: (value) {
                        setState(() {
                                greenhouseName = value;
                                print(greenhouseName);
                        });
                      },
                      items: greenhouse.map((item) {
                          return DropdownMenuItem<String>(
                          value: item['greenhouse_ID'].toString(),
                          child: Text(item['greenhouse_Name'].toString()),
                        );
                      }).toList(),
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextButton(
                        ////////////////////////////////////////////////
                        //ปุ่มบันทึก
                        ////////////////////////////////////////////////
                        onPressed: () {},
                        child: Text(
                          'บันทึก',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromRGBO(159, 159, 54, 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextButton(
                        ////////////////////////////////////////////
                        //ปุ่มยกเลิก
                        /////////////////////////////////////////////
                        onPressed: () {},
                        child: Text(
                          'ยกเลิก',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromRGBO(172, 112, 79, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      /*____Bottom Bar____*/
      bottomNavigationBar: MyBottomBar(),
    );
  }

//////////////////////////////////////////////////////////////////////////////////////////////
  /*_____________Style____________*/
  TextStyle sidemenu = const TextStyle(
    fontFamily: 'Kanit',
    fontSize: 15,
    color: Color.fromRGBO(116, 116, 39, 1),
  );
}

class MyBottomBar extends StatelessWidget {
  const MyBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        color: Color.fromRGBO(159, 159, 54, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //ปุ่ม Period
            Container(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Period()),
                  );
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: Color.fromRGBO(227, 209, 106, 1),
                  size: 40,
                ),
              ),
            ),
            //ปุ่ม Daily
            Container(
                child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Daily()),
                );
              },
              icon: Icon(
                Icons.favorite,
                color: Color.fromRGBO(227, 209, 106, 1),
                size: 40,
              ),
            )),
            //ปุ่ม Home
            Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(251, 249, 218, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainMenu()),
                    );
                  },
                  icon: Icon(
                    Icons.home,
                    color: Color.fromRGBO(227, 209, 106, 1),
                    size: 40,
                  ),
                )),
            //ปุ่ม Analyze
            Container(
                child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Analyze()),
                );
              },
              icon: Icon(
                Icons.troubleshoot,
                color: Color.fromRGBO(227, 209, 106, 1),
                size: 40,
              ),
            )),
            Container(
                child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Summary()),
                );
              },
              icon: Icon(
                Icons.insights,
                color: Color.fromRGBO(227, 209, 106, 1),
                size: 40,
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class Hamburger1 extends StatelessWidget {
  const Hamburger1({
    Key? key,
    required this.sidemenu,
  }) : super(key: key);

  final TextStyle sidemenu;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(159, 159, 54, 1),
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.account_circle_sharp,
                  size: 50,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Surat Lhaodee',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Home',
              style: sidemenu,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainMenu()),
              );
            },
          ),
          ListTile(
            title: Text(
              'Period',
              style: sidemenu,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Period()),
              );
            },
          ),
          ListTile(
            title: Text(
              'Daily Care',
              style: sidemenu,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Daily()),
              );
            },
          ),
          ListTile(
            title: Text(
              'Analyze',
              style: sidemenu,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Analyze()),
              );
            },
          ),
          ListTile(
            title: Text(
              'Summary',
              style: sidemenu,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Summary()),
              );
            },
          ),
        ],
      ),
    );
  }
}
