
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String question;
  final String answer;

  const DetailPage({super.key, required this.answer, required this.question});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DetailPage();
  }
}

class _DetailPage extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.question),
            Text(widget.answer),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                }, 
                child: const Text('돌아가기')
            )
          ],
        ),  
      ),
    );
  }
  
}