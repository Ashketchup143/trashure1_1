import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:trashure1_1/sidebar.dart';
import 'package:google_fonts/google_fonts.dart';

class Employees extends StatefulWidget {
  const Employees({super.key});

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  Map<String, bool> _selectedOptions = {
    '1': false,
    '2': false,
    '3': false,
    '4': false,
    '5': false,
  };

  // Map to keep track of the attendance status (time in or out)
  Map<String, bool> _attendanceStatus = {
    '1': false,
    '2': false,
    '3': false,
    '4': false,
    '5': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Sidebar(),
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
                          'Employees',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(17.5),
                                    bottomLeft: Radius.circular(17.5)),
                              ),
                              child: IconButton(
                                iconSize: 17,
                                color: Color.fromARGB(255, 74, 73, 73),
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  // Handle button press
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
                                      bottomRight: Radius.circular(17.5))),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4CAF4F),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                textStyle: TextStyle(fontSize: 16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: 8),
                                  Text(
                                    'Add Employee',
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Icon(Icons.add),
                                ],
                              ),
                            ),
                            Container(
                              width: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF0062FF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8), // Button padding
                                textStyle:
                                    TextStyle(fontSize: 16), // Text style
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // Keep the button size minimal
                                children: [
                                  SizedBox(
                                      width: 8), // Space between icon and text
                                  Text(
                                    'Payroll',
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w300)),
                                  ), // The text
                                  Icon(
                                    Icons.receipt_long_outlined,
                                    size: 20,
                                  ), // The icon
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
                                    title('Employee ID', 2),
                                    title('Name', 3),
                                    title('Position', 3),
                                    title('Exp. Time In', 3),
                                    title('Exp. Time Out', 3),
                                    title('Attendance', 3),
                                    title('Details', 2),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  _buildCustomCheckboxTile(
                                      '1',
                                      '001',
                                      'John Doe',
                                      'Manager',
                                      '9:00 AM',
                                      '5:00 PM',
                                      'Attendance',
                                      'History'),
                                  _buildCustomCheckboxTile(
                                      '2',
                                      '002',
                                      'Jane Smith',
                                      'Assistant',
                                      '9:00 AM',
                                      '5:00 PM',
                                      'Attendance',
                                      'History'),
                                  // Add more employees as needed
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget title(String text, int fl) {
    return Expanded(
        flex: fl,
        child: Container(
          height: 20,
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(),
          )),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ));
  }

  Widget _buildCustomCheckboxTile(
      String option,
      String employeeid,
      String empname,
      String position,
      String exptimein,
      String exptimeout,
      String attendance,
      String history) {
    return CheckboxListTile(
      value: _selectedOptions[option],
      activeColor: Colors.green,
      onChanged: (bool? value) {
        setState(() {
          _selectedOptions[option] = value!;
        });
      },
      title: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              employeeid,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(empname),
          ),
          Expanded(
            flex: 2,
            child: Text(position),
          ),
          Expanded(
            flex: 2,
            child: Text(exptimein),
          ),
          Expanded(
            flex: 2,
            child: Text(exptimeout),
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                // Toggle attendance status
                setState(() {
                  _attendanceStatus[option] = !_attendanceStatus[option]!;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _attendanceStatus[option]!
                    ? Colors.red // Time Out
                    : Colors.blue, // Time In
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: Text(
                _attendanceStatus[option]! ? 'Time Out' : 'Time In',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(Icons.info_outline),
          ),
        ],
      ),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
