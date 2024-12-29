import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fireworks/flutter_fireworks.dart';

class HappyNewYearPage extends StatefulWidget {
  const HappyNewYearPage({super.key});

  @override
  State<HappyNewYearPage> createState() => _HappyNewYearPageState();
}

class _HappyNewYearPageState extends State<HappyNewYearPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  ConfettiController _confettiController = ConfettiController();
  bool showImage = false;
  final FireworksController _fireworksController = FireworksController(
    colors: const [
      Color(0xFFFF4C40), // Coral
      Color(0xFF6347A6), // Purple Haze
      Color(0xFF7FB13B), // Greenery
      Color(0xFF82A0D1), // Serenity Blue
      Color(0xFFF7B3B2), // Rose Quartz
      Color(0xFF864542), // Marsala
      Color(0xFFB04A98), // Orchid
      Color(0xFF008F6C), // Sea Green
      Color(0xFFFFD033), // Pastel Yellow
      Color(0xFFFF6F7C), // Pink Grapefruit
    ],
    minExplosionDuration: 0.5,
    maxExplosionDuration: 1.5,
    maxParticleCount: 100,
    fadeOutDuration: .4,
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    // Afficher l'image d'abord
    Future.delayed(
      const Duration(
        milliseconds: 700,
      ),
      () {
        setState(() {
          showImage = true;
        });
      },
    );
    //lancer les confetits
    Future.delayed(
      const Duration(seconds: 2),
      () {
        _confettiController.play();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 2, 21, 36),
                  Color.fromARGB(255, 1, 15, 25),
                  Color.fromARGB(255, 0, 10, 20),
                  Color.fromARGB(255, 1, 15, 25),
                  Color.fromARGB(255, 2, 21, 36),
                ],
                stops: [0.0, 0.3, 0.5, 0.7, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SlideTransition(
            position: _offsetAnimation,
            child: Center(
              child: Image.asset(
                'assets/images/happy_new_year.png',
                width: 300,
                height: 300,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0.4,
              // numberOfParticles: 10,
              shouldLoop: true,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ),
          FireworksDisplay(controller: _fireworksController),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () => _fireworksController.fireMultipleRockets(
            minRockets: 5,
            maxRockets: 15,
            launchWindow: const Duration(milliseconds: 600),
          ),
          tooltip: 'Fire Multiple Rockets 🔥',
          shape: const CircleBorder(),
          backgroundColor: Colors.white.withOpacity(0.6),
          foregroundColor: Colors.black,
          child: const Icon(Icons.keyboard_double_arrow_up_rounded, size: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 44,
        color: Colors.white.withOpacity(.05),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () => _fireworksController.fireSingleRocket(
                color: Colors.pinkAccent,
                rocketColor: Colors.pinkAccent,
              ),
              icon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.pinkAccent,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () => _fireworksController.fireSingleRocket(
                color: Colors.blueAccent,
                rocketColor: Colors.blueAccent,
              ),
              icon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.blueAccent,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () => _fireworksController.fireSingleRocket(
                color: Colors.greenAccent,
                rocketColor: Colors.greenAccent,
              ),
              icon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.greenAccent,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () => _fireworksController.fireSingleRocket(
                color: Colors.amberAccent,
                rocketColor: Colors.amberAccent,
              ),
              icon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.amberAccent,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
