import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashure1_1/sidebar.dart';

class Vehicle extends StatefulWidget {
  const Vehicle({super.key});

  @override
  State<Vehicle> createState() => _VehicleState();
}

class _VehicleState extends State<Vehicle> {
  Map<String, bool> _selectedOptions = {};
  List<Map<String, dynamic>> vehicles = [];
  List<Map<String, dynamic>> filteredVehicles = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchVehicles();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> fetchVehicles() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('vehicles').get();
    setState(() {
      vehicles = snapshot.docs.map((doc) {
        Map<String, dynamic> vehicleData = doc.data() as Map<String, dynamic>;
        vehicleData['id'] = doc.id; // Include document ID
        return vehicleData;
      }).toList();
      filteredVehicles = vehicles;

      // Initialize _selectedOptions for each vehicle if not already initialized
      for (var vehicle in vehicles) {
        String vehicleId = vehicle['id']; // Use document ID here
        if (!_selectedOptions.containsKey(vehicleId)) {
          _selectedOptions[vehicleId] = false;
        }
      }
    });
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredVehicles = vehicles.where((vehicle) {
        return vehicle['id']
                .toString()
                .toLowerCase()
                .contains(query) || // Include search for Vehicle ID
            vehicle['assigned_driver']
                .toString()
                .toLowerCase()
                .contains(query) ||
            vehicle['brand'].toString().toLowerCase().contains(query) ||
            vehicle['color'].toString().toLowerCase().contains(query) ||
            vehicle['fuel_type'].toString().toLowerCase().contains(query) ||
            vehicle['model'].toString().toLowerCase().contains(query) ||
            vehicle['vehicle_type'].toString().toLowerCase().contains(query) ||
            vehicle['weight_limit'].toString().toLowerCase().contains(query) ||
            vehicle['license_plate_number']
                .toString()
                .toLowerCase()
                .contains(query);
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        'Vehicles',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
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
                                    'Search by vehicle ID, assigned_driver, brand, color, fuel_type, model, vehicle_type, weight_limit, and license_plate_number',
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {
                              _showAddVehicleDialog(
                                  context); // Call add vehicle function
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
                                  'Add Vehicle',
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w300)),
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
                        decoration: BoxDecoration(border: Border.all()),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          border:
                                              Border(bottom: BorderSide()))),
                                  title('Vehicle ID', 1),
                                  title('Brand', 2),
                                  title('Vehicle Type', 1),
                                  title('Model', 1),
                                  title('Plate Number', 1),
                                  title('Assigned Driver', 2),
                                  title('Weight Limit', 1),
                                  title('Details', 1),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                children: filteredVehicles.map((vehicle) {
                                  return _buildCustomCheckboxTile(
                                    vehicle,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
        decoration: BoxDecoration(border: Border(bottom: BorderSide())),
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

  Widget _buildCustomCheckboxTile(Map<String, dynamic> vehicle) {
    String vehicleId = vehicle['id'] ?? 'N/A';
    return CheckboxListTile(
      value: _selectedOptions[vehicleId],
      activeColor: Colors.green,
      onChanged: (bool? value) {
        setState(() {
          _selectedOptions[vehicleId] = value ?? false;
        });
      },
      title: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(vehicleId,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
          Expanded(flex: 1, child: Text(vehicle['brand'] ?? 'N/A')),
          Expanded(flex: 1, child: Text(vehicle['vehicle_type'] ?? 'N/A')),
          Expanded(flex: 1, child: Text(vehicle['model'] ?? 'N/A')),
          Expanded(
              flex: 1, child: Text(vehicle['license_plate_number'] ?? 'N/A')),
          Expanded(flex: 2, child: Text(vehicle['assigned_driver'] ?? 'N/A')),
          Expanded(
              flex: 1,
              child: Text(vehicle['weight_limit'].toString() ?? 'N/A')),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                // Navigate to '/vehicleinformation' with the vehicle data
                Navigator.pushNamed(
                  context,
                  '/vehicleinformation',
                  arguments: vehicle, // Passing the vehicle data as arguments
                );
              },
            ),
          ),
        ],
      ),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  void _showAddVehicleDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    // Controllers for text fields
    TextEditingController assignedDriverController = TextEditingController();
    TextEditingController brandController = TextEditingController();
    TextEditingController colorController = TextEditingController();
    TextEditingController fuelTypeController = TextEditingController();
    TextEditingController licensePlateController = TextEditingController();
    TextEditingController modelController = TextEditingController();
    TextEditingController vehicleTypeController = TextEditingController();
    TextEditingController weightLimitController = TextEditingController();

    // Optional fields
    TextEditingController lastServiceDateController = TextEditingController();
    TextEditingController nextScheduledMaintenanceController =
        TextEditingController();
    TextEditingController purchaseDateController = TextEditingController();
    TextEditingController registrationExpireDateController =
        TextEditingController();
    TextEditingController registrationNumberController =
        TextEditingController();
    TextEditingController yearOfManufactureController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Vehicle'),
          content: Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width * 0.4,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildTextFormField('Brand', brandController, true),
                    buildTextFormField('Color', colorController, true),
                    buildTextFormField('Fuel Type', fuelTypeController, true),
                    buildTextFormField(
                        'License Plate Number', licensePlateController, true),
                    buildTextFormField('Model', modelController, true),
                    buildTextFormField(
                        'Vehicle Type', vehicleTypeController, true),
                    buildTextFormField(
                        'Weight Limit', weightLimitController, true,
                        isNumeric: true),

                    // Optional fields
                    buildTextFormField('Assigned Driver (optional)',
                        assignedDriverController, false),
                    buildTextFormField('Last Service Date (optional)',
                        lastServiceDateController, false),
                    buildTextFormField('Next Scheduled Maintenance (optional)',
                        nextScheduledMaintenanceController, false),
                    buildTextFormField('Purchase Date (optional)',
                        purchaseDateController, false),
                    buildTextFormField('Registration Expire Date (optional)',
                        registrationExpireDateController, false),
                    buildTextFormField('Registration Number (optional)',
                        registrationNumberController, false),
                    buildTextFormField('Year of Manufacture (optional)',
                        yearOfManufactureController, false),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Map<String, dynamic> vehicleData = {
                    'assigned_driver': assignedDriverController.text,
                    'brand': brandController.text,
                    'color': colorController.text,
                    'fuel_type': fuelTypeController.text,
                    'license_plate_number': licensePlateController.text,
                    'model': modelController.text,
                    'vehicle_type': vehicleTypeController.text,
                    'weight_limit': double.parse(weightLimitController.text),

                    // Optional fields
                    'last_service_date':
                        lastServiceDateController.text.isNotEmpty
                            ? lastServiceDateController.text
                            : "",
                    'next_scheduled_maintenance':
                        nextScheduledMaintenanceController.text.isNotEmpty
                            ? nextScheduledMaintenanceController.text
                            : "",
                    'purchase_date': purchaseDateController.text.isNotEmpty
                        ? purchaseDateController.text
                        : "",
                    'registration_expire_date':
                        registrationExpireDateController.text.isNotEmpty
                            ? registrationExpireDateController.text
                            : "",
                    'registration_number':
                        registrationNumberController.text.isNotEmpty
                            ? registrationNumberController.text
                            : "",
                    'year_of_manufacture':
                        yearOfManufactureController.text.isNotEmpty
                            ? yearOfManufactureController.text
                            : "",
                  };

                  // Add to Firestore
                  await FirebaseFirestore.instance
                      .collection('vehicles')
                      .add(vehicleData);

                  // Refresh the list of vehicles
                  fetchVehicles();

                  // Close the dialog
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add Vehicle'),
            ),
          ],
        );
      },
    );
  }

  Widget buildTextFormField(
      String labelText, TextEditingController controller, bool isRequired,
      {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'Please enter $labelText';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}
