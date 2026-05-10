import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_background/animated_background.dart';
import '../../data/models/apod_model.dart';
import '../../data/repositories/nasa_repository.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Add this mixin here
class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final NasaRepository _repo = NasaRepository();
  late Future<List<ApodModel>> _apodsFuture;

  @override
  void initState() {
    super.initState();
    _apodsFuture = _repo.getMultipleApods(count: 6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,   // Important
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Nasa Cosmos",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withOpacity(0.1),
              child: const Icon(Icons.notifications_outlined, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withOpacity(0.1),
              child: const Icon(Icons.menu, color: Colors.white),
            ),
          ),
        ],
      ),

      // This is where we wrap everything with AnimatedBackground
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            baseColor: Colors.cyanAccent,
            spawnOpacity: 0.0,
            opacityChangeRate: 0.25,
            minOpacity: 0.1,
            maxOpacity: 0.4,
            particleCount: 100,
            spawnMaxRadius: 4,
            spawnMaxSpeed: 80,
            spawnMinSpeed: 20,
            spawnMinRadius: 2.0,
          ),
        ),
        vsync: this,
        child: FutureBuilder<List<ApodModel>>(
          future: _apodsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.purpleAccent));
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            final apods = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Greeting
                  const Row(
                    children: [
                      CircleAvatar(radius: 28, backgroundImage: AssetImage('assets/images/astronaut.png')),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome!", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                          Text("Good to see you", style: TextStyle(color: Colors.grey, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Category Circles
                  SizedBox(
                    height: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCategoryCircle("Nebula", "assets/images/nebula.png"),
                        _buildCategoryCircle("Galaxies", "assets/images/galaxies.png"),
                        _buildCategoryCircle("Stars", "assets/images/stars.png"),
                        _buildCategoryCircle("Planets", "assets/images/planets.png"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Explore Cosmic Moments", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),

                    ],
                  ),

                  const SizedBox(height: 16),

                  // Cards Grid (same as before)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.82,
                    ),
                    itemCount: apods.length,
                    itemBuilder: (context, index) {
                      final apod = apods[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => DetailScreen(apod: apod)),
                          );
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(apod.url, fit: BoxFit.cover),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Colors.transparent, Colors.black87],
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(apod.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
                                      Text(apod.date, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryCircle(String label, String imagePath) {
    return Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundImage: AssetImage(imagePath),
          backgroundColor: Colors.transparent,
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import '../../data/models/apod_model.dart';
// import '../../data/repositories/nasa_repository.dart';
// import 'detail_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final NasaRepository _repo = NasaRepository();
//   late Future<List<ApodModel>> _apodsFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _apodsFuture = _repo.getMultipleApods(count: 6);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0B0E2B),
//       body: FutureBuilder<List<ApodModel>>(
//         future: _apodsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           }
//
//           final apods = snapshot.data!;
//
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 60),
//
//                   // Greeting
//                   const Row(
//                     children: [
//                       CircleAvatar(backgroundImage: AssetImage('assets/images/astronaut.png')), // add image later
//                       SizedBox(width: 12),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Hello, Explorer! 👋", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                           Text("Discover the Universe", style: TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 30),
//
//                   // Category Circles
//                   SizedBox(
//                     height: 100,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: 4,
//                       itemBuilder: (context, index) {
//                         final labels = ["Nebula", "Galaxies", "Stars", "Planets"];
//                         final colors = [Colors.purple, Colors.blue, Colors.orange, Colors.teal];
//                         return Padding(
//                           padding: const EdgeInsets.only(right: 16),
//                           child: Column(
//                             children: [
//                               CircleAvatar(radius: 32, backgroundColor: colors[index]),
//                               const SizedBox(height: 8),
//                               Text(labels[index]),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   // Explore Section
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Explore Cosmic Moments", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
//                       Text("See all"),
//                     ],
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   // Cards Grid
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                       childAspectRatio: 0.85,
//                     ),
//                     itemCount: apods.length,
//                     itemBuilder: (context, index) {
//                       final apod = apods[index];
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => DetailScreen(apod: apod),
//                             ),
//                           );
//                         },
//                         child: Card(
//                           clipBehavior: Clip.antiAlias,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                           child: Stack(
//                             fit: StackFit.expand,
//                             children: [
//                               Image.network(apod.url, fit: BoxFit.cover),
//                               Positioned(
//                                 bottom: 0,
//                                 left: 0,
//                                 right: 0,
//                                 child: Container(
//                                   padding: const EdgeInsets.all(12),
//                                   decoration: const BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [Colors.transparent, Colors.black87],
//                                     ),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(apod.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                                       Text(apod.date, style: const TextStyle(color: Colors.white70, fontSize: 12)),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import '../../data/models/apod_model.dart';
// import '../../data/repositories/nasa_repository.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final NasaRepository _repository = NasaRepository();
//   late Future<ApodModel>? _apodFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadApod();
//   }
//
//   void _loadApod() {
//     setState(() {
//       _apodFuture = _repository.getTodayApod();
//     });
//   }
//
//   Future<void> _refresh() async {
//     _loadApod();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0A0A0A),
//       body: RefreshIndicator(
//         onRefresh: _refresh,
//         child: FutureBuilder<ApodModel>(
//           future: _apodFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator(color: Colors.purpleAccent));
//             }
//
//             if (snapshot.hasError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.error, size: 80, color: Colors.red),
//                     Text(snapshot.error.toString()),
//                     ElevatedButton(onPressed: _refresh, child: const Text("Retry")),
//                   ],
//                 ),
//               );
//             }
//
//             final apod = snapshot.data!;
//
//             return CustomScrollView(
//               slivers: [
//                 // Hero Image with Overlay
//                 SliverAppBar(
//                   expandedHeight: 420,
//                   pinned: true,
//                   backgroundColor: Colors.transparent,
//                   flexibleSpace: FlexibleSpaceBar(
//                     background: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Image.network(
//                           apod.url,
//                           fit: BoxFit.cover,
//                         ),
//                         Container(
//                           decoration: const BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [Colors.transparent, Colors.black87],
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 40,
//                           left: 20,
//                           right: 20,
//                           child: Text(
//                             apod.title,
//                             style: const TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ).animate().fadeIn(duration: 600.ms),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           apod.date,
//                           style: const TextStyle(fontSize: 18, color: Colors.grey),
//                         ),
//                         const SizedBox(height: 20),
//
//                         // Category Chips (Adaptation from your inspo)
//                         SizedBox(
//                           height: 50,
//                           child: ListView(
//                             scrollDirection: Axis.horizontal,
//                             children: const [
//                               Chip(label: Text("Astronomy")),
//                               SizedBox(width: 12),
//                               Chip(label: Text("Space")),
//                               SizedBox(width: 12),
//                               Chip(label: Text("NASA")),
//                               SizedBox(width: 12),
//                               Chip(label: Text("Universe")),
//                             ],
//                           ),
//                         ),
//
//                         const SizedBox(height: 30),
//
//                         // Explanation
//                         const Text(
//                           "About this Image",
//                           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           apod.explanation,
//                           style: const TextStyle(height: 1.6, color: Colors.white70),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
