import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleInformation extends StatefulWidget {
  @override
  _VehicleInformationState createState() => _VehicleInformationState();
}

class _VehicleInformationState extends State<VehicleInformation> {
  Map<String, dynamic>? vehicleData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the passed vehicle data from the arguments
    vehicleData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  }

  @override
  Widget build(BuildContext context) {
    if (vehicleData == null) {
      // If no vehicle data is available, show an error message
      return Scaffold(
        appBar: AppBar(
          title: Text('Vehicle Information'),
        ),
        body: Center(
          child: Text('No vehicle data available'),
        ),
      );
    }

    // Display vehicle data
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildVehicleDetail('Vehicle ID', vehicleData!['id']),
            buildVehicleDetail(
                'Assigned Driver', vehicleData!['assigned_driver']),
            buildVehicleDetail('Brand', vehicleData!['brand']),
            buildVehicleDetail('Color', vehicleData!['color']),
            buildVehicleDetail('Fuel Type', vehicleData!['fuel_type']),
            buildVehicleDetail(
                'License Plate Number', vehicleData!['license_plate_number']),
            buildVehicleDetail('Model', vehicleData!['model']),
            buildVehicleDetail('Vehicle Type', vehicleData!['vehicle_type']),
            buildVehicleDetail(
                'Weight Limit', vehicleData!['weight_limit'].toString()),

            // Optional fields
            buildVehicleDetail(
                'Last Service Date', vehicleData!['last_service_date']),
            buildVehicleDetail('Next Scheduled Maintenance',
                vehicleData!['next_scheduled_maintenance']),
            buildVehicleDetail('Purchase Date', vehicleData!['purchase_date']),
            buildVehicleDetail('Registration Expire Date',
                vehicleData!['registration_expire_date']),
            buildVehicleDetail(
                'Registration Number', vehicleData!['registration_number']),
            buildVehicleDetail(
                'Year of Manufacture', vehicleData!['year_of_manufacture']),
          ],
        ),
      ),
    );
  }

  Widget buildVehicleDetail(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: GoogleFonts.roboto(
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: GoogleFonts.roboto(),
            ),
          ),
        ],
      ),
    );
  }
}
