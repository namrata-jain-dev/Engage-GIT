import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
      drawer: Drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.teal,
        title: const Text('Engage GIT',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications,color: Colors.white,),
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
            Text(
              "Cultural Events",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
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
                      print("${event["name"]} tapped");
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(10),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.transparent, // Set to transparent for rounded container effect
            elevation: 0, // Remove shadow
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            iconSize: 20.r,
            selectedLabelStyle: TextStyle(fontSize: 10.sp),
            unselectedLabelStyle: TextStyle(fontSize: 10.sp),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.update),
                label: "Updates",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
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
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.purple[100],
          borderRadius: BorderRadius.circular(8.r),
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
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Held on - $date",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 20.sp,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}
