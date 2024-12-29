import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

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
              emissionFrequency: 0.5,
              // numberOfParticles: 10,
              shouldLoop: true,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
            ),
          ),
        ],
      ),
    );
  }
}
