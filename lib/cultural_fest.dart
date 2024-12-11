import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engage/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


import 'createEvent.dart';
import 'dashboard.dart';
import 'eventDetail.dart';


class CulturalEventsScreen extends StatefulWidget {
  const CulturalEventsScreen({Key? key}) : super(key: key);

  @override
  _CulturalEventsScreenState createState() => _CulturalEventsScreenState();
}

class _CulturalEventsScreenState extends State<CulturalEventsScreen> {
  // Dummy data for cultural events
  final List<Map<String, String>> culturalEvents = [
    {"name": "Music Festival", "date": "December 10, 2024"},
    {"name": "Art Exhibition", "date": "December 15, 2024"},
    {"name": "Dance Show", "date": "December 20, 2024"},
    {"name": "Drama Night", "date": "December 25, 2024"},
    {"name": "Cultural Fair", "date": "December 30, 2024"},
  ];

  int _selectedIndex = 0;

  String? role ;
  User? user = FirebaseAuth.instance.currentUser ;
  bool getRole = false ;

  List<dynamic>? eventsInfo ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserRole();
    fetchEventAndSubcollection();
  }
  // Method to handle bottom navigation bar item click
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

 List< Map<String, dynamic>?>? data = [] ;

  void getUserRole() async {
    setState(() {
      getRole = true ;
    });
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(user!.email).get();
    debugPrint('UserProfileDoc ${doc.data()}');
    if (doc.exists) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      role =  data?["role"] as String?;
      debugPrint('UserRole $role');
    }
    setState(() {
      getRole = false ;
    });
  }

  void fetchEventAndSubcollection() async {
    DocumentSnapshot doc =
    await FirebaseFirestore.instance.collection('events').doc('Cultural').get();

    if (doc.exists) {
      data!.add(
          doc.data() as Map<String,dynamic>?
      );
      debugPrint('UserRole $data');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // drawer: Drawer(),
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashboardScreen()));
        },
          icon: Icon(Icons.keyboard_backspace_sharp),
        ),
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: const Text('Engage GIT',style: TextStyle(color: Colors.black),),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.notifications,color: Colors.black,),
          //   onPressed: () {
          //     // Notification logic
          //   },
          // ),
        ],
      ),
      body: getRole ? Center(child: CircularProgressIndicator()) : Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding:  EdgeInsets.only(left: 6.r),
              child: Text(
                "Cultural Events",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  final event = culturalEvents[index];
                  // int timestampInSeconds = int.parse(data![0]!["eventDate"].toString().substring(20,40));  // Timestamp in seconds
                  // DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000);
                  // String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                  String formattedDate = '05-12-2024';
                  print(formattedDate); // Output: 2023-01-06
                  return EventCard(
                    name: data![0]!["eventName"] ?? '',
                    // date: data!["eventDate"],
                    date: formattedDate ,
                    onTap: () {
                      // Handle card tap
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EventScreen(
                        eventDetail: data![0],
                      )));
                      print("${event["name"]} tapped");
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: role == "ADMIN" ? FloatingActionButton(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return CreateEvent();
          }));
      },child: Icon(Icons.add_rounded,color: Colors.white,),)
          : SizedBox(),

    );
  }
}


class EventCard extends StatelessWidget {
  final String name;
  final String date;
  final VoidCallback onTap;

  const EventCard({
    Key? key,
    required this.name,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.deepPurple[100],
          borderRadius: BorderRadius.circular(20.r),
          // border: Border.all(color: Colors.black,width: 2),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.shade300,
          //     blurRadius: 5.r,
          //     offset: Offset(3, 3),
          //   ),
          // ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white
                    color: Colors.black
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Held on - $date",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                      // color: Colors.white,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 20.sp,
              // color: Colors.white,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
