
import 'package:chat/components/rounded_button.dart';
import 'package:chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../constants.dart';
class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({super.key});
  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation  animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync:this,
    );

    animation = ColorTween(
        begin: Colors.blueGrey,
        end: Colors.white
    ).animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 60,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  AnimatedTextKit(
                    animatedTexts:[
                      TypewriterAnimatedText(
                          'Flash Chat',
                          speed:Durations.short3,
                          curve: Curves.bounceIn,
                          textAlign: TextAlign.center,
                          textStyle: animateKitTextStyle
                      ),
                    ] ,
                  )
                ]
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                title:  'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }
            ),
            RoundedButton(
                title:'Register',
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }
            ),
          ],
        ),
      ),
    );
  }
}