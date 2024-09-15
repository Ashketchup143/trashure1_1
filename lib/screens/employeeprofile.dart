import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeProfileScreen extends StatefulWidget {
  @override
  _EmployeeProfileScreenState createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _positionController;
  late TextEditingController _addressController;
  late TextEditingController _birthDateController;
  late TextEditingController _contactController;
  late TextEditingController _emailController;
  late TextEditingController _salaryController;
  late TextEditingController _expTimeInController;
  late TextEditingController _expTimeOutController;

  bool _isLoading = false;
  Map<String, dynamic>? employee; // Make employee nullable initially

  @override
  void initState() {
    super.initState();
    // Initialize controllers with empty values initially
    _nameController = TextEditingController();
    _positionController = TextEditingController();
    _addressController = TextEditingController();
    _birthDateController = TextEditingController();
    _contactController = TextEditingController();
    _emailController = TextEditingController();
    _salaryController = TextEditingController();
    _expTimeInController = TextEditingController();
    _expTimeOutController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access ModalRoute arguments in didChangeDependencies, which is safe
    if (employee == null) {
      employee =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (employee != null) {
        // Set initial values of the controllers with the employee data
        _nameController.text = employee!['name'];
        _positionController.text = employee!['position'];
        _addressController.text = employee!['address'];
        _birthDateController.text = employee!['birth_date'];
        _contactController.text = employee!['contact_number'];
        _emailController.text = employee!['email_address'];
        _salaryController.text = employee!['salary_per_hour'];
        _expTimeInController.text = employee!['exp_time_in'];
        _expTimeOutController.text = employee!['exp_time_out'];
      }
    }
  }

  // Save updated employee information to Firestore
  void _updateEmployee(String employeeId) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('employees')
          .doc(employeeId)
          .update({
        'name': _nameController.text,
        'position': _positionController.text,
        'address': _addressController.text,
        'birth_date': _birthDateController.text,
        'contact_number': _contactController.text,
        'email_address': _emailController.text,
        'salary_per_hour': _salaryController.text,
        'exp_time_in': _expTimeInController.text,
        'exp_time_out': _expTimeOutController.text,
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Employee information has been updated.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update employee information.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Profile', style: GoogleFonts.poppins()),
        backgroundColor: Colors.green,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (employee != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileField('Employee ID', employee!['id'],
                              isEditable: false),
                          SizedBox(height: 16),
                          _buildProfileField('Name', _nameController.text,
                              controller: _nameController),
                          SizedBox(height: 16),
                          _buildProfileField(
                              'Position', _positionController.text,
                              controller: _positionController),
                          SizedBox(height: 16),
                          _buildProfileField('Address', _addressController.text,
                              controller: _addressController),
                          SizedBox(height: 16),
                          _buildProfileField(
                              'Birth Date', _birthDateController.text,
                              controller: _birthDateController),
                          SizedBox(height: 16),
                          _buildProfileField(
                              'Contact Number', _contactController.text,
                              controller: _contactController),
                          SizedBox(height: 16),
                          _buildProfileField(
                              'Email Address', _emailController.text,
                              controller: _emailController),
                          SizedBox(height: 16),
                          _buildProfileField(
                              'Salary Per Hour', _salaryController.text,
                              controller: _salaryController),
                          SizedBox(height: 16),
                          _buildProfileField(
                              'Expected Time In', _expTimeInController.text,
                              controller: _expTimeInController),
                          SizedBox(height: 16),
                          _buildProfileField(
                              'Expected Time Out', _expTimeOutController.text,
                              controller: _expTimeOutController),
                        ],
                      ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (employee != null) {
                            _updateEmployee(employee!['id']);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                        child: Text('Save Changes'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // Helper widget to build each profile field with optional editing
  Widget _buildProfileField(String fieldName, String fieldValue,
      {TextEditingController? controller, bool isEditable = true}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '$fieldName:',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: isEditable
              ? TextField(
                  controller: controller,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                )
              : Text(
                  fieldValue,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
