import 'package:flutter/material.dart';

class Helpscreen extends StatelessWidget {
  const Helpscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Instruction', 
          style: TextStyle(color: Colors.white, fontSize: 23)),
        backgroundColor: Color(0xFF461D7C),
      ),
      backgroundColor: Color(0xFF461D7C),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Welcome Card
          Card(
            elevation: 8,
            color: Colors.white.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  Icon(Icons.emoji_events, color: Colors.amber, size: 48),
                  SizedBox(height: 8),
                  Text(
                    'Welcome Tigers!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
           // Instruction Cards
          _buildInstructionCard(
            icon: Icons.timer,
            title: 'Time Limit',
            description: '10 seconds per level to find the object',
          ),
          _buildInstructionCard(
            icon: Icons.stars,
            title: 'Scoring',
            description: 'Win 10 points for each found object\nPerfect score is 100',
          ),
          _buildInstructionCard(
            icon: Icons.volume_up,
            title: 'Sound Feedback',
            description: 'Listen for sound cues to know if you found the right object',
          ),
          
          const SizedBox(height: 24),
          
          // Good Luck Card
          Card(
            elevation: 8,
            color: Colors.white.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                 children: const [
                  Icon(Icons.favorite, color: Color.fromARGB(255, 234, 106, 149)),
                  SizedBox(height: 8),
                  Text(
                    'Good luck and have fun, Tigers!',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
   Widget _buildInstructionCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                          color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
