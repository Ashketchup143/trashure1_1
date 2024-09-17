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
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white)),
                                ),
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {
                              _assignDriverToVehicle();
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
                                  'Assign Driver',
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white)),
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
          Expanded(
              flex: 1,
              child: Text(
                vehicle['brand'] ?? 'N/A',
                style: TextStyle(fontSize: 16),
              )),
          Expanded(
              flex: 1,
              child: Text(
                vehicle['vehicle_type'] ?? 'N/A',
                style: TextStyle(fontSize: 16),
              )),
          Expanded(
              flex: 1,
              child: Text(vehicle['model'] ?? 'N/A',
                  style: TextStyle(fontSize: 16))),
          Expanded(
              flex: 1,
              child: Text(vehicle['license_plate_number'] ?? 'N/A',
                  style: TextStyle(fontSize: 16))),
          Expanded(
              flex: 2,
              child: Text(vehicle['assigned_driver'] ?? 'N/A',
                  style: TextStyle(fontSize: 16))),
          Expanded(
              flex: 1,
              child: Text(vehicle['weight_limit'].toString() ?? 'N/A',
                  style: TextStyle(fontSize: 16))),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                // Navigate to '/vehicleinformation' with the vehicle data
                Navigator.pushNamed(
                  context,
                  '/vehicleinformation',
                  arguments: vehicle,
                );
              },
            ),
          ),
        ],
      ),
      controlAffinity: ListTileControlAffinity.leading,
      dense: true,
      selectedTileColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void _assignDriverToVehicle() async {
    String? selectedVehicleId;
    for (var entry in _selectedOptions.entries) {
      if (entry.value == true) {
        selectedVehicleId = entry.key;
        break;
      }
    }

    if (selectedVehicleId == null) {
      // Show a message if no vehicle is selected
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('No Vehicle Selected'),
            content: Text('Please select a vehicle to assign a driver.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Fetch drivers
    List<Map<String, dynamic>> drivers = await _fetchDrivers();

    // Show dialog to select a driver
    // Show dialog to select a driver
    showDialog(
      context: context,
      builder: (context) {
        String? selectedDriverId;
        String? selectedDriverName;

        return AlertDialog(
          title: Text('Assign Driver'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedDriverId,
                hint: Text('Select a driver'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDriverId = newValue;
                    // Find the driver's name from the list
                    selectedDriverName = drivers.firstWhere(
                        (driver) => driver['id'] == selectedDriverId)['name'];
                  });
                },
                items: drivers.map<DropdownMenuItem<String>>((driver) {
                  return DropdownMenuItem<String>(
                    value: driver['id'], // Use driver ID as the value
                    child:
                        Text(driver['name'] ?? 'N/A'), // Display driver's name
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedDriverId != null && selectedDriverName != null) {
                  // Assign the driver to the vehicle (use driver's name)
                  _updateVehicleWithDriver(
                      selectedVehicleId!, selectedDriverName!);
                  Navigator.pop(context);
                }
              },
              child: Text('Assign'),
            ),
          ],
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> _fetchDrivers() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('employees')
        .where('position', isEqualTo: 'Driver')
        .get();

    return snapshot.docs.map((doc) {
      Map<String, dynamic> driverData = doc.data() as Map<String, dynamic>;
      driverData['id'] = doc.id; // Include document ID
      driverData['name'] =
          driverData['name'] ?? 'N/A'; // Ensure driver's name is included
      return driverData;
    }).toList();
  }

  void _updateVehicleWithDriver(
      String vehicleId, String selectedDriverName) async {
    // Update the vehicle document in Firestore with the assigned driver's name
    await FirebaseFirestore.instance
        .collection('vehicles')
        .doc(vehicleId)
        .update({'assigned_driver': selectedDriverName});

    // Refresh the vehicle list
    fetchVehicles();
  }

  Future<void> _showAddVehicleDialog(BuildContext context) async {
    // Implement this function to show a dialog for adding a vehicle
  }
}
