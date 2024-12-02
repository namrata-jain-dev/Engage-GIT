import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dashboard.dart';

class UpdateEventsScreen extends StatefulWidget {
  const UpdateEventsScreen({Key? key}) : super(key: key);

  @override
  _UpdateEventsScreenState createState() => _UpdateEventsScreenState();
}

class _UpdateEventsScreenState extends State<UpdateEventsScreen> {
  // Dummy data for cultural events
  final List<Map<String, String>> culturalEvents = [
    {"name": "Music Festival", "date": "December 10, 2024"},
    {"name": "Art Exhibition", "date": "December 15, 2024"},
    {"name": "Dance Show", "date": "December 20, 2024"},
    {"name": "Drama Night", "date": "December 25, 2024"},
    {"name": "Cultural Fair", "date": "December 30, 2024"},
  ];

  int _selectedIndex = 0;

  // Method to handle bottom navigation bar item click
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DashboardScreen()));
          },
          icon: Icon(Icons.keyboard_backspace_sharp),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Engage GIT',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {
              // Notification logic
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.only(left: 6.r),
              child: Text(
                "Upcoming Events",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: ListView.builder(
                itemCount: culturalEvents.length,
                itemBuilder: (context, index) {
                  final event = culturalEvents[index];
                  return EventCard(
                    name: event["name"]!,
                    date: event["date"]!,
                    onTap: () {
                      // Handle card tap
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EventScreen()));
                      print("${event["name"]} tapped");
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
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
                      color: Colors.black),
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
