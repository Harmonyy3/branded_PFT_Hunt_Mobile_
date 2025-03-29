import 'package:flutter/material.dart';
import 'dart:async';
import 'package:logging/logging.dart';
//import 'package:audioplayers/audioplayers.dart';

final _logger = Logger('QuizScreen');

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LSU Scavenger Hunt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:Color(0xFF461D7C)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

//navigation bar through the app
class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _selectedIndex = 0;

  //the order of the screens
  final List<Widget> _screens = [
    const WelcomeScreen(),
    const Mapscreen(),
    const Helpscreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined, color: Color(0xFF461D7C)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, color: Color(0xFF461D7C)),
            label: 'PFT Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline, color: Color(0xFF461D7C)),
            label: 'Instruction',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF461D7C),
        onTap: _onItemTapped,
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to NavigatorBar after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavigatorBar()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF461D7C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/lsu_logo_gold.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
// home Screen
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guest', style: TextStyle(color: Colors.white, fontSize: 23)),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 23),
        centerTitle: true,
        backgroundColor: Color(0xFF461D7C),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/lsu1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "PFT Scavenger Hunt:\nFind the Object!",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const IntroScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  backgroundColor:Color(0xFF461D7C),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Begin",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const IntroScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  backgroundColor: Color(0xFF461D7C),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Level",
                  style: TextStyle(
                    fontSize: 25,
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




//map
class Mapscreen extends StatelessWidget {
  const Mapscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PFT Map', style: TextStyle(color: Colors.white, fontSize: 23)),
        backgroundColor: Color(0xFF461D7C),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF461D7C),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Header Card
          Card(
            elevation: 8,
            color: Colors.white.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  Icon(Icons.map_outlined, color: Colors.white, size: 48),
                  SizedBox(height: 8),
                  Text(
                    'PFT Building Layout',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Explore different floors of the PFT building',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // First Floor Map
          _buildMapSection(
            context: context,
            title: 'First Floor',
            image: 'assets/map1.png',
            description: 'Main entrance and common areas',
          ),
          
          const SizedBox(height: 16),
          
          // Second Floor Map
          _buildMapSection(
            context: context,
            title: 'Second Floor',
            image: 'assets/map2.png',
            description: 'Classrooms and study areas',
          ),
          
          const SizedBox(height: 16),
          
          // Third Floor Map
          _buildMapSection(
            context: context,
            title: 'Third Floor',
            image: 'assets/map3.png',
            description: 'Offices and research facilities',
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection({
    required BuildContext context,
    required String title,
    required String image,
    required String description,
  }) {
    return Card(
      elevation: 4,
      color: Colors.white.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
          GestureDetector(
            onTap: () => _showFullImage(context, image, title),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    image,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.fullscreen,
                        color: Colors.white,
                        size: 20,
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

  void _showFullImage(BuildContext context, String imagePath, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              // Full-screen image
              InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
              // Close button
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}



// Intro Screen
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


//questions
const List<Map<String, dynamic>> quizQuestions = [
  {
    "question": "Can you find the dark purple chair?",
    "image": "assets/q1.png", 
    "targetPosition": {"left": 850.0, "top": 250.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the Baguette in the Penera store?",
    "image": "assets/q2.png",
    "targetPosition": {"left": 90.0, "top": 286.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the MMR sign?",
    "image": "assets/q3.png",
    "targetPosition": {"left": 650.0, "top": 50.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the green can?",
    "image": "assets/q4.png",
    "targetPosition": {"left": 185.0, "top": 320.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the pressure screen?",
    "image": "assets/q5.png",
    "targetPosition": {"left": 280.0, "top": 90.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the crushed car?",
    "image": "assets/q6.png",
    "targetPosition": {"left": 600.0, "top": 250.0, "width": 200.0, "height": 200.0}
  }
];


// Quiz Screen
class QuizScreen extends StatefulWidget 
{
  final int questionIndex;
  final int score;

  const QuizScreen({super.key, required this.questionIndex, required this.score});

  @override
  QuizScreenState createState() => QuizScreenState();
}
  class QuizScreenState extends State<QuizScreen> 
  {
  int timeLeft = 10;
  Timer? _timer;
  bool foundObject = false;
  //final AudioPlayer audioPlayer = AudioPlayer();
  bool isSoundLoaded=false;

  //trace the position
  GlobalKey targetKey= GlobalKey();

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) 
    {
    getTargetPosition();
  });
  }

  void preloadSounds() async 
  {
    //await audioPlayer.setSource(AssetSource('sounds/correct.mp3'));
    //await audioPlayer.setSource(AssetSource('sounds/wrong.mp3'));
    //setState(() {
    //  isSoundLoaded = true;
    //});
  }

  void playSound(String sound) async {
    //await audioPlayer.play(AssetSource(sound));
  }

  void _startTimer() 
  {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) 
    {
      if (timeLeft > 0) 
      {
        setState(() {
          timeLeft--;
        });
      } 
      else 
      {
        _goToNextScreen(false);
      }
    });
  }

  //get position
  void getTargetPosition(){
    if (targetKey.currentContext != null) {
      RenderBox? renderBox = targetKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        Offset position = renderBox.localToGlobal(Offset.zero);
        _logger.info('Target position: left: ${position.dx}, top: ${position.dy}');
      }
    }
  }

  void _goToNextScreen(bool won) async
  {
    _timer?.cancel();
    int newScore = won ? widget.score + 10 : widget.score;

    if (won) {
      //playSound('sounds/correct.mp3'); 
    } else {
      //playSound('sounds/wrong.mp3'); 
    }
    _logger.info("Score: $newScore");
    await Future.delayed(Duration(seconds: 2)); // Delay for sound to play

    if (!mounted) return; // Check if the widget is still mounted


    if (widget.questionIndex < quizQuestions.length - 1) 
    {
      Navigator.pushReplacement(
        context,        
        MaterialPageRoute(
          builder: (context) => QuizScreen(
            questionIndex: widget.questionIndex + 1,
            score: newScore,
          ),
        ),
      );
    } 
    else 
    {
      Navigator.pushReplacement
      (
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(finalScore: newScore),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final questionData = quizQuestions[widget.questionIndex];
    final target = questionData["targetPosition"];

    return Scaffold(
      appBar: AppBar(title: Text('Find the Object!')),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              questionData["image"],
              fit: BoxFit.cover,
            ),
          ),

          // Question Text
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.black.withOpacity(0.5),
              child: Text(
                "${questionData["question"]} (⏳ $timeLeft sec)",
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Hidden Object (Clickable)
          Positioned(
            left: target["left"],

            top: target["top"],

            child: GestureDetector(

              onTap: () 
              {
                if (!foundObject) 
                {
                  setState(() {
                    foundObject = true;
                  }
                  );
                  _goToNextScreen(true);
                }
              },

              child: Container(
                width: target["width"],
                height: target["height"],
                color: Colors.transparent,//Colors.transparent, // Invisible tap area
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() 
  {
    //audioPlayer.dispose();
    _timer?.cancel();
    super.dispose();
  }
}

// Result Screen
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

