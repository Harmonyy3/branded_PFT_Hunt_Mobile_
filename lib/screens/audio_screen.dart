import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'map_screen.dart';
import 'help_screen.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> with TickerProviderStateMixin {
  final AudioPlayer audioPlayer = AudioPlayer();
  int? currentlyPlayingIndex;
  bool isPlaying = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> audioTracks = [
    {
      'title': 'Capstone Gallery',
      'description': 'Introduction to the PFT building and its history',
      'icon': Icons.school,
      'audioPath': 'sounds/stop1-welcome-the-capstone-gallery.mp3',
      'imagePath': 'assets/q1.png',
    },
    {
      'title': 'Cambre Atrium',
      'description': 'one of three main common spaces in Patrick F. Taylor Hall',
      'icon': Icons.school,
      'audioPath': 'sounds/stop2-the-cambre-atrium.mp3',
      'imagePath': 'assets/q7.png',
    },
    {
      'title': 'DOW Chemical Unit Operations Laboratory',
      'description': 'Learning lab for chemical engineering students',
      'icon': Icons.school,
      'audioPath': 'sounds/stop3-dow-chemical-unit-operations-laboratory.mp3',
      'imagePath': 'assets/q8.png',
    },  
    {
      'title': 'BASF Sustainable Living Laboratory',
      'description': 'The lab space is dedicated to research investigating sustainable solutions',
      'icon': Icons.school,
      'audioPath': 'sounds/stop4-the-basf-sustainable-living-laboratory.mp3',
      'imagePath': 'assets/basf.jpg',
    },  
    {
      'title': 'Civil Engineering',
      'description': 'Students test concrete for strength and damage, test and create asphalt, test the chemical composition and strength of soils',
      'icon': Icons.school,
      'audioPath': 'sounds/stop7-civil-engineering-laboratories.mp3',
      'imagePath': 'assets/civillab.jpg',
    },
    {
      'title': 'Robotics Lab (1300)',
      'description': 'Information about robotics facilities',
      'icon': Icons.school,
      'audioPath': 'sounds/stop8-robotics-laboratory.mp3',
      'imagePath': 'assets/robotics.jpg',
    },
    {
      'title': 'Proto Lab (2272)',
      'description': 'A microprocessor interfacing lab and a proto lab',
      'icon': Icons.school,
      'audioPath': 'sounds/stop11-mark-and-carolyn-guidry-electrical-engineering-laboratory.mp3',
      'imagePath': 'assets/proto.jpg',
    },
    {
      'title': 'BIM Lab (2348)',
      'description': 'It is utilized by construction management students and was specially designed and constructed by our faculty',
      'icon': Icons.school,
      'audioPath': 'sounds/stop10-mmr-building-information-modeling-laboratory.mp3',
      'imagePath': 'assets/q3.png',
    },  
    {
      'title': 'Annex/Drilling Fluids Lab (2147)',
      'description': 'It contains numerous chemical engineering laboratories spread throughout its three floors',
      'icon': Icons.school,
      'audioPath': 'sounds/stop12a-engineering-annex-intro.mp3',
      'imagePath': 'assets/q5.png',
    },  
    {
      'title': 'Civil Engineering Driving Simulator Lab (2215)',
      'description': 'Allows students and faculty to research driving behaviors, environments, and traffic',
      'icon': Icons.school,
      'audioPath': 'sounds/stop13-civilengineering-driving-simulator-laboratory.mp3',
      'imagePath': 'assets/q6.png',
    },  
    {
      'title': 'Brookshire Student Services Suite (2228)',
      'description': 'Guide to student services and amenities',
      'icon': Icons.school,
      'audioPath': 'sounds/stop14-thedr.william-a-brookshire-student-services-suite.mp3',
      'imagePath': 'assets/p9.png',
    },  
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fadeController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playAudio(int index) async {
    if (currentlyPlayingIndex == index) {
      if (isPlaying) {
        await audioPlayer.pause();
      } else {
        await audioPlayer.resume();
      }
      setState(() {
        isPlaying = !isPlaying;
      });
    } else {
      if (currentlyPlayingIndex != null) {
        await audioPlayer.stop();
      }
      await audioPlayer.play(AssetSource(audioTracks[index]['audioPath']));
      setState(() {
        currentlyPlayingIndex = index;
        isPlaying = true;
      });
    }
  }

  void _showImagePopup(BuildContext context, int index) {
    final track = audioTracks[index];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              height: 4,
              width: 40,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      track['imagePath'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    track['title'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF461D7C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    track['description'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                          color: const Color(0xFF461D7C),
                          size: 50,
                        ),
                        onPressed: () => playAudio(index),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Color(0xFF461D7C),
                          size: 30,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xFF461D7C),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                'PFT Audio Guide',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF461D7C),
                          const Color(0xFF461D7C).withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PFT Building Guide',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${audioTracks.length} audio stops available',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final track = audioTracks[index];
                  final isCurrentlyPlaying = currentlyPlayingIndex == index;
                  
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: GestureDetector(
                        onTapDown: (_) => _animationController.forward(),
                        onTapUp: (_) => _animationController.reverse(),
                        onTapCancel: () => _animationController.reverse(),
                        onTap: () => _showImagePopup(context, index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: isCurrentlyPlaying ? 15 : 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: isCurrentlyPlaying
                                    ? [Colors.purple[50]!, Colors.white]
                                    : [Colors.white, Colors.white],
                              ),
                            ),
                            child: Stack(
                              children: [
                                if (isCurrentlyPlaying && isPlaying)
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF461D7C),
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.volume_up,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          color: isCurrentlyPlaying
                                              ? const Color(0xFF461D7C)
                                              : Colors.purple[100],
                                          borderRadius: BorderRadius.circular(32),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.purple.withOpacity(0.2),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          track['icon'],
                                          color: isCurrentlyPlaying
                                              ? Colors.white
                                              : const Color(0xFF461D7C),
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AnimatedDefaultTextStyle(
                                              duration: const Duration(milliseconds: 200),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: isCurrentlyPlaying
                                                    ? const Color(0xFF461D7C)
                                                    : Colors.black87,
                                              ),
                                              child: Text(track['title']),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              track['description'],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                                height: 1.4,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 200),
                                        child: Icon(
                                          isCurrentlyPlaying && isPlaying
                                              ? Icons.pause_circle_filled
                                              : Icons.play_circle_filled,
                                          key: ValueKey<bool>(isCurrentlyPlaying && isPlaying),
                                          color: const Color(0xFF461D7C),
                                          size: 45,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: audioTracks.length,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, color: Color(0xFF461D7C)),
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
            currentIndex: 0,
            selectedItemColor: const Color(0xFF461D7C),
            onTap: (index) {
              if (index == 0) {
                Navigator.pop(context);
              } else if (index == 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Mapscreen()),
                );
              } else if (index == 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Helpscreen()),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
