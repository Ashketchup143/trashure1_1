import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashure1_1/sidebar.dart';

class Employees extends StatefulWidget {
  const Employees({super.key});

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  Map<String, bool> _selectedOptions = {};
  Map<String, bool> _attendanceStatus = {};
  List<Map<String, dynamic>> _employeesList = [];
  List<Map<String, dynamic>> _filteredEmployees = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  void _fetchEmployees() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('employees').get();

    setState(() {
      _employeesList = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'],
          'position': doc['position'],
          'exp_time_in': doc['exp_time_in'],
          'exp_time_out': doc['exp_time_out'],
          'address': doc['address'],
          'birth_date': doc['birth_date'],
          'contact_number': doc['contact_number'],
          'email_address': doc['email_address'],
          'salary_per_hour': doc['salary_per_hour'],
        };
      }).toList();
      _filteredEmployees = _employeesList;
    });
  }

  void _onSearchChanged() {
    String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredEmployees = _employeesList.where((employee) {
        return employee['name'].toLowerCase().contains(searchTerm) ||
            employee['position'].toLowerCase().contains(searchTerm) ||
            employee['id'].toLowerCase().contains(searchTerm);
      }).toList();
    });
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
                      SizedBox(height: 20),
                      // Search bar
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 430,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(17.5),
                            ),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText:
                                    'Search by employee name, id, or position',
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search),
                              ),
                              onChanged: (value) {
                                _onSearchChanged();
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {
                              _addEmployee(); // Call add employee function
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
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Handle payroll action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0062FF),
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
                                  'Payroll',
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w300)),
                                ),
                                Icon(
                                  Icons.receipt_long_outlined,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: MediaQuery.of(context).size.height * .8,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Column(
                          children: [
                            // Title row
                            Container(
                              child: Row(
                                children: [
                                  title('Employee ID', 3),
                                  title('Name', 3),
                                  title('Position', 3),
                                  title('Exp. Time In', 3),
                                  title('Exp. Time Out', 3),
                                  title('Attendance', 3),
                                  title('Details', 2),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: _filteredEmployees.length,
                                itemBuilder: (context, index) {
                                  var employee = _filteredEmployees[index];
                                  var employeeid = employee['id'];
                                  var name = employee['name'];
                                  var position = employee['position'];
                                  var expTimeIn = employee['exp_time_in'];
                                  var expTimeOut = employee['exp_time_out'];

                                  _selectedOptions[employeeid] ??= false;
                                  _attendanceStatus[employeeid] ??= false;

                                  return _buildCustomCheckboxTile(
                                    employeeid,
                                    employeeid,
                                    name,
                                    position,
                                    expTimeIn,
                                    expTimeOut,
                                    employee,
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
              ),
            ),
          ],
        ),
      ),
    );
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
    String option,
    String employeeid,
    String empname,
    String position,
    String exptimein,
    String exptimeout,
    Map<String, dynamic> employee,
  ) {
    return Column(
      children: [
        CheckboxListTile(
          value: _selectedOptions[option],
          activeColor: Colors.green,
          onChanged: (bool? value) {
            setState(() {
              _selectedOptions[option] = value!;
            });
          },
          title: Row(
            children: [
              _buildText(employeeid, 2),
              _buildTitleText(empname, 2),
              _buildText(position, 2),
              _buildText(exptimein, 2),
              _buildText(exptimeout, 2),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
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
                child: IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {
                    // Navigate to the employee profile screen and pass employee data
                    Navigator.pushNamed(
                      context,
                      '/employeeprofile',
                      arguments: {
                        'id': employee['id'],
                        'name': employee['name'],
                        'position': employee['position'],
                        'address': employee['address'],
                        'birth_date': employee['birth_date'],
                        'contact_number': employee['contact_number'],
                        'email_address': employee['email_address'],
                        'salary_per_hour': employee['salary_per_hour'],
                        'exp_time_in': employee['exp_time_in'],
                        'exp_time_out': employee['exp_time_out'],
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ],
    );
  }

  Widget _buildText(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildTitleText(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _addEmployee() {
    TextEditingController nameController = TextEditingController();
    TextEditingController contactController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController positionController = TextEditingController();
    TextEditingController salaryController = TextEditingController();
    TextEditingController birthDateController = TextEditingController();
    TextEditingController expTimeInController = TextEditingController();
    TextEditingController expTimeOutController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Employee'),
          content: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: contactController,
                    decoration: InputDecoration(labelText: 'Contact Number'),
                  ),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email Address'),
                  ),
                  TextField(
                    controller: positionController,
                    decoration: InputDecoration(labelText: 'Position'),
                  ),
                  TextField(
                    controller: salaryController,
                    decoration: InputDecoration(labelText: 'Salary Per Hour'),
                  ),
                  TextField(
                    controller: birthDateController,
                    decoration: InputDecoration(labelText: 'Birth Date'),
                  ),
                  TextField(
                    controller: expTimeInController,
                    decoration: InputDecoration(
                        labelText: 'Expected Time In (Optional)'),
                  ),
                  TextField(
                    controller: expTimeOutController,
                    decoration: InputDecoration(
                        labelText: 'Expected Time Out (Optional)'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                // Ensure required fields are filled in
                if (nameController.text.isEmpty ||
                    contactController.text.isEmpty ||
                    addressController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    positionController.text.isEmpty ||
                    salaryController.text.isEmpty ||
                    birthDateController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please fill in all required fields')));
                  return;
                }

                // Add new employee to Firestore
                await FirebaseFirestore.instance.collection('employees').add({
                  'name': nameController.text,
                  'contact_number': contactController.text,
                  'address': addressController.text,
                  'email_address': emailController.text,
                  'position': positionController.text,
                  'salary_per_hour': salaryController.text,
                  'birth_date': birthDateController.text,
                  'exp_time_in': expTimeInController.text.isNotEmpty
                      ? expTimeInController.text
                      : "",
                  'exp_time_out': expTimeOutController.text.isNotEmpty
                      ? expTimeOutController.text
                      : "",
                });

                Navigator.of(context).pop(); // Close dialog
                _fetchEmployees(); // Refresh the employee list
              },
              child: Text('Add Employee'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog without adding
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
