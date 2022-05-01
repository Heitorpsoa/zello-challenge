import 'package:flutter/material.dart';

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.05),
      child: Column(children: [
        Text('PixStar', style: Theme.of(context).textTheme.headline2),
        Text('A melhor forma de Zelar por seus contatos Pix', style: Theme.of(context).textTheme.headline6),
      ]),
    );
  }
}
