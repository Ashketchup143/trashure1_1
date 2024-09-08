import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int _hoveredIndex = -1; // To track the hovered tile
  bool _isUsersExpanded = false; // To track if the Users dropdown is expanded

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
          _buildHoverableListTile(11, Icons.logout_outlined, 'Logout', '')
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

  Widget _buildHoverableListTile(
      int index, IconData icon, String title, String route) {
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
            onTap: () {
              Navigator.pushReplacementNamed(context, route);
              // Handle navigation or other actions here
            },
          ),
        ),
      ),
    );
  }
}
