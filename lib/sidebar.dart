import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int _hoveredIndex = -1; // To track the hovered tile
  bool _isUsersExpanded = false; // To track if the Users dropdown is expanded

  // Function to handle user logout
  Future<void> _handleLogout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out from Firebase

      // Show a SnackBar notification for successful logout
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You have successfully logged out.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to the login screen after logout with a slight delay to allow the SnackBar to be visible
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(
            context, '/login'); // Replace '/login' with your login route
      });
    } catch (e) {
      print('Error signing out: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Color.fromARGB(255, 109, 108, 108),
            blurStyle: BlurStyle.normal,
            offset: Offset.zero,
          ),
        ],
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TRASHURE',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Color(0xFF46B948),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/unnamed.jpg'),
                ),
                SizedBox(height: 15),
                Text(
                  'Kristine Gallawan',
                  style: GoogleFonts.poppins(),
                ),
                SizedBox(height: 20),
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                ),
              ],
            ),
          ),
          _buildHoverableListTile(
              4, Icons.dashboard_outlined, 'Dashboard', '/dashboard'),
          _buildUsersTile(),
          _buildHoverableListTile(
              5, Icons.library_books_outlined, 'Bookings', '/bookings'),
          _buildHoverableListTile(
              6, Icons.directions_car_outlined, 'Vehicle', '/vehicle'),
          _buildHoverableListTile(
              7, Icons.groups_outlined, 'Employees', '/employee'),
          _buildHoverableListTile(
              8, Icons.inventory_outlined, 'Inventory', '/inventory'),
          _buildHoverableListTile(
              9, Icons.payment_outlined, 'Finance', '/finance'),
          _buildHoverableListTile(
              10, Icons.settings_outlined, 'Settings', '/settings'),
          // Logout tile with logout function
          _buildHoverableListTile(11, Icons.logout_outlined, 'Logout', '',
              onTap: _handleLogout),
        ],
      ),
    );
  }

  Widget _buildUsersTile() {
    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _hoveredIndex = 1),
          onExit: (_) => setState(() => _hoveredIndex = -1),
          child: Container(
            height: 65,
            color: _hoveredIndex == 1
                ? Color(0xFF4CAF4F)
                : Colors.transparent, // Changes color on hover
            child: Center(
              child: ListTile(
                leading: Icon(
                  Icons.person_outlined,
                  color: _hoveredIndex == 1 ? Colors.white : Color(0xFF4CAF4F),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Users',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: _hoveredIndex == 1
                              ? Colors.white
                              : Color(0xFF4CAF4F),
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isUsersExpanded =
                              !_isUsersExpanded; // Toggle dropdown
                        });
                      },
                      child: Container(
                        height: 60, // Adjust height as needed
                        width: 60, // Adjust width as needed
                        color: Colors.transparent,
                        child: Center(
                          child: Icon(
                            _isUsersExpanded
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: _hoveredIndex == 1
                                ? Colors.white
                                : Color(0xFF4CAF4F),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/users');
                },
              ),
            ),
          ),
        ),
        if (_isUsersExpanded) ...[
          _buildsecondHoverableListTile(
              2, Icons.house_outlined, 'Households', '/userhouse'),
          _buildsecondHoverableListTile(
              3, Icons.business_center_outlined, 'Business', '/userbusiness'),
        ],
      ],
    );
  }

  Widget _buildsecondHoverableListTile(
      int index, IconData icon, String title, String route) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Container(
          height: 55,
          color: _hoveredIndex == index
              ? Color(0xFF4CAF4F)
              : Colors.transparent, // Changes color on hover
          child: Center(
            child: ListTile(
              leading: Icon(
                icon,
                color:
                    _hoveredIndex == index ? Colors.white : Color(0xFF4CAF4F),
              ),
              title: Text(
                title,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: _hoveredIndex == index
                        ? Colors.white
                        : Color(0xFF4CAF4F),
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, route);
              },
            ),
          ),
        ),
      ),
    );
  }

  // Updated method with an optional onTap callback
  Widget _buildHoverableListTile(
      int index, IconData icon, String title, String route,
      {VoidCallback? onTap}) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: Container(
        height: 65,
        color: _hoveredIndex == index
            ? Color(0xFF4CAF4F)
            : Colors.transparent, // Changes color on hover
        child: Center(
          child: ListTile(
            leading: Icon(
              icon,
              color: _hoveredIndex == index ? Colors.white : Color(0xFF4CAF4F),
            ),
            title: Text(
              title,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color:
                      _hoveredIndex == index ? Colors.white : Color(0xFF4CAF4F),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
            onTap: onTap ??
                () {
                  if (route.isNotEmpty) {
                    Navigator.pushReplacementNamed(context, route);
                  }
                },
          ),
        ),
      ),
    );
  }
}
