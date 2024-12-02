import 'package:engage/cultural_fest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventScreen extends StatefulWidget {
  final Map<String, dynamic>? eventDetail;

  EventScreen({this.eventDetail});

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            Padding(
              padding:  EdgeInsets.all(8.r),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CulturalEventsScreen()));
                },
                child: Container(
                    decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
                    padding: EdgeInsets.all(4.r),
                    child: Icon(
                      Icons.keyboard_backspace_sharp,
                      color: Colors.white,
                    )),
              ),
            ),
            Container(
              width: 1.sh,
              child: Image.asset(
                'assets/Images/cultural_grid.png', // Replace with your asset
                // height: 150.h,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(
              height: 10.h,
            ),
            Text(
              "${widget.eventDetail!['eventName'].toString().toUpperCase()}" ?? ' ' ,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Faculty Coordinators",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                Text("${widget.eventDetail!['facultyCoordinator']}" ?? ' ',style: TextStyle(fontSize: 16.sp), )
              ],
            ),
            // Text(
            //   "Student Coordinators",
            //   style: TextStyle(
            //     fontSize: 18.sp,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: 10.h),
            //
            // Row(
            //   children: List.generate(
            //     5,
            //     (index) => Padding(
            //       padding: EdgeInsets.only(right: 8.w),
            //       child: CircleAvatar(
            //         radius: 20.r,
            //         backgroundImage: AssetImage(
            //             'assets/avatar_$index.png'), // Replace with actual asset
            //       ),
            //     ),
            //   )..add(Text("+10", style: TextStyle(fontSize: 16.sp))),
            // ),
            SizedBox(height: 20.h),
            Text(
              "Time and Date",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.orange, size: 20.w),
                SizedBox(width: 8.w),
                Text(
                  "07:00 PM - 10:00 PM",
                  style: TextStyle(fontSize: 16.sp),
                ),
                Spacer(),
                Icon(Icons.calendar_today, color: Colors.orange, size: 20.w),
                SizedBox(width: 8.w),
                Text(
                    "${widget.eventDetail!['eventDate']}" ?? ' ',
                    style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "${widget.eventDetail!['description'] }" ?? " ",
              style: TextStyle(fontSize: 16.sp, color: Colors.black87),
            ),
            SizedBox(height: 10.h),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         // Handle button press
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.orange,
            //         // padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
            //         minimumSize: Size(80.w, 30.h),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10.r),
            //         ),
            //       ),
            //       child: Text(
            //         "Attending",
            //         style: TextStyle(fontSize: 18.sp, color: Colors.white),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
