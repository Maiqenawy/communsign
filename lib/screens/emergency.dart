import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import 'package:geolocator/geolocator.dart';
import '../services/emergency_service.dart';
import '../services/firebase_service.dart';
import 'dart:convert';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({super.key});

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  List pictograms = [];
  String token = "YOUR_TOKEN";

  @override
  void initState() {
    super.initState();
    loadData();
    FirebaseService.init(token);
  }

  Future<void> loadData() async {
    final data = await EmergencyService.getPictograms(token);
    setState(() {
      pictograms = data;
    });
  }

  Future<String> getLocation() async {
    await Geolocator.requestPermission();
    final pos = await Geolocator.getCurrentPosition();
    return "${pos.latitude},${pos.longitude}";
  }

  Future<void> sendSOS(int id) async {
    String location = await getLocation();

    bool success =
        await EmergencyService.sendSOS(token, id, location);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(success ? "SOS Sent 🚨" : "Failed")),
    );
  }

  IconData getIcon(String name) {
    switch (name) {
      case "hospital":
        return Icons.local_hospital;
      case "medicine":
        return Icons.medication;
      case "danger":
        return Icons.warning;
      case "fall":
        return Icons.accessibility_new;
      case "police":
        return Icons.local_police;
      case "breath":
        return Icons.air;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Emergency",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: pictograms.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (_, i) {
                    final item = pictograms[i];

                    return GestureDetector(
                      onTap: () => sendSOS(item["pictogramId"]),
                      child: Container(
                        decoration: BoxDecoration(
                          color: cs.surface.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              getIcon(item["iconName"]),
                              size: 50,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                item["sentenceText"],
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
