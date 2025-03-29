import 'package:flutter/material.dart';
import 'dart:async';
import 'package:logging/logging.dart';
import 'result_screen.dart';

final _logger = Logger('QuizScreen');

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
