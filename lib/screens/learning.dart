import 'package:cominsign/screens/Level_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import '../services/service.dart';

class Learning extends StatefulWidget {
  const Learning({super.key});

  @override
  State<Learning> createState() => _LearningState();
}

class _LearningState extends State<Learning> {

  List levels = [];
  List userLevels = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {

    final l = await Service.getLevels();
    final u = await Service.getUserLevels();

    setState(() {
      levels = l;
      userLevels = u;
      loading = false;
    });
  }

  bool isLocked(int levelId) {
    return !userLevels.any(
      (u) => u["levelId"] == levelId && u["isUnlocked"]
    );
  }

  @override
  Widget build(BuildContext context) {

    if(loading){
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                const Text(
                  'COMMUNISIGN',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'images/download (7).png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: levels.map((level){

                      final locked = isLocked(level["levelId"]);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: LevelCard(
                          levelName: level["name"],
                          coins: level["requiredCoins"],
                          isLocked: locked,
                          gradientColors: [
                            const Color(0xFF80CBC4),
                            const Color(0xFF4DB6AC)
                          ],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LevelScreen(
                                  levelId: level["levelId"],
                                ),
                              ),
                            ).then((_) => loadData());
                          },
                        ),
                      );

                    }).toList(),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
