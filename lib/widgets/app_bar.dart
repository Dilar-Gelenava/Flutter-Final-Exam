import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    Key? key,
    this.action,
    this.text = '',
  }) : super(key: key);
  final String text;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[Color(0xff525252), Color(0xff3d72b4)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
      ),
      title: const Center(
        child: Text(
          'Personal Expenses',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
      elevation: 0,
    );
  }
}
