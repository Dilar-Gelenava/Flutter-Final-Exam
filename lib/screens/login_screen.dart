import 'package:flutter/material.dart';
import 'package:expenses/widgets/main_button.dart';

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Color(0xff525252), Color(0xff3d72b4)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          title: const Center(
            child: Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          ),
          elevation: 0,
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, _) {
            return Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/image_2.png'),
                  SizedBox(
                    width: 300.0,
                    child: Container(
                      child: const Text("please enter your name",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900)),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.lightBlueAccent),
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const MainButton(
                    text: 'Log In',
                  ),
                ],
              ),
            );
          },
        ));
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
