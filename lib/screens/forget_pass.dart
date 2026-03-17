<<<<<<< HEAD
import 'package:cominsign/screens/resetpass.dart';
import 'package:flutter/material.dart';
=======

  import 'package:flutter/material.dart';
>>>>>>> 446abd06884d0a1906fcf4c0d679c84446e90d28
import '../widgets/gradient_background.dart';
import '../services/api_service.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => ForgetPassState();
}

class ForgetPassState extends State<ForgetPass> {
  final TextEditingController _emailController = TextEditingController();

<<<<<<< HEAD
  // ================= Send Email Function =================
  void _sendEmail() {
=======
  // إرسال الإيميل للسيرفر
  void _sendEmail() async {

>>>>>>> 446abd06884d0a1906fcf4c0d679c84446e90d28
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email'),
          backgroundColor: Colors.red,
        ),
      );
<<<<<<< HEAD
    } 
    else if (!_isValidEmail(email)) {
=======
      return;
    }

    if (!_isValidEmail(email)) {
>>>>>>> 446abd06884d0a1906fcf4c0d679c84446e90d28
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email'),
          backgroundColor: Colors.red,
        ),
      );
<<<<<<< HEAD
    } 
    else {

      // الانتقال لصفحة Reset Password
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(
            email: email,
            token: "123456",
          )
           // مؤقت لحين ربط API
          ),
        );

=======
      return;
    }

    try {

      await ApiService.forgotPassword(email);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Reset link sent to your email"),
          backgroundColor: Colors.green,
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to send email"),
          backgroundColor: Colors.red,
        ),
      );
>>>>>>> 446abd06884d0a1906fcf4c0d679c84446e90d28

    }
  }

<<<<<<< HEAD
  // ================= Email Validation =================
=======
  // التحقق من صحة الإيميل
>>>>>>> 446abd06884d0a1906fcf4c0d679c84446e90d28
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
<<<<<<< HEAD

=======
>>>>>>> 446abd06884d0a1906fcf4c0d679c84446e90d28
      body: GradientBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.05,
          ),
<<<<<<< HEAD

=======
>>>>>>> 446abd06884d0a1906fcf4c0d679c84446e90d28
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

<<<<<<< HEAD
              // ================= COMMUNISIGN =================
=======
              /// COMMUNISIGN
>>>>>>> 446abd06884d0a1906fcf4c0d679c84446e90d28
              Container(
                width: screenWidth * 0.6,
                height: screenHeight * 0.05,
                alignment: Alignment.center,
                child: const Text(
                  'COMMUNISIGN',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.25),

<<<<<<< HEAD
              // ================= Password Recovery =================
=======
              /// Password Recovery
>>>>>>> 446abd06884d0a1906fcf4c0d679c84446e90d28
              Container(
                width: screenWidth * 0.75,
                height: screenHeight * 0.06,
                alignment: Alignment.center,
                child: const Text(
                  'Password Recovery',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2A405D),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

<<<<<<< HEAD
=======
              /// Description
>>>>>>> 446abd06884d0a1906fcf4c0d679c84446e90d28
              const Text(
                'Enter your email',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff2A405D),
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

<<<<<<< HEAD
              // ================= Email Field =================
=======
              /// Email Field
>>>>>>> 446abd06884d0a1906fcf4c0d679c84446e90d28
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 251, 251),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

<<<<<<< HEAD
              // ================= Send Button =================
=======
              /// Send Button
>>>>>>> 446abd06884d0a1906fcf4c0d679c84446e90d28
              SizedBox(
                width: screenWidth * 0.45,
                child: GestureDetector(
                  onTap: _sendEmail,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF2ABC4E),
<<<<<<< HEAD
                          Color(0xFF135624),
=======
                          Color(0xFF135624)
>>>>>>> 446abd06884d0a1906fcf4c0d679c84446e90d28
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),

                    child: const Center(
                      child: Text(
                        'Send',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======

    
>>>>>>> 446abd06884d0a1906fcf4c0d679c84446e90d28
