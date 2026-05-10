import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/models/apod_model.dart';

class DetailScreen extends StatelessWidget {
  final ApodModel apod;

  const DetailScreen({super.key, required this.apod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: CustomScrollView(
        slivers: [
          // Hero Image with Zoom
          SliverAppBar(
            expandedHeight: 500,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.network(
                  apod.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    apod.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(),

                  const SizedBox(height: 8),
                  Text(
                    apod.date,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Explanation",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    apod.explanation,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.7,
                      color: Colors.white70,
                    ),
                  ),

                  if (apod.copyright != null) ...[
                    const SizedBox(height: 30),
                    Text(
                      "© ${apod.copyright}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}