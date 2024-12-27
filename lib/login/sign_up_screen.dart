
import 'package:engage/login/auth_service.dart';
import 'package:engage/login/toast.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';


class SignUpScreen extends StatefulWidget{
  @override
  State<SignUpScreen> createState() {
    return SignUpScreenSt();
  }

}
class SignUpScreenSt extends State<SignUpScreen>{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false; // For toggling password visibility
  bool isSignUp = false ;


  
  final _auth = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Top Shape
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
                      'Sign up',
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
              // Input Fields
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  children: [
                    _buildTextField(hintText: "User Name",controller: nameController),
                    SizedBox(height: 15.h),
                    _buildTextField(hintText: "User Email",controller: emailController),
                    SizedBox(height: 15.h),
                    _buildTextField(hintText: "Password", obscureText: true,controller: passwordController),
                    SizedBox(height: 15.h),
                    _buildTextField(hintText: "Confirm Password", obscureText: true,controller: confirmPasswordController),
                    SizedBox(height: 30.h),
                    // Sign Up Button
                    ElevatedButton(
                      onPressed: () {
                        // Define the action here
                        _signUp();
                        print("Gradient Button Pressed");
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
                          child:isSignUp ?Padding(
                            padding:  EdgeInsets.all(4.r),
                            child: CircularProgressIndicator(color: Colors.white,),
                          ) : Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.white, // Button text color
                              fontSize: 14.sp,     // Responsive text size using ScreenUtil
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 15.h),
                    // Log In Link
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(color: Colors.teal, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _signUp() async{
    setState(() {
      isSignUp = true ;
    });
    String? userName = nameController.text ;
    String? email = emailController.text;
    String? password = passwordController.text;
    String? confirmPassword = confirmPasswordController.text;


    if(password == confirmPassword){
      User? user = await _auth.createUserWithEmailAndPassowrd(email, password,userName);
      setState(() {
        isSignUp = false ;
      });
      if(user != null){
        debugPrint('User is created successfully');
        debugPrint('User $user');
        showToast(message: 'Signed up Successfully');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
      }else{
        debugPrint('Some error occured in sign up user');
        showToast(message: 'Error occurred');
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
      }
    }else{
      return ;
    }
  }

  Widget _buildTextField({required String hintText, bool obscureText = false,required TextEditingController controller}) {
    return SizedBox(
      height: 45.h,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 20.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          suffixIcon: obscureText ? IconButton(
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
          ) : SizedBox(),
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