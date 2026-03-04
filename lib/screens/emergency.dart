import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Contact',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF2F2F7),
        fontFamily: 'SF Pro Display',
      ),
      home: const NewContactPage(),
    );
  }
}

class NewContactPage extends StatefulWidget {
  const NewContactPage({super.key});

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  bool _showPhoneField = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _relationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF1C2B4A);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: Column(
          children: [
            // Navigation Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Text(
                    'New Contact',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 17,
                            color: darkBlue,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 17,
                            color: darkBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Avatar Section
            Container(
              width: double.infinity,
              color: const Color(0xFFF2F2F7),
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2.5),
                    ),
                    child: const Icon(
                      CupertinoIcons.person,
                      size: 64,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            // Spacer
            const SizedBox(height: 8),

            // Name Fields
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildTextField(
                    controller: _firstNameController,
                    hintText: 'First name',
                    showDivider: true,
                  ),
                  _buildTextField(
                    controller: _lastNameController,
                    hintText: 'Last name',
                    showDivider: false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Phone Section
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Add phone button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showPhoneField = true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: Color(0xFF34C759),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Text(
                            'add phone',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFF1C2B4A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_showPhoneField) ...[
                    const Divider(height: 1, color: Color(0xFFE5E5EA)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Color(0xFF1C2B4A),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Phone number',
                          hintStyle: TextStyle(
                            fontSize: 17,
                            color: Color(0xFFB0B0BA),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Relation Field
            Container(
              color: Colors.white,
              child: _buildTextField(
                controller: _relationController,
                hintText: 'Relation',
                showDivider: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool showDivider,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 17,
              color: Color(0xFF1C2B4A),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 17,
                color: Color(0xFFB0B0BA),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        if (showDivider)
          const Divider(
            height: 1,
            color: Color(0xFFE5E5EA),
            indent: 16,
          ),
      ],
    );
  }
}