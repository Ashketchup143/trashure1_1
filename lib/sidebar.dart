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
                  'Trashure',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Color(0xFF4CAF4F),
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
          _buildHoverableListTile(4, Icons.home, 'Dashboard'),
          _buildUsersTile(),
          _buildHoverableListTile(5, Icons.settings, 'Bookings'),
          _buildHoverableListTile(6, Icons.logout, 'Vehicle'),
          _buildHoverableListTile(7, Icons.logout, 'Employees'),
          _buildHoverableListTile(8, Icons.logout, 'Inventory'),
          _buildHoverableListTile(9, Icons.logout, 'Finance'),
          _buildHoverableListTile(10, Icons.logout, 'Settings'),
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
                  Icons.person,
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
                    Icon(
                      _isUsersExpanded ? Icons.expand_less : Icons.expand_more,
                      color:
                          _hoveredIndex == 1 ? Colors.white : Color(0xFF4CAF4F),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    _isUsersExpanded = !_isUsersExpanded; // Toggle dropdown
                  });
                },
              ),
            ),
          ),
        ),
        if (_isUsersExpanded) ...[
          _buildsecondHoverableListTile(2, Icons.account_circle, 'My Account'),
          _buildsecondHoverableListTile(3, Icons.lock, 'Security'),
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
                Navigator.pushNamed(context, route);
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
