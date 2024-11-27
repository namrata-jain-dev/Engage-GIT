
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cultural_fest.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
      'title': "Cultural",
      'color': Colors.purple[100],
      'imagePath': "assets/Images/cultural_grid.png", // Replace with your asset path
      'onTap': () {
        print("Cultural Event Clicked");

      },
    },
    {
      'title': "Sports",
      'color': Colors.yellow[100],
      'imagePath':"assets/Images/sport_grid.png",
      'onTap': () {
        print("Sports Event Clicked");
      },
    },
    {
      'title': "Social",
      'color': Colors.green[100],
      'imagePath': "assets/Images/social_grid.jpg",
      'onTap': () {
        print("Social Event Clicked");
      },
    },
    {
      'title': "Technical",
      'color': Colors.red[100],
      'imagePath': "assets/Images/tech_grid.png",
      'onTap': () {
        print("Technical Event Clicked");
      },
    },
  ];


  int _selectedIndex = 0;

  // Method to handle bottom navigation bar item click
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _currentIndex = 0 ;

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
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.teal ,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 4.r),
                child: Center(
                  child: Text(
                    'Explore Events',
                    style: TextStyle(
                      fontSize: 14.sp,
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 10.h),
            // GridView Section
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding:  EdgeInsets.symmetric(horizontal: 16.r,vertical: 8.r),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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


  Widget _buildEventCard(
      BuildContext context, {
        required String title,
        required Color color,
        required String imagePath,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return CulturalEventsScreen();
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Padding(
              padding: EdgeInsets.all(8.r),
              child: Container(
                width:double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(8.r),
                  child: Center(
                    child: Text(
                      title,
                      style:  TextStyle(fontSize: 16.sp, ),
                    ),
                  ),
                ),
              ),
            ),

            Image.asset(
                imagePath,
                // height: 50
            ), // Add proper image assets

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
        color: Colors.lightGreenAccent.shade100,
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
