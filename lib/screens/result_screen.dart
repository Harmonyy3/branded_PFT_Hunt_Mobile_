import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class ResultScreen extends StatelessWidget 
{
  final int finalScore;

  const ResultScreen({super.key, required this.finalScore});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(title: const Text("Game Over!")),
      backgroundColor: const Color.fromARGB(255, 211, 115, 227),
      body: Center
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            Text
            (
              "Your final score: $finalScore",
              style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton
            (
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                );
              },
              child: const Text("Play Again?", style: TextStyle(fontSize:35),),
            ),
          ],
        ),
      ),
    );
  }
}