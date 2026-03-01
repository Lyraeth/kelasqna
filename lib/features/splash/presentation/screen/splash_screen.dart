import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(2.seconds, () => _sessionEventStarted());
    });
  }

  void _sessionEventStarted() {
    context.read<SessionsBloc>().add(const SessionsEvent.started());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Animate(
              delay: 200.milliseconds,
              effects: [
                ScaleEffect(delay: 200.milliseconds, duration: 1.seconds),
              ],
              child: Icon(Icons.school, size: 72),
            ),
            Animate(
              delay: 200.milliseconds,
              effects: [
                ScaleEffect(delay: 200.milliseconds, duration: 1.seconds),
              ],
              child: Text(
                "KelasQNA",
                style: context.text.headlineMedium?.copyWith(
                  color: context.colors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ].separatedBy(24.h),
        ),
      ),
    );
  }
}
