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

  @override
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.slowMiddle,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
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
          AnimatedPositioned(
            top: 0,
            left: 0,
            right: 0,
            duration: const Duration(seconds: 3),
            child: Center(
              child: Container(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
