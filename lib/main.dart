import 'dart:async';
import  'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home:TimerClockApp(),));


class TimerClockApp extends StatefulWidget {
  const TimerClockApp({Key? key}) : super(key: key);

  @override
  _TimerClockAppState createState() => _TimerClockAppState();
}

class _TimerClockAppState extends State<TimerClockApp> {

  static const duration = Duration(seconds: 1);

  int secondPassed = 0;
  bool isActive = false;

// to reset the timer
  void _stopCountDown(){

    Timer.periodic(const Duration(milliseconds: 1 ), (timer) {

        timer.cancel();
    });

  }

 //to start/stop the timer
  void _startCountDown(){
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isActive) {
        setState(() {
          timeleft ++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  int timeleft=0;
  double percent =0.0;
   Timer? timer;
  @override

  Widget build(BuildContext context) {

    int seconds = secondPassed % 60;
    int minutes = secondPassed ~/ 60;
    int hours =secondPassed ~/ (60 * 60);
    final String label;
    int value=5;
    return SafeArea(
       child: Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
          title:const  Text(
            "Simple timer"
          ),
          centerTitle: false,
        ),

          body: Center(
            child: Column(
             children:  [
               Expanded(child: CircularPercentIndicator(
                circularStrokeCap:CircularStrokeCap.round,
                percent: percent/100,
                animation: true,
                animateFromLastPercent: true,
                radius: 350.0,
                lineWidth: 15.0,
                progressColor: Colors.white,
                center :  Text(
                    timeleft.toString(),
                    style: const TextStyle(
                      color:Colors.white,
                      fontSize:59,
                    )),

              )
                ,

              ),
              Container(
                  margin: EdgeInsets.only(bottom: 100),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            child: Text(isActive ? 'STOP': 'START'),
                            color: Colors.grey,
                            textColor: Colors.white70,
                            onPressed: () {
                              setState(() {
                                _startCountDown();

                                isActive = !isActive;
                              });
                            },
                          ),
                          RaisedButton(
                            child: Text('RESET'),
                            color: Colors.pinkAccent,
                            textColor: Colors.white70,
                            onPressed: () {
                              setState(() {
                                isActive = false;
                                timeleft= 0;
                                _stopCountDown();

                              });
                            },
                          ),
                        ],
                      )
                    ],
                  )
              ),
            ],
          ),),
      ),
    );


  }
}