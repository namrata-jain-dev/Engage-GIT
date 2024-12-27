
import 'package:engage/cultural%20event/cultural_fest.dart';
import 'package:engage/login/auth_service.dart';
import 'package:engage/login/profile.dart';
import 'package:engage/notification.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin AppLocale {
  static const String title = 'title';
  static const String thisIs = 'thisIs';

  static const Map<String, dynamic> EN = {
    title: 'Localization',
    thisIs: 'This is %a package, version %a.',
  };
  static const Map<String, dynamic> KM = {
    title: 'ការធ្វើមូលដ្ឋានីយកម្ម',
    thisIs: 'នេះគឺជាកញ្ចប់%a កំណែ%a.',
  };
  static const Map<String, dynamic> JA = {
    title: 'ローカリゼーション',
    thisIs: 'これは%aパッケージ、バージョン%aです。',
  };
  static const Map<String, dynamic> HI = {
    title: 'स्थानीयकरण',
    thisIs: 'यह %a पैकेज है, संस्करण %a।',
  };
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // final FlutterLocalization _localization = FlutterLocalization.instance;

  final List<String> sliderItems = [
    "Cultural Events",
    "Sports Events",
    "Technical Events",
    "Social Events",
  ];

  final List<int> sliderItemCount = [
   1,2,3
  ];

  final List<String> eventImages = [
    "assets/Images/eventSliderImg.jpg", // Add your asset images
    "assets/Images/eventSliderImg.jpg",
    "assets/Images/eventSliderImg.jpg",
    "assets/Images/eventSliderImg.jpg",
  ];
  final List<Map<String, dynamic>> eventCategories = [
    {
      'title': "Cultural Events",
      // 'color': Colors.white,
      'color': Colors.purple[100],
      'imagePath': "assets/Images/cultural_grid.png", // Replace with your asset path
      'onTap': () {
        print("Cultural Event Clicked");

      },
    },
    {
      'title': "Sports Events",
      // 'color': Colors.white,
      'color': Colors.yellow[100],
      'imagePath':"assets/Images/sport_grid.png",
      'onTap': () {
        print("Sports Event Clicked");
      },
    },
    {
      'title': "Social Events",
      'color': Colors.green[100],
      // 'color': Colors.white,
      'imagePath': "assets/Images/social_grid.jpg",
      'onTap': () {
        print("Social Event Clicked");
      },
    },
    {
      'title': "Technical Events",
      'color': Colors.red[100],
      // 'color': Colors.white,
      'imagePath': "assets/Images/tech_grid.png",
      'onTap': () {
        print("Technical Event Clicked");
      },
    },
  ];


  @override
  void initState() {
    // _localization.init(
    //   mapLocales: [
    //     const MapLocale(
    //       'en',
    //       AppLocale.EN,
    //       countryCode: 'US',
    //       fontFamily: 'Font EN',
    //     ),
    //     const MapLocale(
    //       'km',
    //       AppLocale.KM,
    //       countryCode: 'KH',
    //       fontFamily: 'Font KM',
    //     ),
    //     const MapLocale(
    //       'ja',
    //       AppLocale.JA,
    //       countryCode: 'JP',
    //       fontFamily: 'Font JA',
    //     ),
    //     const MapLocale(
    //       'hi',
    //       AppLocale.HI,
    //       countryCode: 'IN',
    //       fontFamily: 'Font HI',
    //     ),
    //   ],
    //   initLanguageCode: 'en',
    // );
    // _localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  int _selectedIndex = 0;

  // Method to handle bottom navigation bar item click
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _currentIndex = 0 ;
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // drawer: Drawer(),

      appBar: AppBar(

        iconTheme: IconThemeData(
          color: Colors.black
        ),
        // backgroundColor: Colors.teal,
        backgroundColor: Colors.white,
        title: const Text('  Engage GIT',style: TextStyle(color: Colors.black),),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 14.r),
            child: IconButton(
              icon: const Icon(Icons.notifications,color: Colors.black,),
              onPressed: () {
                // Notification logic
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> NotificationScreen()));

              },
            ),
          ),

            PopupMenuButton<String>(
              icon: const Icon(Icons.language),
              onSelected: (String value) {
                // _localization.translate(value);
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(value: 'en', child: Text('English')),
                const PopupMenuItem(value: 'km', child: Text('ភាសាខ្មែរ')),
                const PopupMenuItem(value: 'ja', child: Text('日本語')),
                const PopupMenuItem(value: 'hi', child: Text('हिंदी')),
              ],
            ),


        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 20.h,),
            // Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 140.h,
                // autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index; // Update the current index
                  });
                },
              ),
              items: [
                firstSlider(),
                secondSlider(),
                thirdSlider(),
              ],
            ),
            // Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: sliderItemCount.map((item) {
                int index = sliderItemCount.indexOf(item);
                return Container(
                  width: _currentIndex == index ? 10.w : 8.w,
                  height: _currentIndex == index ? 10.h : 8.h,
                  margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.teal
                        : Colors.grey.shade400,
                  ),
                );
              }).toList(),
            ),
            // SizedBox(height: 20.h),
            Container(
              height:  0.62.sh,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(50.r),topLeft: Radius.circular(50.r)),
                border: Border(top: BorderSide(color: Colors.black,width: 2.r)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5.r,
                    offset: Offset(-3, -3),
                  ),
                ],
                color: Colors.white,
                // color:Colors.indigoAccent.shade100,
                // color:Colors.grey.shade900,
                // color:Colors.grey.shade900,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.w,top: 30.r,right: 30.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Explore Events',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            // color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            // InkWell(child: Icon(Icons.update,
                            //   color: Colors.black,
                            //   // color: Colors.white,
                            // ),onTap: (){
                            //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UpdateEventsScreen()));
                            // },),
                            SizedBox(width: 10.w,),
                            InkWell(child: Icon(Icons.person,
                              color: Colors.black,
                              // color: Colors.white,

                            ),onTap: (){

                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));

                            },),


                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // GridView Section
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding:  EdgeInsets.symmetric(horizontal: 16.r,vertical: 8.r),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Adjust columns based on screen size
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                      ),
                      itemCount: eventCategories.length, // Total number of items
                      itemBuilder: (context, index) {
                        final event = eventCategories[index]; // Fetch event data from the list
                        return _buildEventCard(
                          context,
                          title: event['title'],
                          color: event['color'],
                          imagePath: event['imagePath'],
                          onTap: event['onTap'],
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      //   child: Container(
      //     height: 44.h,
      //     decoration: BoxDecoration(
      //       color: Colors.teal,
      //       borderRadius: BorderRadius.circular(10),
      //     ),
      //     child: BottomNavigationBar(
      //       currentIndex: _selectedIndex,
      //       onTap: _onItemTapped,
      //       backgroundColor: Colors.transparent, // Set to transparent for rounded container effect
      //       elevation: 0, // Remove shadow
      //       selectedItemColor: Colors.white,
      //       unselectedItemColor: Colors.white70,
      //       iconSize: 20.r,
      //       selectedLabelStyle: TextStyle(fontSize: 10.sp),
      //       unselectedLabelStyle: TextStyle(fontSize: 10.sp),
      //       items: const [
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.update),
      //           label: "Updates",
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.dashboard),
      //           label: "Dashboard",
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.person),
      //           label: "Profile",
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }


  Widget _buildEventCard(
      BuildContext context, {
        required String title,
        required Color color,
        required String imagePath,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return const CulturalEventsScreen();
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,

          children: [
            // Padding(
            //   padding: EdgeInsets.all(8.r),
            //   child: Container(
            //     width:double.maxFinite,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10.r),
            //     ),
            //     child:
            //     Padding(
            //       padding:  EdgeInsets.all(8.r),
            //       child: Center(
            //         child: Text(
            //           title,
            //           style:  TextStyle(fontSize: 16.sp, ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            SizedBox(height: 10.h,),
            Image.asset(
                imagePath,
                height: 80.h
            ), // Add proper image assets

            Padding(
              padding:  EdgeInsets.all(8.r),
              child: Center(
                child: Text(
                  title,
                  style:  TextStyle(fontSize: 16.sp, ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget firstSlider(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.red[100],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5.r,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width:100.w,
            child: Text('Get the latest updates about the events we are organizing',style: TextStyle(color: Colors.teal,fontSize: 12.sp),softWrap: true,),
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white
              ),
              padding: EdgeInsets.all(4.r),
              child: Image.asset(
                fit: BoxFit.contain,
                'assets/Images/eventSliderImg.jpg',height: 100.h,width: 120.w,)),

        ],
      ),
    );
  }

  Widget secondSlider(){
    return Container(
      width: double.infinity,
      // margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.brown,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5.r,
            offset: Offset(3, 3),
          ),
        ],
      ),
      // padding: EdgeInsets.all(10.r),
      child: Image.asset(
        fit: BoxFit.contain,
        'assets/Images/hackathon.png',
        // height: 100.h,width: 120.w,
      ),
    );
  }

  Widget thirdSlider(){
    return Container(
      width: double.infinity,
      // margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.blue.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5.r,
            offset: Offset(3, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(4.r),
      child: Image.asset(
        fit: BoxFit.contain,
        'assets/Images/sports.png',
        // height: 100.h,
        // width: 120.w,
      ),
    );
  }
}
