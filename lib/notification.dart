
import 'package:engage/event/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

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
          IconButton(
            icon: const Icon(Icons.notifications,color: Colors.black,),
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
            SizedBox(height: 8.h),

          ],
        ),
      ),

    );
  }
}

