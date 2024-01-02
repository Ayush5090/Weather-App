import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/screens/home_screen.dart';
import 'package:weather_app/res/assets/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late var slideTween;
  bool initiateLocationAnim = false;
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(GetLocation());

    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800))
      ..forward();
    slideTween = Tween(begin: 300.0, end: 0.0).animate(
        CurvedAnimation(parent: _animController, curve: Curves.bounceOut));

    _animController.addListener(() {
      if (_animController.isCompleted) {
        setState(() {
          initiateLocationAnim = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is LocationState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
          }
        },
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0XFF000046),
                Color(0XFF00c6ff),
              ])),
          child: initiateLocationAnim
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(AppAssets.fetchLocation,
                        width: 150, height: 150),
                    Animate(
                      child: Text(
                        'Getting your location',
                        style: GoogleFonts.raleway(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ).animate().flip(duration: const Duration(seconds: 1)),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                        animation: slideTween,
                        builder: (context, child) {
                          return Transform.translate(
                              offset: Offset(slideTween.value, 0),
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: size.width * 0.75,
                                height: size.width * 0.75,
                              ));
                        }),
                    Animate(
                        child: const Text(
                      'Weather App',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ).animate().fade(duration: const Duration(seconds: 1))),
                  ],
                ),
        ),
      ),
    );
  }
}
