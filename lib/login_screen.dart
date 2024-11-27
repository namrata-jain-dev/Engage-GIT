import 'package:engage/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                  onPressed: () {
                    // Add your login logic here
                    print("Email: ${emailController.text}");
                    print("Password: ${passwordController.text}");


                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashboardScreen()));
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
                    "Don't have an account ? ",
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