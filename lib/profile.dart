import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engage/auth_service.dart';
import 'package:engage/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String? name ;
  String? mail ;
  bool gettingData = false ;
  final _auth = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetail();

  }


  void getUserDetail() async{
    setState(() {
      gettingData =  true ;
    });
    User? user = FirebaseAuth.instance.currentUser ;
    debugPrint('UserProfile $user');
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(user!.email).get();
    debugPrint('UserProfileDoc $doc');
    if (doc.exists) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      name =  data?["username"] as String?;
      mail =  data?["email"] as String?;
    }
    setState(() {
      gettingData =  false ;
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
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       Icons.notifications,
        //       color: Colors.black,
        //     ),
        //     onPressed: () {
        //       // Notification logic
        //     },
        //   ),
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SizedBox(height: 30.h),
            // Avatar
            Image.asset('assets/Images/Account.png'),
            SizedBox(height: 30.h),

            gettingData ? Center(child: CircularProgressIndicator()) : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name : '),
                    Text('$name'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Email : '),
                    Text('$mail'),
                  ],
                )
              ],
            ),


            SizedBox(
              height: 30.h,
            ),

            ElevatedButton(
              onPressed: ()async{
                // Notification logic
                _auth.signOutUser();
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.clear();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
              },
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.zero),
                minimumSize: WidgetStatePropertyAll(Size(140.w,30.h)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),),
              ),
              child: Ink(
                width: 140.w,
                height: 30.h,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.teal.shade400,
                      Colors.teal.shade700,
                      Colors.teal.shade900,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12), // Match the shape
                ),
                child: Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white, // Button text color
                      fontSize: 14.sp,     // Responsive text size using ScreenUtil
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }



}
