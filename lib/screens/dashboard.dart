import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:trashure1_1/sidebar.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Map<String, bool> _selectedOptions = {
    '1': false,
    '2': false,
    '3': false,
    '4': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Sidebar(), // Your Sidebar widget on the left
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildCustomCheckboxTile('1', 'John Doe', '123 Main St',
                        '2024-09-01', '50kg', 'Recyclable', 'Complete'),
                    _buildCustomCheckboxTile('2', 'Jane Smith', '456 Elm St',
                        '2024-09-05', '30kg', 'Organic', 'Pending'),
                    _buildCustomCheckboxTile('3', 'Alice Brown', '789 Oak St',
                        '2024-09-10', '20kg', 'Plastic', 'In Progress'),
                    _buildCustomCheckboxTile('4', 'Alice Brown', '789 Oak St',
                        '2024-09-10', '20kg', 'Plastic', 'In Progress'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomCheckboxTile(
    String option,
    String name,
    String address,
    String dateBooked,
    String totalWeight,
    String typeStatus,
    String details,
  ) {
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
          // Name - Takes 2 Flex
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
          // Address - Takes 3 Flex
          Expanded(
            flex: 3,
            child: Text('Address: $address'),
          ),
          // Date Booked - Takes 2 Flex
          Expanded(
            flex: 2,
            child: Text('Date: $dateBooked'),
          ),
          // Total Weight - Takes 2 Flex
          Expanded(
            flex: 2,
            child: Text('Weight: $totalWeight'),
          ),
          // Type Status - Takes 2 Flex
          Expanded(
            flex: 2,
            child: Text('Type: $typeStatus'),
          ),
          // Details - Takes 2 Flex
          Expanded(
            flex: 2,
            child: Text('Details: $details'),
          ),
        ],
      ),
      controlAffinity: ListTileControlAffinity.leading, // Checkbox on the left
    );

    // Custom Checkbox Tile for multiple selections
    // Widget _buildCustomCheckboxTile(String option) {
    //   return CheckboxListTile(
    //     value: _selectedOptions[option],
    //     activeColor: Colors.green, // Turns green when checked
    //     // Background color when checked
    //     onChanged: (bool? value) {
    //       setState(() {
    //         _selectedOptions[option] = value!;
    //       });
    //     },
    //     controlAffinity: ListTileControlAffinity.leading, // Checkbox on the left
    //   );
  }
}
