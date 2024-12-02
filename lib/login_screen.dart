import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engage/sign_up_screen.dart';
import 'package:engage/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';
import 'consts.dart';
import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // State variables
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false; // For toggling password visibility
  final _auth = AuthService();
  bool _isLogIn = false ;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void setUserData(User user) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.setString('UserData', user);
    Map<String, dynamic> userData = {
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoURL': user.photoURL,
    };

    String jsonString = jsonEncode(userData);
    await pref.setString(Constants().userDataKey, jsonString);
    debugPrint('User data saved to SharedPreferences: $jsonString');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Section
              ClipPath(
                clipper: TopShapeClipper(),
                child: Container(
                  width: double.infinity,
                  height: 120.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft, // Start point of the gradient
                      end: Alignment.bottomRight, // End point of the gradient
                      colors: [
                        Colors.teal.shade900, // Lighter shade of teal
                        Colors.teal.shade500,
                        Colors.teal.shade500, // Lighter shade of teal
                        Colors.teal.shade900, // Lighter shade of teal
                      ],
                    ),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.only(top: 30.r,left: 50.r),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
      
              SizedBox(height: 30.h),
              // Avatar
              Image.asset('assets/Images/Account.png'),
              SizedBox(height: 30.h),
              // Email TextField
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: SizedBox(
                  height: 45.h,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'User Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              // Password TextField
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: SizedBox(
                  height: 45.h,
                  child: TextField(
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Login Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: ElevatedButton(
                  onPressed: _logIn,
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
                      child: _isLogIn ? Padding(
                        padding:  EdgeInsets.all(4.r),
                        child: CircularProgressIndicator(color: Colors.white,),
                      ) :Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white, // Button text color
                          fontSize: 14.sp,     // Responsive text size using ScreenUtil
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              // Forgot Password
              Text(
                'Forgot your password ?',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.teal,
                ),
              ),
              // SizedBox(height: 20.h),
              // Illustration
              /// lottie asset
              // Image.asset(
              //   'assets/illustration.png', // Replace with your asset path
              //   height: 150.h,
              // ),
              // SizedBox(height: 100.h),
              // Sign Up Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



  void _logIn() async{
    setState(() {
      _isLogIn = true ;
    });
    String? email = emailController.text;
    String? password = passwordController.text;

      User? user = await _auth.logInUserWithEmailAndPassowrd(email, password);
    setState(() {
      _isLogIn = false ;
    });
      if(user != null){
        debugPrint('User is logged in successfully');
        debugPrint('User $user');
        showToast(message: 'Logged in Successfully');

        await user.reload(); // Refresh user state to get the latest emailVerified status
        if (user.emailVerified) {
          setUserData(user);

          DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('users').doc(user.email).get();

          if (doc.exists) {
            Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
            String? name =  data?["username"] as String?;
            debugPrint('Name $name');
          }

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashboardScreen())); // Navigate to home screen
        } else {
          showToast(message: 'Verify Email'); // Redirect to verify email screen
        }

      }else{
        debugPrint('Some error occured in sign up user');
        showToast(message: 'Error Occured');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
      }
  }

  Future<void> resendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification email has been sent.')),
      );
    }
  }

}

class TopShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.35); // Start at 70% of height on the left
    path.quadraticBezierTo(
        size.width * 0.25, // Control point x (center horizontally)
        size.height,      // Control point y (bottom of the container)
        size.width * 0.63,
        size.height*0.6    // End at the top-right corner
      // size.height * 0.1, // End height slightly above 60%
    );
    path.lineTo(size.width * 0.5, size.height * 0);
    //

    path.moveTo(size.width, 0);
    path.lineTo(size.width*0.2, 0);

    path.quadraticBezierTo(
        size.width * 0.75, // Control point x (center horizontally)
        size.height*0.75,      // Control point y (bottom of the container)
        size.width ,
        size.height * 0.18    // End at the top-right corner
      // size.height * 0.1, // End height slightly above 60%
    );
    // path.lineTo(size.width, 0); // Go to the top-right corner
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}