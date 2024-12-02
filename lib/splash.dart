import 'dart:convert';

import 'package:engage/consts.dart';
import 'package:engage/dashboard.dart';
import 'package:engage/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next screen after 5 seconds
    getUserData();
    navigateToDifferent();
  }


  Map<String, dynamic> userDetail = {};
  void getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? dt = pref.getString(Constants().userDataKey);
    if (dt != null) {
      userDetail = jsonDecode(dt);
      debugPrint('User data from SharedPreferences: $userDetail');

    } else {
      debugPrint('No user data found in SharedPreferences.');
    }
  }


  void navigateToDifferent() async{
    await Future.delayed(const Duration(seconds: 5), () {
      if(userDetail['uid'] != null ){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background Color
            Container(color: Colors.lightBlue[50]),

            // Green Clipped Banner
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 40.w,
                color: Colors.teal,
              ),
            ),


            // Center Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Graduation Cap with Icon
                SizedBox(height: 120.h),
                Image.asset('assets/Images/splash_img.png'),
                SizedBox(height: 20.h),

                // Text Below
                //  Text(
                //   "Engage GIT",
                //   style: TextStyle(
                //     color: Colors.teal,
                //     fontSize: 24.sp,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),

                SizedBox(height: 220.h,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ClipPath(
                      clipper:SShapeClipper() ,
                      child: Container(
                        height: 40.h,
                        width: 240.w,
                        color: Colors.teal,
                        child:Center(
                          child: Text(
                            "Engage GIT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Text(
                  "Made With ❤️",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 10.sp),
                ),
                // Footer
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Text(
                    "Namrata Jain",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 12.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start at the top-left corner
    path.moveTo(size.width, 0);
    path.lineTo(size.width*0.2, 0);

    // Create the S-curve on the left side
    path.quadraticBezierTo(
        size.width * 0.3, size.height * 0.25,  size.width * 0.15, size.height * 0.55);

    // Second curve (bottom half of the S, curving outward and upward)
    path.quadraticBezierTo(
        size.width * 0.07, size.height * 0.75, size.width * 0.24, size.height*0.9);

    // Draw straight lines for the other sides
    path.quadraticBezierTo(
        size.width/2, size.height , size.width, size.height*0.86);
    // path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; // No need to reclip in this case
  }
}
