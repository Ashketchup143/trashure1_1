import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, size: 30),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Opens the sidebar
            },
          ),
        ),
      ),
    );
  }
}

//if need dynamically

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:trashure1_1/sidebar.dart';

// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   Map<String, bool> _selectedOptions = {};

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Row(
//           children: [
//             Sidebar(),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     // Fetch the data from Firestore using a StreamBuilder
//                     Expanded(
//                       child: StreamBuilder<QuerySnapshot>(
//                         stream: FirebaseFirestore.instance
//                             .collection('your_collection') // Replace with your collection name
//                             .snapshots(),
//                         builder: (context, snapshot) {
//                           if (!snapshot.hasData) {
//                             return Center(child: CircularProgressIndicator());
//                           }

//                           final documents = snapshot.data!.docs;

//                           // Dynamically create a checkbox tile for each document
//                           return ListView.builder(
//                             itemCount: documents.length,
//                             itemBuilder: (context, index) {
//                               var doc = documents[index];
//                               var docId = doc.id;
//                               var name = doc['name']; // Firestore field
//                               var address = doc['address'];
//                               var dateBooked = doc['dateBooked'];
//                               var totalWeight = doc['totalWeight'];
//                               var typeStatus = doc['typeStatus'];
//                               var details = doc['details'];

//                               // Initialize the checkbox state if it's not already in the map
//                               if (!_selectedOptions.containsKey(docId)) {
//                                 _selectedOptions[docId] = false;
//                               }

//                               return _buildCustomCheckboxTile(
//                                 docId,
//                                 name,
//                                 address,
//                                 dateBooked,
//                                 totalWeight,
//                                 typeStatus,
//                                 details,
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Custom Checkbox Tile for multiple selections with data from Firestore
//   Widget _buildCustomCheckboxTile(
//     String option,
//     String name,
//     String address,
//     String dateBooked,
//     String totalWeight,
//     String typeStatus,
//     String details,
//   ) {
//     return CheckboxListTile(
//       value: _selectedOptions[option],
//       activeColor: Colors.green, // Turns green when checked
//       onChanged: (bool? value) {
//         setState(() {
//           _selectedOptions[option] = value!;
//         });
//       },
//       title: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               name,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text('Address: $address'),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text('Date: $dateBooked'),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text('Weight: $totalWeight'),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text('Type: $typeStatus'),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text('Details: $details'),
//           ),
//         ],
//       ),
//       controlAffinity: ListTileControlAffinity.leading, // Checkbox on the left
//     );
//   }
// }
