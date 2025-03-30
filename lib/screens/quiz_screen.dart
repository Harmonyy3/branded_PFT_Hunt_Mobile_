import 'package:flutter/material.dart';
import 'dart:async';
import 'package:logging/logging.dart';
import 'result_screen.dart';
import 'package:audioplayers/audioplayers.dart';


final _logger = Logger('QuizScreen');

//questions
const List<Map<String, dynamic>> quizQuestions = [
  {
    "question": "Can you find the person with the grey shirt?",
    "image": "assets/q1.png", 
    "targetPosition": {"left": 90.0, "top": 250.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the Baguette in the Penera store?",
    "image": "assets/q2.png",
    "targetPosition": {"left": 60.0, "top": 400.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the MMR sign?",
    "image": "assets/q3.png",
    "targetPosition": {"left": 90.0, "top": 30.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the picture on the ground?",
    "image": "assets/q4.png",
    "targetPosition": {"left": 100.0, "top": 380.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the pressure screen?",
    "image": "assets/q5.png",
    "targetPosition": {"left": 150.0, "top": 90.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the smoothie king drink?",
    "image": "assets/q7.png",
    "targetPosition": {"left": 220.0, "top": 550.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the purple glove?",
    "image": "assets/q8.png",
    "targetPosition": {"left": 89.0, "top": 310.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the certificate?",
    "image": "assets/q9.png",
    "targetPosition": {"left": 140.0, "top": 180.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the computer?",
    "image": "assets/q10.png",
    "targetPosition": {"left": 60.0, "top": 250.0, "width": 200.0, "height": 200.0}
  },

  {
    "question": "Can you find the crushed car?",
    "image": "assets/q6.png",
    "targetPosition": {"left": 60.0, "top": 250.0, "width": 200.0, "height": 200.0}
  },
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
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isSoundLoaded = false;
  bool showFeedback = false;
  bool isCorrect = false;
  Offset? clickPosition;

  //trace the position
  GlobalKey targetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _startTimer();
    _initializeAudio();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTargetPosition();
    });
  }

  Future<void> _initializeAudio() async {
    try {
      await audioPlayer.setSource(AssetSource('sounds/correct.mp3'));
      await audioPlayer.setSource(AssetSource('sounds/wrong.mp3'));
      setState(() {
        isSoundLoaded = true;
      });
    } catch (e) {
      _logger.severe('Error initializing audio: $e');
    }
  }

  Future<void> playSound(String sound) async {
    try {
      if (!isSoundLoaded) {
        await _initializeAudio();
      }
      await audioPlayer.stop(); // Stop any currently playing sound
      await audioPlayer.play(AssetSource(sound));
    } catch (e) {
      _logger.severe('Error playing sound: $e');
    }
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

  void _showFeedback(bool correct, Offset position) {
    setState(() {
      showFeedback = true;
      isCorrect = correct;
      clickPosition = position;
    });

    // Hide feedback after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          showFeedback = false;
        });
      }
    });
  }

  Future<void> _goToNextScreen(bool won) async
  {
    _timer?.cancel();
    int newScore = won ? widget.score + 10 : widget.score;
    _logger.info("Score: $newScore");

    try {
      if (won) {
        await playSound('sounds/correct.mp3'); 
      } else {
        await playSound('sounds/wrong.mp3'); 
      }
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      _logger.severe('Error in sound playback: $e');
    }

    if (!mounted) return;

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
      Navigator.pushReplacement(
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
      appBar: AppBar(
        title: Text('Find the Object!'), 
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 23), 
        centerTitle: true, 
        backgroundColor: const Color(0xFF461D7C)
      ),
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
            top: 30,
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
          // Clickable area for wrong answers
          Positioned.fill(
            child: GestureDetector(
              onTapDown: (details) {
                if (!foundObject) {
                  _showFeedback(false, details.localPosition);
                  _goToNextScreen(false);
                }
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // Hidden Object (Clickable)
          Positioned(
            left: target["left"],
            top: target["top"],
            child: GestureDetector(
              onTapDown: (details) 
              {
                if (!foundObject) 
                {
                  setState(() {
                    foundObject = true;
                  });
                  _showFeedback(true, details.localPosition);
                  _goToNextScreen(true);
                }
              },
              child: Container(
                width: target["width"],
                height: target["height"],
                color: Colors.transparent,
              ),
            ),
          ),
          // Feedback overlay
          if (showFeedback && clickPosition != null)
            Positioned(
              left: clickPosition!.dx - 25, // Center the feedback on the click position
              top: clickPosition!.dy - 25,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCorrect ? Colors.green.withOpacity(0.7) : Colors.red.withOpacity(0.7),
                ),
                child: isCorrect
                    ? const Icon(Icons.check, color: Colors.white, size: 30)
                    : const Icon(Icons.close, color: Colors.white, size: 30),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() 
  {
    audioPlayer.stop();
    audioPlayer.dispose();
    _timer?.cancel();
    super.dispose();
  }
}