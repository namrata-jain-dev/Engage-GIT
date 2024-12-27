import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engage/cultural%20event/cultural_fest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _formKey = GlobalKey<FormState>();

  String? eventName;
  DateTime? eventDate;
  String? coordinatorName;
  String? facultyCoordinator;
  String? eventType;
  String? additionalDetails;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController facultyNameController = TextEditingController();
  final TextEditingController addDetailsController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != eventDate) {
      setState(() {
        eventDate = pickedDate;
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Handle the form submission logic here
      eventName = eventNameController.text;
      String eventHeadingDate = _dateController.text;
      facultyCoordinator = facultyNameController.text;
      additionalDetails  = addDetailsController.text;

      debugPrint('Event Name: $eventName');
      debugPrint('Event Date: $eventDate');
      // debugPrint('Coordinator: $coordinatorName');
      debugPrint('Faculty Coordinator: $facultyCoordinator');
      debugPrint('Event Type: $eventType');
      debugPrint('Additional Details: $additionalDetails');
      saveInDb();

    }

  }

  void saveInDb() async{

    CollectionReference events = FirebaseFirestore.instance.collection('events');

    await events.doc('$eventType').set({
      'eventType': eventType,
      'eventDate': eventDate,
      'eventName': eventName,
      'facultyCoordinator': facultyCoordinator,
      'description' : additionalDetails,
    });

    _dateController.clear();
    eventNameController.clear();
    facultyNameController.clear();
    addDetailsController.clear();
    eventType = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CulturalEventsScreen()));
        },
          icon: Icon(Icons.keyboard_backspace_sharp),
        ),
        title: Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: eventNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    labelText: 'Event Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the event name';
                  }
                  return null;
                },
                onSaved: (value) => eventName = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Event Date',
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  ),

                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Coordinator Name'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter the coordinator name';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) => coordinatorName = value,
              // ),
              SizedBox(height: 20),
              TextFormField(
                controller: facultyNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    labelText: 'Faculty Coordinator'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the faculty coordinator name';
                  }
                  return null;
                },
                onSaved: (value) => facultyCoordinator = value,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Event Type',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r),),
                ),
                items: [
                  DropdownMenuItem(value: 'Technical', child: Text('Technical')),
                  DropdownMenuItem(value: 'Social', child: Text('Social')),
                  DropdownMenuItem(value: 'Cultural', child: Text('Cultural')),
                  DropdownMenuItem(value: 'Sports', child: Text('Sports')),
                ],

                onChanged: (value) {
                  setState(() {
                    eventType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an event type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: addDetailsController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    labelText: 'Additional Details'),
                maxLines: 3,
                onSaved: (value) => additionalDetails = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
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
                    child:Text(
                      'Create Event',
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
      ),
    );
  }
}
