import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({Key? key, this.action, this.text = '', this.height= 50, this.width= 300, this.radius = 10.0}) : super(key: key);
  final String text;
  final double height;
  final double width;
  final double radius;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return Align(
        child: Container(
          height: height,
          width: width,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent, borderRadius: BorderRadius.circular(radius)),
          child: ElevatedButton(
            onPressed: action,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),
        ));
  }
}