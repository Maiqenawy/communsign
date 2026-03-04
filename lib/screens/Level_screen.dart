import 'dart:convert';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/gradient_background.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen>
    with SingleTickerProviderStateMixin {

  int coins = 0;
  int currentQuestionIndex = 0;
  bool isLevelComplete = false;

  late SharedPreferences prefs;
  late ConfettiController _confettiController;

  late AnimationController _restartFadeController;
  late Animation<double> _restartFade;

  final List<String> questions = const [
    'Welcome','Hungry','Tired','Cold','Hot',
    'Thirsty','Sorry','Happy','Thank you',
  ];

  final List<String> allPhrases = const [
    'Welcome','Hungry','Tired','Cold','Hot',
    'Thirsty','Sorry','Happy','Thank you',
  ];

  Map<String,bool?> answers = {};

  @override
  void initState() {
    super.initState();

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));

    for (var p in allPhrases) {
      answers[p] = null;
    }

    _restartFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _restartFade =
        CurvedAnimation(parent: _restartFadeController, curve: Curves.easeOut);

    _restartFadeController.forward();

    _loadData();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _restartFadeController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      coins = prefs.getInt('coins') ?? 0;
      currentQuestionIndex =
          prefs.getInt('currentQuestionIndex') ?? 0;

      if (currentQuestionIndex >= questions.length) {
        isLevelComplete = true;
      }
    });
  }

  Future<void> _saveData() async {
    await prefs.setInt('coins', coins);
    await prefs.setInt('currentQuestionIndex', currentQuestionIndex);
  }

  void checkAnswer(String selectedPhrase) {
    if (currentQuestionIndex >= questions.length) return;

    final correct = questions[currentQuestionIndex];

    setState(() {
      if (selectedPhrase == correct) {
        answers[selectedPhrase] = true;
        coins++;
        currentQuestionIndex++;

        if (currentQuestionIndex >= questions.length) {
          isLevelComplete = true;
          _confettiController.play();
        }
      } else {
        if (answers[selectedPhrase] != true) {
          answers[selectedPhrase] = false;
        }
      }
    });

    _saveData();
  }

  void resetGame() {
    setState(() {
      coins = 0;
      currentQuestionIndex = 0;
      isLevelComplete = false;
      for (var k in answers.keys) {
        answers[k] = null;
      }
    });

    _restartFadeController
      ..reset()
      ..forward();

    _saveData();
  }

  @override
  Widget build(BuildContext context) {

    final shownIndex =
        currentQuestionIndex < questions.length
            ? currentQuestionIndex + 1
            : questions.length;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'COMMUNISIGN',
          style: TextStyle(
            color: Color(0xFF2C5F7C),
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),

      body: Column(
        children: [

          /// coins
          Padding(
            padding: const EdgeInsets.only(right:16,top:8),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children:[
                  Image.asset('images/download (8).png',
                      width:40,height:40),
                  Text('$coins',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C5F7C),
                      )),
                ],
              ),
            ),
          ),

          /// avatar floating area
          SizedBox(
            height: 220,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [

                /// avatar (floating style)
                Positioned(
                  top: 0,
                  child: Image.asset(
                    'images/download (9).png',
                    height: 220,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height:6),

          Text(
            'Question $shownIndex of ${questions.length}',
            style: const TextStyle(
                fontSize:14,color: Color(0xFF2C5F7C)),
          ),

          const SizedBox(height:6),

          Expanded(
            child: GradientBackground(
              child: Column(
                children: [

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: GridView.count(
                        physics:
                        const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 2,
                        children: allPhrases.map((p){
                          return PhraseCard(
                            text:p,
                            answerStatus:answers[p],
                            onTap:()=>checkAnswer(p),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  FadeTransition(
                    opacity:_restartFade,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(bottom:12),
                      child: GestureDetector(
                        onTap:resetGame,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.refresh,
                                color:Colors.red),
                            SizedBox(width:6),
                            Text('Restart',
                                style: TextStyle(
                                  color:Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize:16,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhraseCard extends StatelessWidget {

  final String text;
  final bool? answerStatus;
  final VoidCallback onTap;

  const PhraseCard({
    super.key,
    required this.text,
    required this.answerStatus,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    Color? border;
    IconData? icon;

    if(answerStatus==true){
      border=Colors.green;
      icon=Icons.check_circle;
    }else if(answerStatus==false){
      border=Colors.red;
      icon=Icons.cancel;
    }

    return GestureDetector(
      onTap:onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: border!=null
              ? Border.all(color:border,width:2)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize:15,
                    color: Color(0xFF2C5F7C))),
            if(icon!=null)
              Icon(icon,color:border,size:20),
          ],
        ),
      ),
    );
  }
}
