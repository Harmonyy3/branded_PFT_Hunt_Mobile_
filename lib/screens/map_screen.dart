import 'package:flutter/material.dart';

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



