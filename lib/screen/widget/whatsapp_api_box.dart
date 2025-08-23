import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WhatsAppApiBox extends StatelessWidget {
  const WhatsAppApiBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // go back to DashboardPage
          },
        ),
      ),
      backgroundColor: Colors.grey[200], // light background
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black, // softer shadow
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row (Logo + WhatsApp Icon)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Side: Logo text
                  const Text(
                    "MSME",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  // Right Side: WhatsApp Icon + Text together
                  Row(
                    children: const [
                      FaIcon(
                        FontAwesomeIcons.whatsapp,
                        size: 25,
                        color: Colors.green,
                      ),
                      SizedBox(width: 6), // small space between icon & text
                      Text(
                        "WhatsApp",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                "Apply for WhatsApp Business API",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Description
              const Text(
                "WhatsApp Business API is an essential step for creating your WhatsApp Business Profile. Once this is done you can broadcast offers, automate notifications and solve for support using Msme Platform",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 20),

              // Requirements Title
              const Text(
                "Requirements",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),

              // Requirements Description
              const Text(
                "Please be ready with a mobile number on which you wish to create your WhatsApp Business Profile.\n\n"
                "Click on \"Start WhatsApp API Registration\" to apply for WhatsApp Business API",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 20),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button click
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.facebook, size: 28, color: Colors.white),
                      Text(
                        "Start WhatsApp API\nRegistration",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
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
    );
  }
}
