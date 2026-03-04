import 'package:cominsign/screens/Level_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class Learning extends StatelessWidget {
  const Learning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(),
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Title
                const Text(
                  'COMMUNISIGN',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),

                const SizedBox(height: 30),

                // Illustration Image (Transparent Background)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.transparent, // شفاف
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
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.image,
                          size: 80,
                          color: Colors.grey[400],
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Level Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Level 1 - Unlocked
                      LevelCard(
                        levelName: 'Level 1',
                        coins: 0,
                        isLocked: false,
                        gradientColors: [Color(0xFF80CBC4), Color(0xFF4DB6AC)],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LevelScreen()),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      // Level 2 - Locked
                      LevelCard(
                        levelName: 'Level 2',
                        coins: 9,
                        isLocked: true,
                        gradientColors: [Color(0xFF81C784), Color(0xFF66BB6A)],
                        onTap: () {},
                      ),

                      const SizedBox(height: 16),

                      // Level 3 - Locked
                      LevelCard(
                        levelName: 'Level 3',
                        coins: 18,
                        isLocked: true,
                        gradientColors: [Color(0xFF26A69A), Color(0xFF00897B)],
                        onTap: () {},
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LevelCard extends StatelessWidget {
  final String levelName;
  final int coins;
  final bool isLocked;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const LevelCard({
    super.key,
    required this.levelName,
    required this.coins,
    required this.isLocked,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLocked ? null : onTap,
      borderRadius: BorderRadius.circular(20),
      child: Opacity(
        opacity: isLocked ? 0.7 : 1.0,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Level Name
              Text(
                levelName,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              // Coins and Lock
              Row(
                children: [
                  // Lock Icon (for locked levels)
                  if (isLocked)
                    const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),

                  // Coin Image
                  Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFF176), Color(0xFFFFC107)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(2, 4),
                              blurRadius: 4,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.orange.shade800,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            'images/download (8).png', // صورة الكوين الذهبي
                            width: 30,
                            height: 30,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.monetization_on,
                                color: Colors.yellow[700],
                                size: 22,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        coins.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy LevelPage for navigation
class LevelPage extends StatelessWidget {
  const LevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Level 1 Page',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
