import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  late Timer timer;
  int totalPomodoros = 0;
  bool isRunning = false;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  void onStartPressd() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressd() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onStopPressd() {
    timer.cancel();
    setState(() {
      isRunning = false;
      totalSeconds = twentyFiveMinutes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  format(totalSeconds),
                  style: TextStyle(
                    fontSize: 89,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).cardColor,
                  ),
                ),
              )),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: isRunning ? onPausePressd : onStartPressd,
                  iconSize: 100,
                  color: Theme.of(context).cardColor,
                  icon: Icon(
                    isRunning
                        ? Icons.pause_circle_outlined
                        : Icons.play_circle_outline,
                  ),
                ),
                IconButton(
                  onPressed: onStopPressd,
                  iconSize: 100,
                  color: Theme.of(context).cardColor,
                  icon: Icon(
                    totalSeconds < twentyFiveMinutes
                        ? Icons.stop_circle_outlined
                        : null,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pomodoros',
                            style: TextStyle(
                              fontSize: 20,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '$totalPomodoros',
                            style: TextStyle(
                              fontSize: 58,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
