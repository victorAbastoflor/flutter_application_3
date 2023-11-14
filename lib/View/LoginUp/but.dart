import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/LoginUp/buttonAnimate.dart';

class AppButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SwitchButton(),
    );
  }
}

class SwitchButton extends StatefulWidget {
  SwitchButton({Key? key}) : super(key: key);

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  int _toggleValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toggle Button'),
        elevation: 10,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedToggle(
              values: ['English', 'Arabic'],
              onToggleCallback: (value) {
                setState(() {
                  _toggleValue = value;
                });
              },
              buttonColor: const Color(0xFF0A3157),
              backgroundColor: const Color(0xFFB5C1CC),
              textColor: const Color(0xFFFFFFFF),
            ),
            Text('Toggle Value : $_toggleValue'),
          ],
        ),
      ),
    );
  }
}
