import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trashure1_1/sidebar.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  // Dropdown selections
  String? selectedDriver;
  String? selectedVehicle;

  // Checkbox states
  Map<String, bool> _selectedOptions = {};

  @override
  void initState() {
    super.initState();
    dateController.text =
        "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
  }

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
                child: Form(
                  key: _formKey,
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
                      SizedBox(height: 20),
                      // Date Picker
                      Row(
                        children: [
                          Container(
                            width: 300,
                            child: TextFormField(
                              controller: dateController,
                              decoration: InputDecoration(
                                labelText: "Select Date",
                                border: OutlineInputBorder(),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    selectedDate = pickedDate;
                                    dateController.text =
                                        "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                                  });
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: _addBooking, // Add booking
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
                                Text(
                                  'Add Schedule',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  ),
                                ),
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('employees')
                                  .where('position', isEqualTo: 'Driver')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                }
                                var employees = snapshot.data?.docs ?? [];
                                return DropdownButtonFormField<String>(
                                  value: selectedDriver,
                                  decoration: InputDecoration(
                                    labelText: 'Select Driver',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: employees.map((doc) {
                                    var employeeData =
                                        doc.data() as Map<String, dynamic>;
                                    return DropdownMenuItem<String>(
                                      value: employeeData['name'],
                                      child: Text(employeeData['name']),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedDriver = newValue;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('vehicles')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                }
                                var vehicles = snapshot.data?.docs ?? [];
                                return DropdownButtonFormField<String>(
                                  value: selectedVehicle,
                                  decoration: InputDecoration(
                                    labelText: 'Select Vehicle',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: vehicles.map((doc) {
                                    var vehicleData =
                                        doc.data() as Map<String, dynamic>;
                                    String vehicleLabel =
                                        "${vehicleData['brand']} ${vehicleData['model']}";
                                    return DropdownMenuItem<String>(
                                      value: vehicleLabel,
                                      child: Text(vehicleLabel),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedVehicle = newValue;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: _addBooking, // Add booking
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0062FF),
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
                                Text(
                                  'Add Driver Vehicle',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  ),
                                ),
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Titles Row for Schedule Info
                      Container(
                        height: MediaQuery.of(context).size.height * .650,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                title('Schedule ID', 2),
                                title('Date', 2),
                                title('Driver', 1),
                                title('Vehicle', 1),
                                title('Status', 1),
                                title('Details', 1),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('bookings')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }
                                    var bookings = snapshot.data?.docs ?? [];

                                    return ListView(
                                      children: bookings.map((doc) {
                                        var bookingData =
                                            doc.data() as Map<String, dynamic>;
                                        var scheduleId = doc
                                            .id; // Use document ID as schedule ID
                                        return _buildCustomCheckboxTile(
                                            scheduleId, bookingData);
                                      }).toList(),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Checkbox Tiles for bookings
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

  // Function to add a document to Firestore
  Future<void> _addBooking() async {
    if (selectedDriver == null || selectedVehicle == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a driver and a vehicle')),
      );
      return;
    }

    try {
      DocumentReference bookingRef =
          await FirebaseFirestore.instance.collection('bookings').add({
        'date': Timestamp.fromDate(selectedDate),
        'driver': selectedDriver,
        'vehicle': selectedVehicle,
        'status': 'Pending', // Default status
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
          border: Border(bottom: BorderSide()),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.roboto(
                textStyle: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomCheckboxTile(
      String scheduleId, Map<String, dynamic> bookingData) {
    // Extract fields from bookingData
    DateTime date =
        (bookingData['date'] as Timestamp?)?.toDate() ?? DateTime.now();
    String driver = bookingData['driver'] ?? 'N/A';
    String vehicle = bookingData['vehicle'] ?? 'N/A';
    String status = bookingData['status'] ?? 'Pending';

    return CheckboxListTile(
      value: _selectedOptions[scheduleId] ?? false,
      activeColor: Colors.green,
      onChanged: (bool? value) {
        setState(() {
          _selectedOptions[scheduleId] = value ?? false;
        });
      },
      title: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(scheduleId,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
          Expanded(
              flex: 2, child: Text("${date.year}-${date.month}-${date.day}")),
          Expanded(flex: 1, child: Text(driver)),
          Expanded(flex: 1, child: Text(vehicle)),
          Expanded(flex: 1, child: Text(status)),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                // Handle details or additional actions here
              },
            ),
          ),
        ],
      ),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
