import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashure1_1/sidebar.dart'; // Import your custom sidebar

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // Reference to the Firestore collection 'products'
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');

  // Search Controller
  final TextEditingController _searchController = TextEditingController();

  // State variables for storing products and search term
  List<DocumentSnapshot> _allProducts = [];
  List<DocumentSnapshot> _filteredProducts = [];
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _searchController.addListener(_onSearchChanged);
  }

  // Function to fetch all products from Firestore
  Future<void> _fetchProducts() async {
    QuerySnapshot snapshot = await _productsCollection.get();
    setState(() {
      _allProducts = snapshot.docs;
      _filteredProducts = _allProducts;
    });
  }

  // Function to handle search input changes
  void _onSearchChanged() {
    setState(() {
      _searchTerm = _searchController.text.trim().toLowerCase();
      _filteredProducts = _allProducts.where((product) {
        String productName = product['product_name'].toString().toLowerCase();
        String category = product['category'].toString().toLowerCase();
        return productName.contains(_searchTerm) ||
            category.contains(_searchTerm);
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
                      'Settings',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 20),
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
                              hintText: 'Search by product name or category',
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
                            _showAddProductDialog(context);
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
                                'Add Product',
                                style: GoogleFonts.roboto(
                                    textStyle:
                                        TextStyle(fontWeight: FontWeight.w300)),
                              ),
                              Icon(Icons.add),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: Column(
                          children: [
                            // Row with titles
                            Container(
                              color: Colors.grey[300],
                              child: Row(
                                children: [
                                  _titleCell('Product Name', 3),
                                  _titleCell('Category', 2),
                                  _titleCell('Price', 2),
                                  _titleCell('Details', 4),
                                ],
                              ),
                            ),
                            Expanded(
                              child: _filteredProducts.isEmpty
                                  ? Center(child: Text('No products found'))
                                  : ListView.builder(
                                      itemCount: _filteredProducts.length,
                                      itemBuilder: (context, index) {
                                        var product = _filteredProducts[index];
                                        String productId = product.id;
                                        String productName =
                                            product['product_name'];
                                        String category = product['category'];
                                        String price =
                                            product['price'].toString();
                                        String details = product['details'];
                                        String picture = product['picture'];

                                        return _buildProductTile(
                                            productId,
                                            productName,
                                            category,
                                            price,
                                            details,
                                            picture);
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom widget to build a title cell
  Widget _titleCell(String title, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
          color: Colors.grey[200],
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  // Helper function to truncate the details text
  String _truncateDetails(String details, {int limit = 10}) {
    if (details.split(' ').length > limit) {
      return details.split(' ').take(limit).join(' ') + '...';
    }
    return details;
  }

  // Custom widget to build a product tile with category, price, details, and picture
  Widget _buildProductTile(String productId, String productName,
      String category, String price, String details, String picture) {
    return ListTile(
      leading: picture.isNotEmpty
          ? ClipOval(
              child: Image.network(
                picture,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            )
          : Icon(Icons.image_not_supported, size: 50),
      title: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              productName,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(flex: 1, child: Container()), // Spacer between columns
          Expanded(
            flex: 2,
            child: Text(category),
          ),
          Expanded(
            flex: 2,
            child: Text('Php${price}/kg'),
          ),
          Expanded(
            flex: 4,
            child: Text(
              _truncateDetails(details), // Truncate the details
            ),
          ),
        ],
      ),
      tileColor: Color.fromARGB(255, 255, 255, 255),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showEditProductDialog(context, productId, productName, category,
                  price, details, picture);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _showDeleteProductDialog(context, productId);
            },
          ),
        ],
      ),
    );
  }

  // Function to show a dialog to add a new product
  void _showAddProductDialog(BuildContext context) {
    final TextEditingController productNameController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController detailsController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Product'),
          content: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                children: [
                  TextField(
                    controller: productNameController,
                    decoration: InputDecoration(labelText: 'Product Name'),
                  ),
                  TextField(
                    controller: categoryController,
                    decoration: InputDecoration(labelText: 'Category'),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: detailsController,
                    decoration: InputDecoration(labelText: 'Details'),
                  ),
                  TextField(
                    controller: imageUrlController,
                    decoration:
                        InputDecoration(labelText: 'Image URL (Optional)'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFF4CAF4F)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFF4CAF4F)),
              onPressed: () async {
                String productName = productNameController.text.trim();
                String category = categoryController.text.trim();
                double price =
                    double.tryParse(priceController.text.trim()) ?? 0;
                String details = detailsController.text.trim();
                String imageUrl = imageUrlController.text.trim();

                if (productName.isNotEmpty && category.isNotEmpty) {
                  await _productsCollection.add({
                    'product_name': productName,
                    'category': category,
                    'price': price,
                    'details': details,
                    'picture': imageUrl,
                  });
                  _fetchProducts(); // Refresh products after adding a new one
                }
                Navigator.of(context).pop();
              },
              child: Text('Add Product'),
            ),
          ],
        );
      },
    );
  }

  // Function to show a dialog to confirm deletion of a product
  void _showDeleteProductDialog(BuildContext context, String productId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Product'),
          content: Text('Are you sure you want to delete this product?'),
          actions: [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFF4CAF4F)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                await _productsCollection.doc(productId).delete();
                _fetchProducts(); // Refresh products after deletion
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // Function to show a dialog to edit an existing product
  void _showEditProductDialog(
    BuildContext context,
    String productId,
    String productName,
    String category,
    String price,
    String details,
    String picture,
  ) {
    final TextEditingController productNameController =
        TextEditingController(text: productName);
    final TextEditingController categoryController =
        TextEditingController(text: category);
    final TextEditingController priceController =
        TextEditingController(text: price);
    final TextEditingController detailsController =
        TextEditingController(text: details);
    final TextEditingController imageUrlController =
        TextEditingController(text: picture);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Product'),
          content: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                children: [
                  TextField(
                    controller: productNameController,
                    decoration: InputDecoration(labelText: 'Product Name'),
                  ),
                  TextField(
                    controller: categoryController,
                    decoration: InputDecoration(labelText: 'Category'),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: detailsController,
                    decoration: InputDecoration(labelText: 'Details'),
                  ),
                  TextField(
                    controller: imageUrlController,
                    decoration:
                        InputDecoration(labelText: 'Image URL (Optional)'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFF4CAF4F)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFF4CAF4F)),
              onPressed: () async {
                String newProductName = productNameController.text.trim();
                String newCategory = categoryController.text.trim();
                double newPrice =
                    double.tryParse(priceController.text.trim()) ?? 0;
                String newDetails = detailsController.text.trim();
                String newImageUrl = imageUrlController.text.trim();

                if (newProductName.isNotEmpty && newCategory.isNotEmpty) {
                  await _productsCollection.doc(productId).update({
                    'product_name': newProductName,
                    'category': newCategory,
                    'price': newPrice,
                    'details': newDetails,
                    'picture': newImageUrl,
                  });
                  _fetchProducts(); // Refresh products after editing
                }
                Navigator.of(context).pop();
              },
              child: Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}
