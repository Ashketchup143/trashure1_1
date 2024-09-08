import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashure1_1/sidebar.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  Map<String, bool> _selectedOptions = {
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
              // SizedBox(
              //   width: 50,
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Users',
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
                                  // top: BorderSide(),
                                  // bottom: BorderSide(),
                                  // left: BorderSide()),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(17.5),
                                      bottomLeft: Radius.circular(17.5))),
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
                                  // top: BorderSide(),
                                  // bottom: BorderSide(),
                                  // left: BorderSide()),

                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(17.5),
                                      bottomRight: Radius.circular(17.5))),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder
                                      .none, // Removes the default TextField border
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4CAF4F),
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
                                    'Schedule Pick Up',
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w300)),
                                  ), // The text

                                  Icon(
                                    Icons.add,
                                    size: 25,
                                    color: Color.fromARGB(255, 230, 229, 229),
                                  ), // The icon
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                              Column(
                                children: [
                                  _buildCustomCheckboxTile(
                                      '1',
                                      'John Doe',
                                      '123 Main St',
                                      '2024-09-01',
                                      '50kg',
                                      'Recyclable',
                                      'Booked'),
                                  _buildCustomCheckboxTile(
                                      '2',
                                      'Jane Smith',
                                      '456 Elm St',
                                      '2024-09-05',
                                      '30kg',
                                      'Metal',
                                      'Completed'),
                                  _buildCustomCheckboxTile(
                                      '3',
                                      'Alice Brown',
                                      '789 Oak St',
                                      '2024-09-10',
                                      '20kg',
                                      'Plastic',
                                      'In progress'),
                                  _buildCustomCheckboxTile(
                                      '4',
                                      'Alice Brown',
                                      '789 Oak St',
                                      '2024-09-10',
                                      '20kg',
                                      'Tin',
                                      'Delayed'),
                                  _buildCustomCheckboxTile(
                                      '5',
                                      'John Doe',
                                      '123 Main St',
                                      '2024-09-01',
                                      '50kg',
                                      'Recyclable',
                                      'Unbooked'),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
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
    String name,
    String address,
    String dateBooked,
    String totalWeight,
    String type,
    String status,
  ) {
    // Determine the color based on the status
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'booked':
        statusColor = Color.fromARGB(255, 66, 167, 250);
        break;
      case 'completed':
        statusColor = Color.fromARGB(255, 76, 181, 80);
        break;
      case 'in progress':
        statusColor = Colors.grey;
        break;
      case 'delayed':
        statusColor = Color.fromARGB(255, 249, 81, 70);
        break;
      case 'unbooked':
        statusColor = Color(0xFFF5D322);
        break;
      default:
        statusColor =
            Color.fromARGB(255, 150, 141, 61); // Default color if no match
    }

    return CheckboxListTile(
      value: _selectedOptions[option],
      activeColor: Colors.green, // Turns green when checked
      onChanged: (bool? value) {
        setState(() {
          _selectedOptions[option] = value!;
        });
      },
      title: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(address),
          ),
          Expanded(
            flex: 1,
            child: Text(dateBooked),
          ),
          Expanded(
            flex: 1,
            child: Text(totalWeight),
          ),
          Expanded(
            flex: 1,
            child: Text(type),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 22.5,
              width: 20,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    offset: Offset(0, 1), // changes position of shadow (x, y)
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  status,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(Icons.info_outline),
          ),
        ],
      ),
      controlAffinity: ListTileControlAffinity.leading, // Checkbox on the left
    );
  }
}
