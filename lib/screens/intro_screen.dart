import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class IntroScreen extends StatelessWidget 
{
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(title: const Text('Scavenger Hunt of PFT')),
      body: Container
      (
        decoration: BoxDecoration
        (
          image: DecorationImage
          (
            image: AssetImage("assets/pft1.jpg"),
            fit: BoxFit.cover, 
          ),
        ),
      child: Center
      (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            const Text
            (
              "Let's start to discover more about PFT!",
              style: TextStyle(
                fontSize: 70, 
                fontWeight: FontWeight.bold,
                color: Colors.white,
                ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizScreen(questionIndex: 0, score: 0)),
                );
              },
              child: const Text("Start the Hunt", style: TextStyle(fontSize:30)),
            ),
          ],
        ),
      ),
      )
    );
  }
}
