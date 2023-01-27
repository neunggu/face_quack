import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:face_quack/src/models/face.dart';

class Login extends StatefulWidget  {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var face = context.read<FaceModel>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 0),
          child: Column(
            children: [
              Text(
                'Face Quack',
                style: Theme.of(context).textTheme.displayLarge
                    ?.merge(TextStyle(height:5)),
              ),
              SizedBox(
                width: 250,
                child: TextFormField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: 'Nickname',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.all(30),
                child: ElevatedButton(
                  onPressed: () {
                    var name = _textController.text;
                    if(name.length > 0) {
                      face.nickname = name;
                      Navigator.pushNamed(context,'/home');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('ENTER'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
