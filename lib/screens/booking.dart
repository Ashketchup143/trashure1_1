import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:trashure1_1/sidebar.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime? _selectedDate; // Store the selected date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Sidebar(), // Sidebar widget
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        'Booking',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(17.5),
                                bottomLeft: Radius.circular(17.5),
                              ),
                            ),
                            child: IconButton(
                              iconSize: 17,
                              color: Color.fromARGB(255, 74, 73, 73),
                              icon: Icon(Icons.search),
                              onPressed: () {
                                // Handle search
                              },
                              tooltip: 'Home',
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 400,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(17.5),
                                bottomRight: Radius.circular(17.5),
                              ),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed:
                                _pickDateAndAddBooking, // Open date picker
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4CAF4F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              textStyle: TextStyle(fontSize: 16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 8),
                                Text(
                                  'Add Schedule',
                                  style: GoogleFonts.roboto(
                                    textStyle:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Icon(Icons.add),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: MediaQuery.of(context).size.height * .825,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  title('Name', 2),
                                  title('Address', 2),
                                  title('Date Booked', 1),
                                  title('Est. Total Weight', 1),
                                  title('Type', 1),
                                  title('Status', 1),
                                  title('Details', 1),
                                ],
                              ),
                            ),
                            Container() // Add tile and function here
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to open date picker and add document
  void _pickDateAndAddBooking() {
    showBoardDateTimePicker(
      context: context,
      initialDateTime: DateTime.now(),
      boardPickerMode: BoardPickerMode.date,
      onConfirm: (dateTime) {
        setState(() {
          _selectedDate = dateTime;
        });
        _addBooking(dateTime);
      },
    );
  }

  // Function to add a document to Firestore
  Future<void> _addBooking(DateTime date) async {
    try {
      await FirebaseFirestore.instance.collection('bookings').add({
        'date': date,
        // Add other fields like 'driver' or 'vehicle' if needed
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add booking: $e')),
      );
    }
  }

  Widget title(String text, int fl) {
    return Expanded(
      flex: fl,
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
